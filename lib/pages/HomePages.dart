import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recruting_proweb/components/Consts.dart';
import 'package:recruting_proweb/pages/ProfilePage.dart';
import 'authPage.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          user.routContext = context;
          // Проверка на загрузку
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            user.setSettings(user: FirebaseAuth.instance.currentUser!);
            return ProfilePage();
          } else if (snapshot.hasError) {
            return Center(child: Text('Что-то пошло не так'));
          } else {
            return Authorization();
          }
        },
      ),
    );
  }
}
