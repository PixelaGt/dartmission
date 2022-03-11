import 'dart:math';

import 'package:dartmission/src/models/custom_stack.dart';
import 'package:dartmission/src/models/directions_enum.dart';
import 'package:dartmission/src/models/tile.dart';

class Maze {
  Maze({
    required this.tiles,
    required this.columns,
    required this.rows,
  });
  List<List<Tile>> tiles;
  int columns;
  int rows;

  // Private attributes
  final _solutionStack = CustomStack<Tile>();
  final _randomizer = Random();
  int _emptyTileColumn = 0;
  int _emptyTileRow = 0;

  // Creates the puzzle, connects the solution and scrambles the maze
  List<List<Tile>> createPuzzle() {
    _initializeMaze();
    _connectSolutionPath();
    _scrambleMaze();
    return tiles;
  }

  void _initializeMaze() {
    // Initialize variables
    Tile current;
    Tile? next;
    final _start = tiles.first.first;
    final _exit = tiles.last.last;
    current = _start..visited = true;
    // Define which tyle is going to be empty
    final emptyTile = _getEmptyTile(tiles);
    tiles[emptyTile.column][emptyTile.row].empty = true;

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
    tiles.last.last.blocked = true;
    tiles.last.last.isFinal = true;
    tiles.first.first.blocked = true;
    tiles.first.first.exitDirection = DirectionEnum.down;
    tiles.first.first.isFirst = true;
    _solutionStack.push(_exit);
  }

  // Method to create the solution path of the maze
  void _connectSolutionPath() {
    var _solutionTiles = <Tile>[];
    // Add all solution tiles of the stack to a list
    while (_solutionStack.isNotEmpty) {
      final _solutionTile = _solutionStack.pop();
      _solutionTiles.add(_solutionTile);
    }
    _solutionTiles = _solutionTiles.reversed.toList();
    var _entryDirection = DirectionEnum.up;
    // We will grab all the tiles from the solution and paint the directions
    for (var i = 0; i < _solutionTiles.length - 1; i++) {
      // Will always evaluate the current solution tile, and the next tile in
      // The solution array in order to know in which direction to go
      final _currentTile = _solutionTiles[i]..isPartOfSolution = true;
      final _nextTile = _solutionTiles[i + 1];
      // Set the entry direction of the tile
      _solutionTiles[i].enterDirection = _entryDirection;
      tiles[_currentTile.column][_currentTile.row].enterDirection =
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
          _exitDirection = DirectionEnum.down;
        } else {
          // If the next tile in the solution is above the current tile
          _exitDirection = DirectionEnum.up;
        }
      }
      // Set exit direction
      _solutionTiles[i].exitDirection = _exitDirection;
      tiles[_currentTile.column][_currentTile.row].exitDirection =
          _exitDirection;
      // Set entry direction for the next tyle
      if (_exitDirection == DirectionEnum.right) {
        _entryDirection = DirectionEnum.left;
      } else if (_exitDirection == DirectionEnum.left) {
        _entryDirection = DirectionEnum.right;
      } else if (_exitDirection == DirectionEnum.up) {
        _entryDirection = DirectionEnum.down;
      } else if (_exitDirection == DirectionEnum.down) {
        _entryDirection = DirectionEnum.up;
      }
    }
  }

  // Method that will change a random tyle with the empty or white tyle
  void _scrambleMaze() {
    var _whitespace = tiles[_emptyTileColumn][_emptyTileRow];
    var _randomRow = 0;
    var _randomColumn = 0;
    // While the maze is not completed, we scramble the pieces
    while (checkIfMazeCompleted(tiles.first.first)) {
      // Scramble the pieces
      for (var scrambleStep = 0; scrambleStep <= 10; scrambleStep++) {
        var _isRandomTileValid = false;
        do {
          _randomRow = _randomizer.nextInt(columns) + 1;
          _randomColumn = _randomizer.nextInt(columns);
          _isRandomTileValid = (_randomRow != _whitespace.row) &&
              (_randomColumn != _whitespace.column);
        } while (!_isRandomTileValid);

        final _blankTile = _whitespace;
        final _selectedTile = tiles[_randomColumn][_randomRow];
        _emptyTileRow = _whitespace.row;
        _emptyTileColumn = _whitespace.column;
        _whitespace = tiles[_selectedTile.column][_selectedTile.row];

        tiles[_selectedTile.column][_selectedTile.row] = _blankTile
          ..column = _selectedTile.column
          ..row = _selectedTile.row;

        tiles[_emptyTileColumn][_emptyTileRow] = _selectedTile
          ..column = _emptyTileColumn
          ..row = _emptyTileRow;
      }
    }
  }

  Tile? _getNext(Tile _current) {
    final neighbours = <Tile>[];

    //left
    if (_current.column > 0) {
      final _leftTile = tiles[_current.column - 1][_current.row];
      if (!_leftTile.visited && !_leftTile.blocked && !_leftTile.empty) {
        neighbours.add(_leftTile);
      }
    }

    //right
    if (_current.column < columns - 1) {
      final _rightTile = tiles[_current.column + 1][_current.row];
      if (!_rightTile.visited && !_rightTile.blocked && !_rightTile.empty) {
        neighbours.add(_rightTile);
      }
    }

    //Top
    if (_current.row > 0) {
      final _topTile = tiles[_current.column][_current.row - 1];
      if (!_topTile.visited && !_topTile.blocked && !_topTile.empty) {
        neighbours.add(_topTile);
      }
    }

    //Bottom
    if (_current.row < rows - 1) {
      final _bottomTile = tiles[_current.column][_current.row + 1];
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

  bool checkIfMazeCompleted(Tile _currentTile) {
    // Mark current tile as visited
    _currentTile.visited = true;

    // If the current tile is the ending tile we return true
    if (_currentTile.isFinal) {
      return true;
    }
    // Check tile is availble
    if (!_currentTile.isFirst &&
        (_currentTile.empty ||
            _currentTile.blocked ||
            !_currentTile.isPartOfSolution)) {
      return false;
    }

    // Else we check if there are other connected tiles we can go to
    // Left
    if (_currentTile.exitDirection == DirectionEnum.left) {
      if (_currentTile.column > 0) {
        final _leftTile = tiles[_currentTile.column - 1][_currentTile.row];
        if (_leftTile.enterDirection == DirectionEnum.right) {
          return checkIfMazeCompleted(_leftTile);
        }
      }
    }
    // Right
    if (_currentTile.exitDirection == DirectionEnum.right) {
      if (_currentTile.column < columns - 1) {
        final _rightTile = tiles[_currentTile.column + 1][_currentTile.row];
        if (_rightTile.enterDirection == DirectionEnum.left) {
          return checkIfMazeCompleted(_rightTile);
        }
      }
    }
    // Top
    if (_currentTile.exitDirection == DirectionEnum.up) {
      if (_currentTile.row > 0) {
        final _topTile = tiles[_currentTile.column][_currentTile.row - 1];
        if (_topTile.enterDirection == DirectionEnum.down) {
          return checkIfMazeCompleted(_topTile);
        }
      }
    }
    // Bottom
    if (_currentTile.exitDirection == DirectionEnum.down) {
      if (_currentTile.row < rows - 1) {
        final _bottomTile = tiles[_currentTile.column][_currentTile.row + 1];
        if (_bottomTile.enterDirection == DirectionEnum.up) {
          return checkIfMazeCompleted(_bottomTile);
        }
      }
    }
    return false;
  }

  // Method to select a random, playable tyle to be emtpy
  Tile _getEmptyTile(List<List<Tile>> _tiles) {
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
    return _tiles[_selectedColumn][_selectedRow];
  }
}
