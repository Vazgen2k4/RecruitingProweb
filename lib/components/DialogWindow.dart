// Шаблон диалогового окна
import 'package:flutter/material.dart';
import 'package:recruting_proweb/components/Consts.dart';

// ignore: must_be_immutable
class DialogWindow extends StatefulWidget {
  final Widget? header;
  final Widget body;
  final Widget? footer;
  BuildContext context;
  double windowWidth;

  DialogWindow({
    Key? key,
    required this.context,
    this.header,
    required this.body,
    this.footer,
    this.windowWidth = 600,
  }) : super(key: key);

  @override
  _DialogWindowState createState() => _DialogWindowState();
}

class _DialogWindowState extends State<DialogWindow> {
  // Процент закрытия окна
  late final double finalPerce;
  // Процент максимального сдвига окна
  late final double stopPerce;
  // Высота экрана
  late double deviceHeight;
  // Начальное положение окна по Y-оси
  late final double startPosY;
  // Текущее положение окна
  late double posY;
  // Вернуть окно назад
  late bool hasStart;
  // Размер разделительных полос
  late double dividerSize;
  // Дельта по оси Y
  late double deltaY;
  // Высота сообщения о закрытии
  late double closeH;
  // Максимальная высота сообщения о закрытии
  late double closeMaxH;
  // Процент показания окна
  // late double closeProceH;

  @override
  void initState() {
    // Процент закрытия окна
    finalPerce = 44;
    // Процент максимального сдвига окна
    stopPerce = 75;
    // Высота экрана
    deviceHeight = MediaQuery.of(widget.context).size.height;
    // Начальное положение окна по Y-оси
    startPosY = 200;
    // Текущее положение окна
    posY = startPosY;
    // Вернуть окно назад
    hasStart = false;
    // Размер разделительных полос
    dividerSize = 1;
    // Дельта по оси Y
    deltaY = 0;
    // Высота сообщения о закрытии
    closeH = 0;
    // Максимальная высота сообщения о закрытии
    closeMaxH = 44;
    // Процент показания окна
    // closeProceH = 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Отрисовка позиции окна при изменении положения пльца
      onVerticalDragUpdate: (DragUpdateDetails update) {
        setState(() {
          deltaY = update.delta.dy;
          hasStart = false;
          // Вычилсение того на сколько % сдвинулось до закрытия, для точного показа сообщения  
          // closeProceH = (((posY - startPosY))/(((deviceHeight / 100 * finalPerce) - startPosY) / 100))/100;

          if (closeH + deltaY > closeMaxH) {
            closeH = closeMaxH;
          } else {
            closeH += deltaY;
          }

          if ((update.delta.dy < 0 && posY > startPosY) || deltaY > 0) {
            posY += update.delta.dy;
          }
          if (posY > deviceHeight / 100 * stopPerce) {
            posY = deviceHeight / 100 * stopPerce;
          }
        });
      },
      // Отрисовка позиции окна после поднятия пальца
      onVerticalDragEnd: (DragEndDetails update) {
        setState(() {
          if (posY > deviceHeight / 100 * finalPerce) {
            Navigator.pop(context);
          } else {
            posY = startPosY;
            closeH = 0;
          }
        });
      },
      // Рендер Диалогового Окна
      child: LayoutBuilder(
        builder: (context, box) {
          widget.windowWidth =
              widget.windowWidth >= MediaQuery.of(context).size.width
                  ? MediaQuery.of(context).size.width - 50
                  : widget.windowWidth;
          // Позиционирование окна
          return Stack(
            children: [
              AnimatedPositioned(
                duration: Duration(milliseconds: 50),
                top: posY,
                left: MediaQuery.of(context).size.width / 2 -
                    widget.windowWidth / 2,
                child: Container(
                  width: widget.windowWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: textColor,
                    boxShadow: formShadow,
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 5,
                        left: 5,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            onLongPress: () {
                              Navigator.pop(context);
                            },
                            borderRadius: BorderRadius.circular(30),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Icon(
                                Icons.close_outlined,
                                size: 22,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Структура диалогового окна
                      Column(
                        children: <Widget>[
                          if (widget.header != null) widget.header!,
                          widget.body,
                          if (widget.footer != null)
                            Divider(
                              thickness: dividerSize,
                              color: Colors.grey[200],
                            ),
                          if (widget.footer != null) widget.footer!,
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Уведомление о Закрытии окна
              AnimatedPositioned(
                top: 15,
                duration: Duration(milliseconds: 100),
                height: closeH,
                left: MediaQuery.of(context).size.width / 2 - 100,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(5),
                  width: 200,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.9),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: formShadow,
                  ),
                  child: Text(
                    'Проведите вниз для закрытия окна',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              // Уведомление о Переходе на другое окно
            ],
          );
        },
      ),
    );
  }
}
