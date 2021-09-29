import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:recruting_proweb/components/LoadingWidget.dart';
import 'package:recruting_proweb/components/Consts.dart';
import 'package:recruting_proweb/components/RootsComplete.dart';

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Получение текущего пользователя
  Future _getCurentUser(bool state) async {

    var userData =
        await users.where('email', isEqualTo: user.email).get();
    
      var userInfo = userData.docs.first;
      // borderPrint('text');

      if (state) {
        setState(() {
          user.roots = userInfo['roots'];
          user.nightTheme = userInfo['nightTheme'];
          user.gridOnDir = userInfo['gridOnDir'];
          user.gridOnStages = userInfo['gridOnStages'];
        });
      } else {
        user.roots = userInfo['roots'];
        user.nightTheme = userInfo['nightTheme'];
        user.gridOnDir = userInfo['gridOnDir'];
        user.gridOnStages = userInfo['gridOnStages'];
        return user;
      }
    // }
  }

  @override
  Widget build(BuildContext context) {
    Widget _button(String text, func()) {
      return TextButton(
        style: ButtonStyle(alignment: Alignment.center),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        onPressed: func,
      );
    }

    Widget _textInfo(String text) {
      return Text(
        text,
        style: TextStyle(
          fontSize: 18,
          color: primaryColor,
          fontWeight: FontWeight.w600,
        ),
      );
    }

    Widget _profileBody(AsyncSnapshot snapshot) {
      return ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          SizedBox(height: 20),
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.imgUrl),
                    radius: 75,
                  ),
                  SizedBox(height: 25),
                  _textInfo(user.name),
                  SizedBox(height: 10),
                  _textInfo(user.email),
                  SizedBox(height: 50),
                  _button('Направления', () {
                    Navigator.of(context).pushNamed('/directions');
                  }),
                  SizedBox(height: 10),
                  _button('Этапы', () {
                    Navigator.of(context).pushNamed('/stages');
                  }),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      );
    }

    return RootsComplete(
      secondStream: users.snapshots(),
      updateState: _getCurentUser,
      appbarTitle: 'Мой профиль',
      load: Loading.profile(),
      child: _profileBody,
      profileBtn: false,
      condition: false,
    );
  }
}
