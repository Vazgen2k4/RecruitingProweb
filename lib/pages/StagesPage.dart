import 'package:flutter/material.dart';
import 'package:recruting_proweb/components/Consts.dart';
import 'package:recruting_proweb/components/LoadingWidget.dart';
import 'package:recruting_proweb/components/RootsComplete.dart';

// ignore: must_be_immutable
class StagesPage extends StatefulWidget {
  StagesPage({Key? key}) : super(key: key);

  @override
  State<StagesPage> createState() => _StagesPageState();
}

class _StagesPageState extends State<StagesPage> {
  // Список всех этапов
  late List stagesList;

  @override
  void initState() {
    stagesList = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future _getSytages(bool state) async {
      var stagesData = await stages.get();

      if (state) {
        setState(() {
          stagesList = stagesData.docs.toList();
        });
      } else {
        stagesList = stagesData.docs.toList();
      }
      return stagesList;
    }

    Widget _stagesBody(AsyncSnapshot snapshot) {
      return Text('Этапы');
    }

    return RootsComplete(
      secondStream: stages.snapshots(),
      updateState: _getSytages,
      appbarTitle: 'Этапы',
      load: Loading.list(),
      child: _stagesBody,
      condition: stagesList.length == 0,
      floatingAtion: () {
        borderPrint('root is equal ${user.roots}');
      },
    );
  }
}
