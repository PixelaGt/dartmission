import 'package:dartmission/src/models/difficulty_enum.dart';
import 'package:dartmission/src/models/level_progress.dart';

class DifficultyTracker {
  DifficultyTracker({
    this.levelDifficulty = DifficultyEnum.easy,
  });
  DifficultyEnum levelDifficulty;

  final _levelProgress = LevelProgress();

  DifficultyEnum getDifficulty() {
    return levelDifficulty;
  }

  void updateLevelProgress() {
    switch (levelDifficulty) {
      case DifficultyEnum.easy:
        {
          _levelProgress
            ..tilesCount = 3
            ..timeLimit = 300;
          break;
        }
      case DifficultyEnum.medium:
        {
          _levelProgress
            ..tilesCount = 4
            ..timeLimit = 240;
          break;
        }
      case DifficultyEnum.hard:
        {
          _levelProgress
            ..tilesCount = 5
            ..timeLimit = 180;
          break;
        }
      case DifficultyEnum.hardcore:
        {
          _levelProgress
            ..tilesCount = 6
            ..timeLimit = 120;
          break;
        }
    }
  }

  int getLevelTiles() {
    return _levelProgress.tilesCount;
  }

  int getLevelTimeLimit() {
    return _levelProgress.timeLimit;
  }

  void resetDifficulty() {
    levelDifficulty = DifficultyEnum.easy;
  }

  void advanceDifficulty(int levelsCompleted) {
    if (levelsCompleted % 3 == 0 &&
        levelDifficulty != DifficultyEnum.hardcore) {
      if (levelDifficulty == DifficultyEnum.easy) {
        levelDifficulty = DifficultyEnum.medium;
      } else if (levelDifficulty == DifficultyEnum.medium) {
        levelDifficulty = DifficultyEnum.hard;
      } else if (levelDifficulty == DifficultyEnum.hard) {
        levelDifficulty = DifficultyEnum.hardcore;
      }
    }
  }
}
