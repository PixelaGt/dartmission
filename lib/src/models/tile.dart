import 'package:dartmission/src/models/directions_enum.dart';

class Tile {
  Tile({
    required this.column,
    required this.row,
    required this.blocked,
  });
  int column;
  int row;
  bool blocked;

  bool isFinal = false;
  bool isFirst = false;
  bool visited = false;
  bool empty = false;

  DirectionEnum enterDirection = DirectionEnum.up;
  DirectionEnum exitDirection = DirectionEnum.down;
}
