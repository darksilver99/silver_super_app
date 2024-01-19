import 'package:flutter/scheduler.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:silver_super_app/auth/firebase_auth/auth_util.dart';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'mini_app_page_model.dart';
export 'mini_app_page_model.dart';

class MiniAppPageWidget extends StatefulWidget {
  const MiniAppPageWidget({
    super.key,
    required this.appName,
    required this.appPath,
  });

  final String? appName;
  final String? appPath;

  @override
  _MiniAppPageWidgetState createState() => _MiniAppPageWidgetState();
}

class _MiniAppPageWidgetState extends State<MiniAppPageWidget> {
  late MiniAppPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final InAppLocalhostServer localhostServer = InAppLocalhostServer();
  InAppWebViewController? _webViewController;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MiniAppPageModel());

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await localhostServer.start();
    });
  }

  @override
  void dispose() {
    _model.dispose();

    localhostServer.close();

    super.dispose();
  }

  Future<String> getFlutterText() async {
    await Future.delayed(const Duration(seconds: 2));
    return "aaaa";
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus ? FocusScope.of(context).requestFocus(_model.unfocusNode) : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            valueOrDefault<String>(
              widget.appName,
              '-',
            ),
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Plus Jakarta Sans',
                  color: Colors.white,
                  fontSize: 22.0,
                ),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse("http://localhost:8080${widget.appPath}")),
            onWebViewCreated: (controller) {
              _webViewController = controller;
              controller.setOptions(
                options: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    cacheEnabled: true,
                    supportZoom: false
                  ),
                ),
              );
            },
            onLoadStart: (controller, url) {
              print("onLoadStart : $url");
              controller.setOptions(
                options: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                      cacheEnabled: true,
                      supportZoom: false
                  ),
                ),
              );
            },
            onLoadStop: (controller, url) {
              print("onLoadStop : $url");
              controller.setOptions(
                options: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                      cacheEnabled: true,
                      supportZoom: false
                  ),
                ),
              );
              controller.addJavaScriptHandler(
                handlerName: "getUserData",
                callback: (args) async {
                  return {
                    "email": currentUserDocument!.email,
                    "uid": currentUserReference!.id,
                  };
                },
              );
            },
            onConsoleMessage: (controller, msg) {
              print("onConsoleMessage");
              print(msg);
            },
          ),
        ),
      ),
    );
  }
}
