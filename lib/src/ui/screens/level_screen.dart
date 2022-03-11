import 'dart:async';

import 'package:dartmission/src/models/difficulty_tracker.dart';
import 'package:dartmission/src/models/maze.dart';
import 'package:dartmission/src/models/tile.dart';
import 'package:dartmission/src/ui/widgets/level/failed_dialog.dart';
import 'package:dartmission/src/ui/widgets/level/screen_wrapper.dart';
import 'package:dartmission/src/ui/widgets/level/space_item.dart';
import 'package:dartmission/src/ui/widgets/level/successfully_dialog.dart';
import 'package:flutter/material.dart';

class LevelScreen extends StatefulWidget {
  const LevelScreen({Key? key}) : super(key: key);

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  int levelsCompleted = 0;
  final _difficultyTracker = DifficultyTracker();

  late Timer _timer;
  late int columns; // Total amount of columns in the tile matrix
  late int rows; // Total amount of rows in the tile matrix
  late List<List<Tile>> _tiles; // Matrix of tiles
  late Maze
      _maze; // Maze class that creates the solution and scrambles the maze
  bool _gameInProgress = false; // Bool to keep track if the game is in progress

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _startLevel();
  }

  void _startLevel() {
    // Set level difficulty
    _difficultyTracker.updateLevelProgress();

    // Set columns and rows
    columns = _difficultyTracker.getLevelTiles();
    rows = _difficultyTracker.getLevelTiles() + 2;
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
    // Initialize maze
    _maze = Maze(columns: columns, rows: rows, tiles: _tiles);
    _tiles = _maze.createPuzzle();
    _startTimer();
  }

  void _startTimer() {
    setState(() {
      _gameInProgress = true;
    });
    var timeAvailable = _difficultyTracker.getLevelTimeLimit();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (timeAvailable == 0) {
          timer.cancel();
          setState(() {
            _gameInProgress = false;
            // Show faled mission
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => FailedDialog(
                onRestart: () {
                  levelsCompleted = 0;
                  _difficultyTracker.resetDifficulty();
                  setState(_startLevel);
                },
              ),
            );
          });
        } else {
          setState(() {
            timeAvailable--;
          });
        }
      },
    );
  }

  void _onTileTapped(Tile _tileTapped) {
    _moveTile(_tileTapped);
    for (var c = 0; c < columns; c++) {
      for (var r = 0; r < rows; r++) {
        _tiles[c][r].visited = false;
      }
    }
    final _mazeCompleted = _maze.checkIfMazeCompleted(_tiles.first.first);
    if (_mazeCompleted) {
      _timer.cancel();
      levelsCompleted++;

      showDialog<String>(
        context: context,
        builder: (BuildContext context) => SuccessfullyDialog(
          onContinue: () {
            // Advance level difficulty
            _difficultyTracker.advanceDifficulty(levelsCompleted);
            setState(_startLevel);
          },
        ),
      );
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

  String parseTimeLeft(int timeLeft) {
    final mins = timeLeft ~/ 60;
    final seconds = timeLeft % 60;
    return '$mins:${seconds >= 10 ? seconds : '0$seconds'}';
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;
    final screenHeight = media.size.height;

    // final height = media.size.height;
    final isMobile = screenWidth <= 760;
    final isTablet = screenWidth > 760 && screenWidth <= 1024;

    return Scaffold(
      backgroundColor: const Color(0xFF331076),
      body: SafeArea(
        child: ScreenWrapper(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/jpg/background_space.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: isMobile ? 100 : 40,
                ),
                if (_gameInProgress)
                  Text(
                    parseTimeLeft(
                      _difficultyTracker.getLevelTimeLimit() - _timer.tick,
                    ),
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .apply(color: Colors.white),
                  ),
                Padding(
                  padding: EdgeInsets.only(
                    top: isMobile ? 0 : screenHeight * 0.01,
                  ),
                  child: SizedBox(
                    width: isMobile
                        ? screenWidth * 0.9
                        : isTablet
                            ? screenWidth * 0.6
                            : screenWidth * 0.25,
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: columns * rows,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columns,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        final x = index % columns;
                        final y = index ~/ columns;
                        return SpaceItem(
                          onTilePressed: _onTileTapped,
                          tile: _tiles[x][y],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
