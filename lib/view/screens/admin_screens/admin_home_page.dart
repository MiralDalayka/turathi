import 'package:flutter/material.dart';
import 'package:turathi/view/screens/admin_screens/widgets/buttons.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        centerTitle: true,
      ),
      body: Center(
        child: ListView.builder(
          itemCount:buttonsList.length ,
          itemBuilder: (context, index) {
          return buttonsList[index];

        }),
      ),
    );
  }
}


