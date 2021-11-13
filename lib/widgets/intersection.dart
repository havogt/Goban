import 'package:flutter/material.dart';
import 'package:goban/data_classes/position.dart';
import 'package:goban/enums/player.dart';
import 'package:goban/models/gobanModel.dart';
import 'package:goban/themes/stoneTheme.dart';
import 'package:goban/widgets/stone.dart';
import 'package:provider/provider.dart';

class Intersection extends StatelessWidget {
  final Position position;
  final Player player;
  final double size;
  final StoneThemes stoneThemes;

  const Intersection(
      {Key key,
      @required this.position,
      @required this.player,
      @required this.size,
      @required this.stoneThemes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var gobanModel = Provider.of<GobanModel>(context);

    bool last;
    if (gobanModel.lastMove != null) {
      var lastPos = gobanModel.lastMove.position;
      last = lastPos.row == position.row && lastPos.column == position.column;
    } else {
      last = false;
    }
    Widget child = _createStone(player, size, stoneThemes, last);

    return GestureDetector(
      child: child,
      onTap: () {
        gobanModel.moveStream.add(position);
      },
    );
  }

  Widget _createStone(
      Player player, double size, StoneThemes stoneThemes, bool last) {
    Widget stone;

    switch (player) {
      case Player.White:
        stone = stoneThemes.whiteStone(size, last);
        break;
      case Player.Black:
        stone = stoneThemes.blackStone(size, last);
        break;
      case Player.Empty:
        stone = Container(
            width: size,
            height: size,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(size)));
        break;
    }

    return stone;
  }
}
