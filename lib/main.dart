import 'package:contactlist/controller/contact_controller.dart';
import 'package:flutter/material.dart';
import 'app.dart';

late ContactController contactController;
Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  contactController = await ContactController.initOpenBox();
  runApp(const App());
}
