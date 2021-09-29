import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:recruting_proweb/components/MyContainer.dart';
import 'package:recruting_proweb/provider/google_sigin_in.dart';
import '../components/Consts.dart';

// Страница авторизации
class Authorization extends StatefulWidget {
  const Authorization({Key? key}) : super(key: key);

  @override
  _AuthorizationState createState() => _AuthorizationState();
}

class _AuthorizationState extends State<Authorization> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    Widget _button(String text, void func(), {bool hasIcon = false}) {
      return Container(
        width: 221,
        child: Material(
          color: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: primaryColor),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            hoverColor: Theme.of(context).primaryColor,
            splashColor: btnTapColor,
            onTap: () {
              func();
            },
            child: Container(
              height: 50,
              padding: EdgeInsets.only(left: 23, top: 5, right: 30, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FaIcon(
                    FontAwesomeIcons.google,
                    size: 30,
                    color: primaryColor,
                  ),
                  SizedBox(width: 10),
                  Text(
                    text,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Lato',
                      fontSize: 18,
                      color: primaryColor,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    void _buttonActionWithGoogle() async {
      try {
        final provider =
            Provider.of<GoogleSignInProvider>(context, listen: false);
        await provider.googleLogin();

        var info =
            await users.where('email', isEqualTo: provider.user.email).get();

        user.id = info.docs.isEmpty ? '' : info.docs.first.id;

        if (user.id == '') {
          var newUser = await users.add({
            'email': provider.user.email,
            'name': provider.user.displayName,
            'imgUrl': provider.user.photoUrl,
            'nightTheme': false,
            'gridOnDir': false,
            'gridOnStages': false,
            'roots': 0,
          });
          user.id = newUser.id;
        }
      } catch (e) {
        borderPrint('Данные не полученны');
      }
    }

    Widget _form() {
      return Container(
        padding: EdgeInsets.only(left: 33, right: 33, top: 40, bottom: 40),
        height: 210,
        width: MediaQuery.of(context).size.width >= 386
            ? 386
            : MediaQuery.of(context).size.width - 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.00),
          color: Theme.of(context).primaryColor,
          boxShadow: formShadow,
        ),
        child: Column(
          children: [
            Text(
              'PROWEB',
              style: TextStyle(
                color: primaryColor,
                fontSize: 40,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 20),
            _button('Авторизация', _buttonActionWithGoogle, hasIcon: true),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: MyContainer(
        child: Center(
          child: _form(),
        ),
      ),
    );
  }
}
