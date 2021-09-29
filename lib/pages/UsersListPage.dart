import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:recruting_proweb/components/DialogWindow.dart';
import 'package:recruting_proweb/components/LoadingWidget.dart';
import 'package:recruting_proweb/components/Consts.dart';
import 'package:recruting_proweb/components/RootsComplete.dart';

// ignore: must_be_immutable
class UsersListPage extends StatefulWidget {
  UsersListPage({Key? key}) : super(key: key);

  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  late List userList;

  @override
  void initState() {
    userList = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Получение данных с Firebase
    Future<List<dynamic>?> _getUsers(bool state) async {
      var usersData =
          await users.where('email', isNotEqualTo: user.email).get();

      if (state) {
        setState(() {
          userList = usersData.docs.toList();
        });
      } else {
        userList = usersData.docs.toList();
      }
      return userList;
    }

    Widget _userListItem({
      required String url,
      required String name,
      required int roots,
      required String email,
      void func()?,
      double emailSize = 14,
    }) {
      return ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(300)),
        ),
        onTap: func,
        onLongPress: func,
        // Аватарка пользователя
        leading: CircleAvatar(
          backgroundImage: NetworkImage(url),
          radius: 20,
        ),
        // Имя пользователя
        title: Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: primaryColor,
          ),
        ),
        // Почта пользователя
        subtitle: Text(
          email,
          style: TextStyle(
            fontSize: emailSize,
            fontWeight: FontWeight.w300,
            color: primaryColor,
          ),
        ),
        // Роль пользователя
        trailing: Role[roots],
      );
    }

    Widget _headerUserInfo() {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Stack(
          children: <Widget>[
            Material(
              color: Colors.transparent,
              child: Text(
                'PROWEB',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget _usersListBody(AsyncSnapshot snapshot) {
      return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: userList.length,
        itemBuilder: (context, i) {
          return _userListItem(
            name: userList[i]['name'],
            url: userList[i]['imgUrl'],
            roots: userList[i]['roots'],
            email: userList[i]['email'],
            func: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DialogWindow(
                    context: context,
                    windowWidth: 500,
                    // Шапка диалогового окна
                    header: _headerUserInfo(),
                    // Тело диалогового окна
                    body: Material(
                      color: Colors.transparent,
                      child: _userListItem(
                        name: userList[i]['name'],
                        url: userList[i]['imgUrl'],
                        roots: userList[i]['roots'],
                        email: userList[i]['email'],
                        emailSize: 11,
                      ),
                    ),
                    // Подвал диалогового окна
                    footer: userSettingsRoots(userList[i]['email'], context),
                  );
                },
              );
            },
          );
        },
      );
    }

    // setState(() {});
    return RootsComplete(
      secondStream: users.snapshots(),
      updateState: _getUsers,
      appbarTitle: 'Пользователи',
      load: Loading.list(),
      child: _usersListBody,
      condition: userList.isEmpty,
    );
  }
}
