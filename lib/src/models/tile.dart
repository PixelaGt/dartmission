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

  bool visited = false;
  bool partOfSolution = false;
  bool empty = false;

  DirectionEnum enterDirection = DirectionEnum.top;
  DirectionEnum exitDirection = DirectionEnum.bottom;
}
