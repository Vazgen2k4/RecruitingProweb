import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class OurUser {
  late String email;
  late String name;
  late String imgUrl;
  late bool nightTheme;
  late bool gridOnDir;
  late bool gridOnStages;
  late int roots;
  late String id;
  BuildContext? routContext; 
  

  // Конструктор создания
  OurUser({
    this.id = '',
    this.roots = -1,
    this.nightTheme = false,
    this.gridOnStages = false,
    this.gridOnDir = false,
    this.email = '',
    this.name = '',
    this.imgUrl = '',
  });

  void setSettings({required User user}) {
    this.email = user.email!;
    this.name = user.displayName!;
    this.imgUrl = user.photoURL!;
    // clearUserData();
  }

  // Функция очистки при выходе
  void clearUserData() {
    this.id = '';
    this.roots = -1;
    this.nightTheme = false;
    this.gridOnStages = false;
    this.gridOnDir = false;
    this.name = '';
    this.imgUrl = '';
  }
}
