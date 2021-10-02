import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recruting_proweb/components/Consts.dart';
import 'package:recruting_proweb/components/LoadingWidget.dart';
import 'package:recruting_proweb/components/MyContainer.dart';
import 'BanContent.dart';
import 'Consts.dart';
import 'LeftMenu.dart';

// ignore: must_be_immutable
class RootsComplete extends StatefulWidget {
  // Заголовок страницы
  String appbarTitle;
  // Тип загрузки
  Loading load;
  // Контент текущий страницы
  Function child;
  // Переход к профилю
  final bool profileBtn;
  // Сообщение Об ошибке
  String errorMsg;
  // Второй Стрим для отображения элементов
  Stream<QuerySnapshot> secondStream;
  // Проверка на первое обновление состояние
  Function updateState;
  // условие для обновления состояния страници
  bool condition;
  // Функция для плавуюзей кнопки
  Function? floatingAtion;

  RootsComplete({
    Key? key,
    // Заголовок страницы
    required this.appbarTitle,
    // Тип загрузки
    required this.load,
    // Контент текущий страницы
    required this.child,
    // Переход к профилю
    this.profileBtn = true,
    // Сообщение Об ошибке
    this.errorMsg = 'Произошла Ошибка',
    // Второй Стрим для отображения элементов
    required this.secondStream,
    // Проверка на первое обновление
    required this.updateState,
    // Условие для обновления состояния страницы
    required this.condition,
    // Функция для плавуюзей кнопки
    this.floatingAtion,
  }) : super(key: key);

  @override
  State<RootsComplete> createState() => _RootsCompleteState();
}

class _RootsCompleteState extends State<RootsComplete> {
  @override
  Widget build(BuildContext context) {
    // Получение прав пользователя из Firebase
    void _getRoots({required AsyncSnapshot<QuerySnapshot> snapshot}) async {
      var data = snapshot.data!;
      var rootsData = data.docs.where((element) {
        return element['email'] == user.email;
      });

      if (rootsData.isNotEmpty) {
        user.roots = rootsData.first.get('roots');
      }
    }

    // Основной контент страници
    Widget pageBody({
      required Function child,
      required photoUrl,
      required AsyncSnapshot snapshot,
    }) {
      return Scaffold(
        // Проверка прав для бокового меню
        drawer: user.roots > 0 ? LeftMenu() : null,
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            // Высота для корректного отображения Appbar
            toolbarHeight: 70,
            // Сброс тени
            elevation: 0,
            // Просто надпись
            // Цвет AppBar
            backgroundColor: Colors.white,
            // Отключение кнопок по дефолту
            automaticallyImplyLeading: false,
            // Заголовок AppBar-а

            title: MyContainer(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 7),
                decoration: BoxDecoration(
                  color: linkTapColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(80),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Builder(builder: (context) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(80),
                        onTap: () => Scaffold.of(context).openDrawer(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.menu),
                        ),
                      );
                    }),
                    Text(
                      widget.appbarTitle,
                      style: TextStyle(color: primaryColor),
                    ),
                    widget.profileBtn
                        ? goProfile(context: context, url: photoUrl)
                        : SizedBox(width: 50, height: 50),
                  ],
                ),
              ),
            ),
            // Проверяем нужен ли переход на профиль
          ),
        ),
        // Основной контент страници оборачиваем в контейнер
        body: MyContainer(
          // Второй стрим относительно коллекции
          child: StreamBuilder(
            // Передача нужной коллекции
            stream: widget.secondStream,
            // Рендер приложения
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Material(
                    child: Text(widget.errorMsg),
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return widget.load;
              }

              return FutureBuilder(
                future: widget.updateState(widget.condition),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return child(snapshot);
                },
              );
            },
          ),
        ),

        floatingActionButton: widget.floatingAtion == null
            ? null
            : user.roots == 2
                ? FloatingActionButton(
                    backgroundColor: Color.fromRGBO(194, 231, 255, 1),
                    onPressed: () {
                      widget.floatingAtion!();
                    },
                    child: Icon(
                      Icons.add,
                      color: primaryColor,
                      size: 30,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                  )
                : null,
      );
    }

    // Стрим на права пользователя
    return StreamBuilder(
      stream: users.snapshots(),
      // Рендер относительно прав
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return pageBody(
            snapshot: snapshot,
            child: () => widget.load,
            photoUrl: user.imgUrl,
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Material(child: Text(widget.errorMsg)),
          );
        }
        // Обновление прав пользователя в реальном времени
        _getRoots(snapshot: snapshot);

        // Проверка прав пользователя
        switch (user.roots) {
          case 1:
          case 2:
            return pageBody(
              snapshot: snapshot,
              child: widget.child,
              photoUrl: user.imgUrl,
            );
          case 0:
            return pageBody(
              snapshot: snapshot,
              child: (snapshot) => BanContent(),
              photoUrl: user.imgUrl,
            );
          case -1:
          default:
            return pageBody(
              snapshot: snapshot,
              child: (snapshot) => widget.load,
              photoUrl: user.imgUrl,
            );
        }
      },
    );
  }
}
