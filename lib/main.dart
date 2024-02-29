import 'package:esacc_task/core/injection/di_container.dart';
import 'package:esacc_task/features/app/app.dart';
import 'package:esacc_task/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
  );
  FlutterBluePlus.setLogLevel(LogLevel.verbose, color: true);
  ServiceLocator().init();
  runApp(const MyApp());
}

