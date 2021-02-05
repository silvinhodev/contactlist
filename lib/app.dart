import 'package:flutter/material.dart';
import 'view/contact_view.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contact List',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.deepPurpleAccent[700]),
      home: ContactListView(),
    );
  }
}
