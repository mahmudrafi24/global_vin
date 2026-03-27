import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/app_colors.dart';
import 'core_screen_utils.dart';

class CommonImage extends StatelessWidget {
  const CommonImage({
    required this.src,
    this.imageColor,
    this.height,
    this.borderRadius = 0,
    this.width,
    this.size,
    this.fill = BoxFit.cover,
    this.defaultImage,
    this.enableGrayscale = false,
    super.key,
    this.borderRadiusCustom,
  });

  final String src;
  final String? defaultImage;
  final Color? imageColor;
  final double? height;
  final double? width;
  final double borderRadius;
  final double? size;
  final bool enableGrayscale;
  final BoxFit fill;
  final BorderRadius? borderRadiusCustom;

  BorderRadius getBorderRadius() {
    return borderRadiusCustom ?? BorderRadius.circular(borderRadius.r);
  }

  @override
  Widget build(BuildContext context) {
    try {
      if (src.isEmpty) return placeholder();

      if (!enableGrayscale) return getImage();

      return ColorFiltered(
        colorFilter: const ColorFilter.matrix(<double>[
          0.2126, 0.7152, 0.0722, 0, 0,
          0.2126, 0.7152, 0.0722, 0, 0,
          0.2126, 0.7152, 0.0722, 0, 0,
          0, 0, 0, 1, 0,
        ]),
        child: getImage(),
      );
    } catch (e) {
      return ClipRRect(
        borderRadius: getBorderRadius(),
        child: _buildErrorWidget(),
      );
    }
  }

  Widget placeholder() {
    return ClipRRect(
      borderRadius: getBorderRadius(),
      child: SizedBox(
        height: size ?? height,
        width: size ?? width,
        child: Container(color: AppColors.surface),
      ),
    );
  }

  Widget getImage() {
    if (src.startsWith('assets/svg') || src.endsWith('.svg')) {
      return _buildSvgImage();
    } else if (src.startsWith('assets/')) {
      return _buildPngImage();
    } else if (src.startsWith('http')) {
      return _buildNetworkImage();
    } else {
      return _buildFileImage();
    }
  }

  Widget _buildErrorWidget() {
    if (defaultImage == null) {
      return const SizedBox();
    }
    return Image.asset(defaultImage!);
  }

  Widget _buildNetworkImage() {
    return ClipRRect(
      borderRadius: getBorderRadius(),
      child: CachedNetworkImage(
        height: size ?? height,
        width: size ?? width,
        imageUrl: src,
        fit: fill,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider, fit: fill),
          ),
        ),
        progressIndicatorBuilder: (context, url, downloadProgress) {
          return Shimmer.fromColors(
            baseColor: AppColors.surfaceLight,
            highlightColor: AppColors.divider,
            child: Container(
              height: size ?? height,
              width: size ?? width,
              color: AppColors.surfaceLight,
            ),
          );
        },
        errorWidget: (context, url, error) {
          debugPrint('CommonImage error: $error');
          return _buildErrorWidget();
        },
      ),
    );
  }

  Widget _buildSvgImage() {
    return ClipRRect(
      borderRadius: getBorderRadius(),
      child: SvgPicture.asset(
        src,
        colorFilter: imageColor != null
            ? ColorFilter.mode(imageColor!, BlendMode.srcIn)
            : null,
        height: size ?? height,
        width: size ?? width,
        fit: fill,
      ),
    );
  }

  Widget _buildFileImage() {
    return ClipRRect(
      borderRadius: getBorderRadius(),
      child: Image.file(
        File(src),
        color: imageColor,
        height: size ?? height,
        width: size ?? width,
        fit: fill,
      ),
    );
  }

  Widget _buildPngImage() {
    return ClipRRect(
      borderRadius: getBorderRadius(),
      child: Image.asset(
        src,
        color: imageColor,
        height: size ?? height,
        width: size ?? width,
        fit: fill,
        errorBuilder: (context, error, stackTrace) {
          debugPrint('CommonImage error: $error');
          return _buildErrorWidget();
        },
      ),
    );
  }
}
