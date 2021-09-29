import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recruting_proweb/components/Consts.dart';
import 'package:recruting_proweb/components/LoadingWidget.dart';
import 'package:recruting_proweb/components/RootsComplete.dart';

// ignore: must_be_immutable
class DiractionsPage extends StatefulWidget {
  DiractionsPage({Key? key}) : super(key: key);

  @override
  State<DiractionsPage> createState() => _DiractionsPageState();
}

class _DiractionsPageState extends State<DiractionsPage> {
  // Спиок направлений
  late List dirList;

  @override
  void initState() {
    dirList = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future _getDirections(bool state) async {
      var dirData = await directions.get();

      if (state) {
        setState(() {
          dirList = dirData.docs.toList();
        });
      } else {
        dirList = dirData.docs.toList();
      }
      return dirList;
    }

    Widget _directionsBody(AsyncSnapshot snapshot) {
      return Text('Направления');
    }

    return RootsComplete(
      secondStream: directions.snapshots(),
      updateState: _getDirections,
      appbarTitle: 'Направления',
      load: Loading.list(),
      child: _directionsBody,
      condition: dirList.length == 0,
    );
  }
}


/* 

floatingActionButton: _roots == 2
? FloatingActionButton(
    onPressed: () {},
    backgroundColor: Theme.of(context).primaryColor,
    child: Icon(
      Icons.add,
      color: primaryColor,
      size: 30,
    ),
  )
: null,

 */