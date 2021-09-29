import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:recruting_proweb/provider/google_sigin_in.dart';
import 'package:recruting_proweb/components/Consts.dart';

// Левое выезжающее меню
// ignore: must_be_immutable
class LeftMenu extends StatelessWidget {
  LeftMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String curentRoute = ModalRoute.of(context)!.settings.name!;

    // Шаблон кнопки меню
    Widget _menuItem({
      // Текст кнопки
      required String text,
      // Функция выхода
      Function? exit,
      // Передача роута
      String link = '/',
      // Передача текущей иконки
      required IconData icon,
    }) {
      // Рендер кнопки
      return ListTile(
        // Иконка
        leading: Icon(icon, color: Colors.black),
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        horizontalTitleGap: 0,
        minVerticalPadding: 5,
        tileColor: curentRoute == link && exit == null ? linkTapColor : null,
        hoverColor: linkTapColor,
        // Бордер радиус кнопки
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(300),
            topRight: Radius.circular(300),
          ),
        ),
        // Текст кнопки
        title: Text(
          text,
          style: TextStyle(
            color: primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        // Функция При обычном нажатии кнопки
        onTap: exit != null
            ? () {
                exit();
              }
            : curentRoute != link
                ? () {
                    Navigator.of(context).pushNamed(link);
                  }
                : null,
      );
    }

    // Сама менюшка
    return Drawer(
      backgroundColor: driverBgColor,
      // Лис с контентом (Для прокрутки)
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Шапка с логотипом
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 10,
                    bottom: 5,
                    left: 30,
                  ),
                  child: Text(
                    'PROWEB',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                // Разделительная полоса
                Divider(),
                // Навигационный список
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Column(
                    children: <Widget>[
                      if (user.roots > 0)
                        _menuItem(
                          link: '/directions',
                          text: 'Направления',
                          icon: Icons.verified_user_outlined,
                        ),
                      SizedBox(height: 5),
                      if (user.roots > 0)
                        _menuItem(
                          link: '/stages',
                          text: 'Этапы',
                          icon: Icons.assignment_outlined,
                        ),
                      SizedBox(height: 5),
                      if (user.roots == 2)
                        _menuItem(
                          link: '/users',
                          text: 'Список пользователей',
                          icon: Icons.people_alt_outlined,
                        ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: _menuItem(
                    text: 'Выход',
                    icon: Icons.logout_outlined,
                    // Функция выхода (Асинхронная)
                    exit: () async {
                      final provider = Provider.of<GoogleSignInProvider>(
                        user.routContext!,
                        listen: false,
                      );
                      await provider.logout();
                      if (curentRoute != '/')
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil('/', (route) => false);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


/* _menuItem(
                text: 'Выход',
                icon: Icons.logout_outlined,
                // Функция выхода (Асинхронная)
                exit: () async {
                  final provider = Provider.of<GoogleSignInProvider>(
                    user.routContext!,
                    listen: false,
                  );
                  await provider.logout();
                  if (curentRoute != '/')
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                },
              ),
            ), */