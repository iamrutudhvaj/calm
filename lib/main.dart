import 'package:calm/app.dart';
import 'package:calm/services/shared_preference_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPreferenceService.init();
  runApp(MyApp());
}
