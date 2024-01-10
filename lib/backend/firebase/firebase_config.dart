import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAbfyCY9EPjBX97e3TB4jF7zbO9JBjKcIY",
            authDomain: "silver-65166.firebaseapp.com",
            projectId: "silver-65166",
            storageBucket: "silver-65166.appspot.com",
            messagingSenderId: "622357353461",
            appId: "1:622357353461:web:e813da7538df9023b4c6bc",
            measurementId: "G-4FS3T4EYDB"));
  } else {
    await Firebase.initializeApp();
  }
}
