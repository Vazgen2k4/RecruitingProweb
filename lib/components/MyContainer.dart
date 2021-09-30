import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyContainer extends StatelessWidget {
  // Максимальная ширина
  final double maxWidth;
  // Внутренний элемент
  final Widget? child;
  // Внутренние отступы по вертикали



  MyContainer({
    Key? key,
    this.maxWidth = 1200,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: 15,),
        width: maxWidth >= MediaQuery.of(context).size.width
            ? MediaQuery.of(context).size.width
            : maxWidth,
        child: child,
      ),
    );
  }
}
