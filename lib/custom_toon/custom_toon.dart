import 'dart:io';

import 'package:archive/archive.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:silver_super_app/app_state.dart';

checkPermission(url, appName, appIcon) async {
  if (Platform.isAndroid) {
    final deviceInfo = DeviceInfoPlugin();
    final info = await deviceInfo.androidInfo;
    print("info.version.release : ${info.version.release}");
    if (int.parse(info.version.release) >= 13) {
      return download(url, appName , appIcon);
    } else {
      var status = await Permission.storage.request();
      if (status.isGranted) {
        return download(url, appName , appIcon);
      }
    }
  } else {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      return download(url, appName , appIcon);
    }
  }
}

download(url, appName , appIcon) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    var dir = url.toString().split('/').last.replaceAll(".zip", "");
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    final outFile = File('${appDocumentsDir.path}/$dir.zip');
    await outFile.writeAsBytes(response.bodyBytes, flush: true);
    // print("outFile.path : ${outFile.path}");
    return unzipFile(outFile.path, dir, appName, url , appIcon);
  } else {
    throw Exception('Failed to download file: ${response.statusCode}');
  }
}

Future<Map<String, dynamic>> unzipFile(path, dir, appName, url , appIcon) async {
  final bytes = File(path).readAsBytesSync();
  final archive = ZipDecoder().decodeBytes(bytes);
  var unzipPath = path.toString().replaceAll('$dir.zip', '');
  // print("unzipPath : $unzipPath");
  for (final file in archive) {
    final fileName = '$unzipPath/${file.name}';
    // print("fileName : $fileName");
    if (file.isFile && !fileName.contains("__MACOSX")) {
      final outFile = File(fileName);
      await outFile.create(recursive: true);
      await outFile.writeAsBytes(file.content);
    }
  }
  var newPath = path.toString().replaceAll('.zip', '');
  return {"appName": appName, "appPath": "$newPath/index.html", "url": url, "appIcon": appIcon};
}

isInstall(url) {
  print(url);
  print(FFAppState().installedList);
  //bool containsUrl = dataList.any((map) => map['url'] == targetUrl);
  int index = FFAppState().installedList.indexWhere((map) => map['url'] == url);
  if (index != -1) {
    return FFAppState().installedList[index];
  }
  return null;
}
