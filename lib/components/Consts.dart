import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:recruting_proweb/components/OurUser.dart';

// База данных:
// Данные всех пользователей
final users = FirebaseFirestore.instance.collection('users');
// Данные всех направленний
final directions = FirebaseFirestore.instance.collection('directions');
// Данные всех этапах
final stages = FirebaseFirestore.instance.collection('stages');

// Права пользователя
// Текущий пользователь
OurUser user = OurUser();

final Color primaryColor = Color.fromRGBO(34, 34, 34, 1);
final Color textColor = Colors.white;

final Color btnTapColor = Color.fromRGBO(72, 157, 76, 0.6);
final Color linkTapColor = Color.fromRGBO(221, 238, 253, 0.7);
final Color driverBgColor = Color.fromRGBO(237, 245, 251, 1);
final Color textEnabelColor = Color.fromRGBO(0, 0, 0, 0.24);
final Color appBarColor = Color.fromRGBO(196, 196, 196, 0.1);

final double _iconSize = 30;
// Роли в текстовом формате
// ignore: non_constant_identifier_names
final List<String> RoleText = ['Ban', 'User', 'Admin'];
// Роли в иконочном формате
// ignore: non_constant_identifier_names
final List<Widget> Role = [
  Icon(Icons.highlight_off_outlined, color: primaryColor, size: _iconSize),
  Icon(Icons.perm_identity_outlined, color: primaryColor, size: _iconSize),
  Icon(Icons.verified_outlined, color: primaryColor, size: _iconSize),
];

// Тень для окон
final List<BoxShadow> formShadow = [
  BoxShadow(
    color: textEnabelColor,
    offset: Offset(0, 3),
    blurRadius: 6,
  ),
  BoxShadow(
    color: textEnabelColor,
    offset: Offset(3, 0),
    blurRadius: 6,
  ),
];

// Возврат к профилю (Галвная страница)
Widget goProfile({BuildContext? context, String? url}) {
  return InkWell(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      width: 50,
      height: 50,
      child: CircleAvatar(
        backgroundImage: NetworkImage(url!),
      ),
    ),
    onTap: () {
      Navigator.of(context!).pushNamedAndRemoveUntil('/', (route) => false);
    },
  );
}

// Шаблон Кнопки для настройки прав
Widget _settingsRootBtn(String email, int index, BuildContext context) {
  // Функция выполнения Кнопки настройки прав
  void _settingsRootBtnAction() async {
    var info = await users.where('email', isEqualTo: email).get();
    var id = info.docs.first.id;
    await users.doc(id).update({'roots': index});
    Navigator.pop(context);
  }

  return Material(
    color: Colors.transparent,
    child: ListTile(
      onTap: _settingsRootBtnAction,
      leading: Role[index],
      title: Text(
        RoleText[index],
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
      ),
    ),
  );
}

// Кнопки настройки прав
Widget userSettingsRoots(String email, BuildContext context) {
  return Container(
    child: Column(
      children: <Widget>[
        _settingsRootBtn(email, 0, context),
        _settingsRootBtn(email, 1, context),
        _settingsRootBtn(email, 2, context),
      ],
    ),
  );
}

// request.time < timestamp.date(2021, 9, 6);

// Функция для вывода в консоль текста с рамками
void borderPrint(text) {
  print('============================================================================================================================');
  print(text);
  print('============================================================================================================================');
}
