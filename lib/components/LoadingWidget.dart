import 'package:flutter/material.dart';
import 'package:recruting_proweb/components/Consts.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

// Виджет загрузки
// ignore: must_be_immutable
class Loading extends StatelessWidget {
  late Widget child;
  late int size;
  bool isGrid = false;

  // Кастомная загрузка
  Loading({
    Key? key,
    required this.child,
    required this.size,
    this.isGrid = false,
  }) : super(key: key);

  // Шаблонная загрузка списков
  Loading.list({Key? key, this.size = 10}) {
    child = _listLoading();
  }

  // Шаблонная загрузка профиля
  Loading.profile({Key? key}) {
    child = _profileLoading();
    size = 1;
  }
  // Шаблонная загрузка профиля
  Loading.grid({Key? key, this.size = 10}) {
    isGrid = true;
  }

  // Шаблон загрузки листов
  Widget _listLoading() {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 20,
        ),
        title: Container(
          width: double.infinity,
          height: 10,
          color: Colors.white,
        ),
        subtitle: Container(
          height: 10,
          width: double.infinity,
          color: Colors.white,
        ),
        trailing: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 13,
        ),
      ),
    );
  }

  // Шаблон загрузки профиля
  Widget _profileLoading() {
    return Column(
      children: <Widget>[
        SizedBox(height: 20),
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 75,
        ),
        SizedBox(height: 30),
        Container(
          width: 275,
          height: 20,
          color: Colors.white,
        ),
        SizedBox(height: 10),
        Container(
          width: 300,
          height: 20,
          color: Colors.white,
        ),
        SizedBox(height: 70),
        Container(
          width: 100,
          height: 30,
          color: Colors.white,
        ),
        SizedBox(height: 30),
        Container(
          width: 120,
          height: 30,
          color: Colors.white,
        ),
      ],
    );
  }

  // Шаблон загрузки профиля
  Widget _gridLoading({required Widget gridItem}) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: 50,
      ),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 260,
        mainAxisSpacing: 40,
        crossAxisSpacing: 40,
        mainAxisExtent: 162,
      ),
      itemBuilder: (BuildContext context, int index) {
        return gridItem;
      },
      itemCount: 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isGrid) {
      return _gridLoading(
        gridItem: SkeletonLoader(
          builder: Container(
            width: 300,
            color: primaryColor,
            alignment: Alignment.center,
          ),
          items: 1,
        ),
      );
    } else {
      return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: size,
        itemBuilder: (BuildContext context, int i) {
          return SkeletonLoader(
            builder: child,
            items: 1,
            period: Duration(seconds: 2),
            highlightColor: Colors.lightBlue[300]!,
            direction: SkeletonDirection.ltr,
          );
        },
      );
    }
  }
}
