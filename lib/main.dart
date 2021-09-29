import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:recruting_proweb/components/Consts.dart';
import 'package:recruting_proweb/pages/DiractionsPage.dart';
import 'package:recruting_proweb/pages/HomePages.dart';
import 'package:recruting_proweb/pages/StagesPage.dart';
import 'package:recruting_proweb/pages/UsersListPage.dart';
import 'package:recruting_proweb/provider/google_sigin_in.dart';

void main() async {
  // Инициализация базы данных
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Запуск приложения
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        routes: {
          '/': (context) => HomePage(),
          '/directions': (context) => DiractionsPage(),
          '/stages': (context) => StagesPage(),
          '/users': (context) => UsersListPage(),
        },
        initialRoute: '/',
        theme: ThemeData(
          primaryColor: Colors.white,
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          fontFamily: 'Lato',
          scaffoldBackgroundColor: textColor,
        ),
      ),
    );
  }
}
