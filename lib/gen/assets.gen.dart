/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  $AssetsImagesJpgGen get jpg => const $AssetsImagesJpgGen();
  $AssetsImagesPngGen get png => const $AssetsImagesPngGen();
  $AssetsImagesSvgGen get svg => const $AssetsImagesSvgGen();
}

class $AssetsImagesJpgGen {
  const $AssetsImagesJpgGen();

  /// File path: assets/images/jpg/background_space.jpg
  AssetGenImage get backgroundSpace =>
      const AssetGenImage('assets/images/jpg/background_space.jpg');
}

class $AssetsImagesPngGen {
  const $AssetsImagesPngGen();

  /// File path: assets/images/png/down_left.png
  AssetGenImage get downLeft =>
      const AssetGenImage('assets/images/png/down_left.png');

  /// File path: assets/images/png/down_right.png
  AssetGenImage get downRight =>
      const AssetGenImage('assets/images/png/down_right.png');

  /// File path: assets/images/png/down_up.png
  AssetGenImage get downUp =>
      const AssetGenImage('assets/images/png/down_up.png');

  /// File path: assets/images/png/empty.png
  AssetGenImage get empty => const AssetGenImage('assets/images/png/empty.png');

  /// File path: assets/images/png/left_down.png
  AssetGenImage get leftDown =>
      const AssetGenImage('assets/images/png/left_down.png');

  /// File path: assets/images/png/left_right.png
  AssetGenImage get leftRight =>
      const AssetGenImage('assets/images/png/left_right.png');

  /// File path: assets/images/png/left_up.png
  AssetGenImage get leftUp =>
      const AssetGenImage('assets/images/png/left_up.png');

  /// File path: assets/images/png/right-left.png
  AssetGenImage get rightLeft =>
      const AssetGenImage('assets/images/png/right-left.png');

  /// File path: assets/images/png/right_down.png
  AssetGenImage get rightDown =>
      const AssetGenImage('assets/images/png/right_down.png');

  /// File path: assets/images/png/right_up.png
  AssetGenImage get rightUp =>
      const AssetGenImage('assets/images/png/right_up.png');

  /// File path: assets/images/png/up_down.png
  AssetGenImage get upDown =>
      const AssetGenImage('assets/images/png/up_down.png');

  /// File path: assets/images/png/up_left.png
  AssetGenImage get upLeft =>
      const AssetGenImage('assets/images/png/up_left.png');

  /// File path: assets/images/png/up_right.png
  AssetGenImage get upRight =>
      const AssetGenImage('assets/images/png/up_right.png');
}

class $AssetsImagesSvgGen {
  const $AssetsImagesSvgGen();

  /// File path: assets/images/svg/Background space.jpg
  AssetGenImage get backgroundSpace =>
      const AssetGenImage('assets/images/svg/Background space.jpg');

  /// File path: assets/images/svg/background_space2.svg
  SvgGenImage get backgroundSpace2 =>
      const SvgGenImage('assets/images/svg/background_space2.svg');

  /// File path: assets/images/svg/orange_planet.svg
  SvgGenImage get orangePlanet =>
      const SvgGenImage('assets/images/svg/orange_planet.svg');

  /// File path: assets/images/svg/pink_and_blue_planet.svg
  SvgGenImage get pinkAndBluePlanet =>
      const SvgGenImage('assets/images/svg/pink_and_blue_planet.svg');

  /// File path: assets/images/svg/pink_and_cian_planet.svg
  SvgGenImage get pinkAndCianPlanet =>
      const SvgGenImage('assets/images/svg/pink_and_cian_planet.svg');

  /// File path: assets/images/svg/pink_and_orange_planet.svg
  SvgGenImage get pinkAndOrangePlanet =>
      const SvgGenImage('assets/images/svg/pink_and_orange_planet.svg');

  /// File path: assets/images/svg/pink_planet.svg
  SvgGenImage get pinkPlanet =>
      const SvgGenImage('assets/images/svg/pink_planet.svg');

  /// File path: assets/images/svg/start_btn.svg
  SvgGenImage get startBtn =>
      const SvgGenImage('assets/images/svg/start_btn.svg');

  /// File path: assets/images/svg/title.svg
  SvgGenImage get title => const SvgGenImage('assets/images/svg/title.svg');
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName) : super(assetName);

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      color: color,
      colorBlendMode: colorBlendMode,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
    );
  }

  String get path => _assetName;
}
