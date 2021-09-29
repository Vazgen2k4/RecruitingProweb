import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:recruting_proweb/components/Consts.dart';
import 'package:recruting_proweb/components/StreamData.dart';

// ignore: must_be_immutable
class ListOrGrid extends StatefulWidget {
  final Widget item;
  AsyncSnapshot snapshot;
  bool isList;
  String title;

  ListOrGrid({
    Key? key,
    required this.isList,
    required this.item,
    required this.title,
    required this.snapshot,
  }) : super(key: key);

  @override
  _ListOrGridState createState() => _ListOrGridState();
}

class _ListOrGridState extends State<ListOrGrid> {
  late bool _isList;
  late int _itemSize;

  Widget _list() {
    return Container(
      width: 600,
      child: ListView.builder(
        itemCount: _itemSize,
        itemBuilder: (context, index) {
          return Material(
            color: textColor,
            child: ListTile(
              title: Text(
                'НаПрАвлЕниE',
                style: TextStyle(color: primaryColor),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _grid() {
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
        return Container(
          color: primaryColor,
          alignment: Alignment.center,
          child: widget.item,
        );
      },
      itemCount: _itemSize,
    );
  }

  @override
  void initState() {
    DirectionData info = widget.snapshot.data;
    _itemSize = info.direction.length;
    _isList = widget.isList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DirectionData? dir = widget.snapshot.data;
    setState(() {
      _itemSize = dir!.direction.length;
    });

    return Stack(
      children: <Widget>[
        ListTile(
          title: Text(widget.title, style: TextStyle(color: primaryColor)),
          trailing: IconButton(
            padding: EdgeInsets.all(0),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: Icon(
              _isList ? Icons.view_comfy : Icons.list,
              color: primaryColor,
            ),
            onPressed: () {
              setState(() {
                _isList = !_isList;
              });
            },
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 50),
          child: _isList ? _list() : _grid(),
        ),
        if (_itemSize == 0)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.folder,
                  size: 150,
                  color: primaryColor,
                ),
                SizedBox(height: 25),
                Container(
                  width: 250,
                  child: Text(
                    '${widget.title} отсутствуют',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ), 
      ],
    );
  }
}
