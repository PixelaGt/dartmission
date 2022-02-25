import 'dart:math';

import 'package:dartmission/gen/assets.gen.dart';
import 'package:dartmission/src/models/custom_stack.dart';
import 'package:dartmission/src/models/directions_enum.dart';
import 'package:dartmission/src/models/tile.dart';
import 'package:dartmission/src/ui/widgets/screen_wrapper.dart';
import 'package:flutter/material.dart';

class LevelScreen extends StatefulWidget {
  const LevelScreen({Key? key}) : super(key: key);

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  final int tilesCount = 3; // Playable tiles (3 x 3)
  late int columns; // Total amount of columns in the tile matrix
  late int rows; // Total amount of rows in the tile matrix
  late List<List<Tile>> _tiles; // Matrix of tiles
  final _solutionStack = CustomStack<Tile>();
  late int _emptyTileRow; // Row where the empty tyle is
  late int _emptyTileColumn; // Column where the empty tyle is
  final Random _randomizer = Random(); // Randomizer

  @override
  void initState() {
    columns = tilesCount;
    rows = tilesCount + 2; // We need to add the starting and ending rows
    super.initState();
    // Set columns and rows
    _tiles = List.generate(
      columns,
      (c) => List.generate(
        rows,
        (r) => Tile(
          column: c,
          row: r,
          blocked:
              (r == 0 && c != 0) || (r == (rows - 1) && c != (columns - 1)),
        ),
      ),
    );
    _createPuzzle(); // Create puzzle with a solution
    _connectSolutionPath(); // Connect the solution as a path
    _scrambleMaze(); // Scramble maze
  }

  void _createPuzzle() {
    // Initialize variables
    Tile current;
    Tile? next;
    final _start = _tiles.first.first;
    final _exit = _tiles.last.last;
    current = _start..visited = true;
    // Define which tyle is going to be empty
    _setEmptyTile();

    // Create puzzle solution
    var isFinalTile = false;
    while (!isFinalTile) {
      next = _getNext(current);
      if (next != null) {
        _solutionStack.push(current);
        current = next..visited = true;
      } else {
        current = _solutionStack.pop();
      }
      isFinalTile = current.row == _exit.row && current.column == _exit.column;
    }
    // Block the starting and ending tyles
    _tiles.last.last.blocked = true;
    _tiles.last.last.isFinal = true;
    _tiles.first.first.blocked = true;
    _tiles.first.first.exitDirection = DirectionEnum.bottom;
    _tiles.first.first.isFirst = true;
    _solutionStack.push(_exit);
  }

  // Method to select a random, playable tyle to be emtpy
  void _setEmptyTile() {
    late int _selectedRow;
    late int _selectedColumn;
    var _selectedValidTile = false;
    while (!_selectedValidTile) {
      _selectedRow = _randomizer.nextInt(columns) + 1;
      _selectedColumn = _randomizer.nextInt(columns);
      // We make sure the empty tyle is not directly above the ending tyle
      // Make sure the emtpy tyle is not directly below the starting tyle
      _selectedValidTile = !(_selectedRow == 1 && _selectedColumn == 0) &&
          !(_selectedRow == columns && _selectedColumn == columns - 1);
    }
    _emptyTileRow = _selectedRow;
    _emptyTileColumn = _selectedColumn;
    _tiles[_selectedColumn][_selectedRow].empty = true;
  }

  void _connectSolutionPath() {
    var _solutionTiles = <Tile>[];
    // Add all solution tiles of the stack to a list
    while (_solutionStack.isNotEmpty) {
      final _solutionTile = _solutionStack.pop();
      _solutionTiles.add(_solutionTile);
    }
    _solutionTiles = _solutionTiles.reversed.toList();
    var _entryDirection = DirectionEnum.top;
    // We will grab all the tiles from the solution and paint the directions
    for (var i = 0; i < _solutionTiles.length - 1; i++) {
      // Will always evaluate the current solution tile, and the next tile in
      // The solution array in order to know in which direction to go
      final _currentTile = _solutionTiles[i];
      final _nextTile = _solutionTiles[i + 1];
      // Set the entry direction of the tile
      _solutionTiles[i].enterDirection = _entryDirection;
      _tiles[_currentTile.column][_currentTile.row].enterDirection =
          _entryDirection;

      // Set the exit direction of the current tyle based on the next tyle's
      // Position
      late DirectionEnum _exitDirection;
      // If the tiles are together vertically
      if (_nextTile.row == _currentTile.row) {
        // If the next tile in the solution is to the right of the current tile
        if (_nextTile.column > _currentTile.column) {
          _exitDirection = DirectionEnum.right;
        } else {
          // If the next tile in the solution is to the left of the current tile
          _exitDirection = DirectionEnum.left;
        }
        // The tiles are together horizontally
      } else {
        // If the next tile in the solution is below the current tile
        if (_nextTile.row > _currentTile.row) {
          _exitDirection = DirectionEnum.bottom;
        } else {
          // If the next tile in the solution is above the current tile
          _exitDirection = DirectionEnum.top;
        }
      }
      // Set exit direction
      _solutionTiles[i].exitDirection = _exitDirection;
      _tiles[_currentTile.column][_currentTile.row].exitDirection =
          _exitDirection;
      // Set entry direction for the next tyle
      if (_exitDirection == DirectionEnum.right) {
        _entryDirection = DirectionEnum.left;
      } else if (_exitDirection == DirectionEnum.left) {
        _entryDirection = DirectionEnum.right;
      } else if (_exitDirection == DirectionEnum.top) {
        _entryDirection = DirectionEnum.bottom;
      } else if (_exitDirection == DirectionEnum.bottom) {
        _entryDirection = DirectionEnum.top;
      }
    }
  }

  // Method that will change a random tyle with the empty or white tyle
  void _scrambleMaze() {
    var _whitespace = _tiles[_emptyTileColumn][_emptyTileRow];
    var _randomRow = 0;
    var _randomColumn = 0;
    for (var scrambleStep = 0; scrambleStep <= 15; scrambleStep++) {
      var _isRandomTileValid = false;
      do {
        _randomRow = _randomizer.nextInt(columns) + 1;
        _randomColumn = _randomizer.nextInt(columns);
        _isRandomTileValid = (_randomRow != _whitespace.row) &&
            (_randomColumn != _whitespace.column);
      } while (!_isRandomTileValid);

      final _blankTile = _whitespace;
      final _selectedTile = _tiles[_randomColumn][_randomRow];
      _emptyTileRow = _whitespace.row;
      _emptyTileColumn = _whitespace.column;
      _whitespace = _tiles[_selectedTile.column][_selectedTile.row];

      _tiles[_selectedTile.column][_selectedTile.row] = _blankTile
        ..column = _selectedTile.column
        ..row = _selectedTile.row;

      _tiles[_emptyTileColumn][_emptyTileRow] = _selectedTile
        ..column = _emptyTileColumn
        ..row = _emptyTileRow;
    }
  }

  Tile? _getNext(Tile _current) {
    final neighbours = <Tile>[];

    //left
    if (_current.column > 0) {
      final _leftTile = _tiles[_current.column - 1][_current.row];
      if (!_leftTile.visited && !_leftTile.blocked && !_leftTile.empty) {
        neighbours.add(_leftTile);
      }
    }

    //right
    if (_current.column < columns - 1) {
      final _rightTile = _tiles[_current.column + 1][_current.row];
      if (!_rightTile.visited && !_rightTile.blocked && !_rightTile.empty) {
        neighbours.add(_rightTile);
      }
    }

    //Top
    if (_current.row > 0) {
      final _topTile = _tiles[_current.column][_current.row - 1];
      if (!_topTile.visited && !_topTile.blocked && !_topTile.empty) {
        neighbours.add(_topTile);
      }
    }

    //Bottom
    if (_current.row < rows - 1) {
      final _bottomTile = _tiles[_current.column][_current.row + 1];
      if (!_bottomTile.visited && !_bottomTile.blocked && !_bottomTile.empty) {
        neighbours.add(_bottomTile);
      }
    }
    if (neighbours.isNotEmpty) {
      final index = _randomizer.nextInt(neighbours.length);
      return neighbours[index];
    }
    return null;
  }

  GestureDetector buildCard(Tile _tile) {
    // Colors
    var _color = Colors.transparent;
    if (_tile.blocked) {
      _color = Colors.red;
    }
    if (_tile.empty) {
      _color = Colors.white;
    }
    Icon? _directionIcon;

    if (!_tile.empty && !_tile.blocked) {
      // Road Direction
      if (_tile.enterDirection == DirectionEnum.top &&
          _tile.exitDirection == DirectionEnum.bottom) {
        _directionIcon = const Icon(Icons.south);
      } else if (_tile.enterDirection == DirectionEnum.top &&
          _tile.exitDirection == DirectionEnum.right) {
        _directionIcon = const Icon(Icons.subdirectory_arrow_right);
      } else if (_tile.enterDirection == DirectionEnum.top &&
          _tile.exitDirection == DirectionEnum.left) {
        _directionIcon = const Icon(Icons.keyboard_return);
      } else if (_tile.enterDirection == DirectionEnum.left &&
          _tile.exitDirection == DirectionEnum.top) {
        _directionIcon = const Icon(Icons.call_made);
      } else if (_tile.enterDirection == DirectionEnum.left &&
          _tile.exitDirection == DirectionEnum.right) {
        _directionIcon = const Icon(Icons.trending_flat);
      } else if (_tile.enterDirection == DirectionEnum.left &&
          _tile.exitDirection == DirectionEnum.bottom) {
        _directionIcon = const Icon(Icons.south_east);
      } else if (_tile.enterDirection == DirectionEnum.right &&
          _tile.exitDirection == DirectionEnum.top) {
        _directionIcon = const Icon(Icons.north_west);
      } else if (_tile.enterDirection == DirectionEnum.right &&
          _tile.exitDirection == DirectionEnum.left) {
        _directionIcon = const Icon(Icons.west);
      } else if (_tile.enterDirection == DirectionEnum.right &&
          _tile.exitDirection == DirectionEnum.bottom) {
        _directionIcon = const Icon(Icons.south_west);
      } else if (_tile.enterDirection == DirectionEnum.bottom &&
          _tile.exitDirection == DirectionEnum.top) {
        _directionIcon = const Icon(Icons.north);
      } else if (_tile.enterDirection == DirectionEnum.bottom &&
          _tile.exitDirection == DirectionEnum.right) {
        _directionIcon = const Icon(Icons.shortcut);
      } else if (_tile.enterDirection == DirectionEnum.bottom &&
          _tile.exitDirection == DirectionEnum.left) {
        _directionIcon = const Icon(Icons.reply);
      }
    }

    return GestureDetector(
      onTap: () {
        _onTileTapped(_tile);
      },
      child: Card(color: _color, child: _directionIcon),
    );
  }

  void _onTileTapped(Tile _tileTapped) {
    _moveTile(_tileTapped);
    for (var c = 0; c < columns; c++) {
      for (var r = 0; r < rows; r++) {
        _tiles[c][r].visited = false;
      }
    }
    final _mazeCompleted = _checkIfMazeCompleted(_tiles.first.first);
    if (_mazeCompleted) {
      print('SE GANÓ :D');
    }
  }

  void _moveTile(Tile _tappedTile) {
    // Make sure the tile can be moved
    if (_tappedTile.blocked || _tappedTile.empty) {
      return;
    }
    // Analyze if the empty tile is next to the tapped tile
    var _moved = false;
    Tile? _neighbourEmptyTile;
    // Left
    if (_tappedTile.column > 0) {
      final _leftTile = _tiles[_tappedTile.column - 1][_tappedTile.row];
      if (_leftTile.empty) {
        _moved = true;
        _neighbourEmptyTile = _leftTile;
      }
    }
    //Right
    if (_tappedTile.column < columns - 1 && !_moved) {
      final _rightTile = _tiles[_tappedTile.column + 1][_tappedTile.row];
      if (_rightTile.empty) {
        _moved = true;
        _neighbourEmptyTile = _rightTile;
      }
    }
    //Top
    if (_tappedTile.row > 0 && !_moved) {
      final _topTile = _tiles[_tappedTile.column][_tappedTile.row - 1];
      if (_topTile.empty) {
        _moved = true;
        _neighbourEmptyTile = _topTile;
      }
    }
    //Bottom
    if (_tappedTile.row < rows - 1 && !_moved) {
      final _bottomTile = _tiles[_tappedTile.column][_tappedTile.row + 1];
      if (_bottomTile.empty) {
        _moved = true;
        _neighbourEmptyTile = _bottomTile;
      }
    }

    // If there is a neighbour tile that is empty, we make the movement
    if (_neighbourEmptyTile != null) {
      setState(() {
        final _blankTile = _neighbourEmptyTile!;
        final _blankTileRow = _neighbourEmptyTile.row;
        final _blankTileColumn = _neighbourEmptyTile.column;

        _tiles[_tappedTile.column][_tappedTile.row] = _blankTile
          ..column = _tappedTile.column
          ..row = _tappedTile.row;
        _tiles[_blankTileColumn][_blankTileRow] = _tappedTile
          ..column = _blankTileColumn
          ..row = _blankTileRow;
      });
    }
  }

  bool _checkIfMazeCompleted(Tile _currentTile) {
    // Mark current tile as visited
    _currentTile.visited = true;

    // If the current tile is the ending tile we return true
    if (_currentTile.isFinal) {
      return true;
    }
    // Check tile is availble
    if (!_currentTile.isFirst && (_currentTile.empty || _currentTile.blocked)) {
      return false;
    }

    // Else we check if there are other connected tiles we can go to
    // Left
    if (_currentTile.exitDirection == DirectionEnum.left) {
      if (_currentTile.column > 0) {
        final _leftTile = _tiles[_currentTile.column - 1][_currentTile.row];
        if (_leftTile.enterDirection == DirectionEnum.right) {
          return _checkIfMazeCompleted(_leftTile);
        }
      }
    }
    // Right
    if (_currentTile.exitDirection == DirectionEnum.right) {
      if (_currentTile.column < columns - 1) {
        final _rightTile = _tiles[_currentTile.column + 1][_currentTile.row];
        if (_rightTile.enterDirection == DirectionEnum.left) {
          return _checkIfMazeCompleted(_rightTile);
        }
      }
    }
    // Top
    if (_currentTile.exitDirection == DirectionEnum.top) {
      if (_currentTile.row > 0) {
        final _topTile = _tiles[_currentTile.column][_currentTile.row - 1];
        if (_topTile.enterDirection == DirectionEnum.bottom) {
          return _checkIfMazeCompleted(_topTile);
        }
      }
    }
    // Bottom
    if (_currentTile.exitDirection == DirectionEnum.bottom) {
      if (_currentTile.row < rows - 1) {
        final _bottomTile = _tiles[_currentTile.column][_currentTile.row + 1];
        if (_bottomTile.enterDirection == DirectionEnum.top) {
          return _checkIfMazeCompleted(_bottomTile);
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;
    final screenHeight = media.size.height;

    return ScreenWrapper(
      child: Stack(
        children: [
          Assets.images.svg.backgroundSpace2.svg(
            fit: BoxFit.fill,
          ),
          Align(
            alignment: Alignment(
              Alignment.bottomLeft.x - 0.45,
              Alignment.bottomLeft.y + 0.90,
            ),
            child: Assets.images.svg.pinkAndBluePlanet.svg(
              width: 500,
              height: 500,
              //
            ),
          ),
          Align(
            child: Assets.images.svg.pinkPlanet.svg(),
          ),
          Align(
            alignment: Alignment(
              Alignment.topRight.x + 0.07,
              Alignment.topCenter.y + 0.5,
            ),
            child: Assets.images.svg.orangePlanet.svg(
              width: 100,
              height: 100,
              //
            ),
          ),
          Align(
            alignment: Alignment(
              Alignment.center.x - 0.8,
              Alignment.centerLeft.y - 0.5,
            ),
            child: Assets.images.svg.pinkAndCianPlanet.svg(
              width: 125,
              height: 125,
              //
            ),
          ),
          Align(
            alignment: Alignment(
              Alignment.topLeft.x + 0.1,
              Alignment.topLeft.y + 0.1,
            ),
            child: Assets.images.svg.title.svg(
              width: 50,
              height: 50,
              //
            ),
          ),
          Align(
            alignment: Alignment(
              Alignment.center.x,
              Alignment.center.y,
            ),
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.1),
              child: SizedBox(
                width: screenWidth / 4,
                child: GridView.builder(
                  itemCount: columns * rows,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final x = index % columns;
                    final y = index ~/ columns;
                    return buildCard(_tiles[x][y]);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
