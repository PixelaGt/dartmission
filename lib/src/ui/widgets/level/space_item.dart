import 'package:dartmission/gen/assets.gen.dart';
import 'package:dartmission/src/models/tile.dart';
import 'package:dartmission/src/ui/widgets/common/spaceman.dart';
import 'package:flutter/material.dart';

class SpaceItem extends StatelessWidget {
  const SpaceItem({
    Key? key,
    required this.onTilePressed,
    required this.tile,
  }) : super(key: key);

  final Tile tile;
  final Function(Tile) onTilePressed;

  @override
  Widget build(BuildContext context) {
    Image? _backgroundImage;

    if (tile.empty) {
      return Container();
    }
    if (tile.blocked) {
      if (tile.isFirst) {
        return Card(
          color: Colors.transparent,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 3,
          child: Stack(
            children: [
              Assets.images.png.inicial.image(
                fit: BoxFit.fill,
              ),
              const Align(
                child: Spaceman(
                  animation: 'iddle',
                  height: 150,
                  width: 150,
                ),
              )
            ],
          ),
        );
      }
      if (tile.isFinal) {
        _backgroundImage = Assets.images.png.goal.image(fit: BoxFit.fill);
      } else {
        return Container();
      }
    } else if (!tile.isPartOfSolution) {
      _backgroundImage = Assets.images.png.empty.image(fit: BoxFit.fill);
    } else {
      // Road Direction
      _backgroundImage = Image.asset(
        'assets/images/png/'
        '${tile.enterDirection.name}_${tile.exitDirection.name}.png',
        fit: BoxFit.fill,
      );
    }

    return GestureDetector(
      onTap: () => onTilePressed(tile),
      child: Card(
        color: Colors.transparent,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 3,
        child: _backgroundImage,
      ),
    );
  }
}
