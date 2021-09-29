import 'package:flutter/material.dart';
import 'package:recruting_proweb/components/Consts.dart';

class BanContent extends StatelessWidget {

  BanContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.do_disturb_alt_outlined,
            size: 150,
            color: primaryColor,
          ),
          SizedBox(height: 25),
          Container(
            width: 250,
            child: Material(
              color: Colors.transparent,
              child: Text(
                'У вас нет прав. Обратитесь к Админу с просьбой дать доступ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
