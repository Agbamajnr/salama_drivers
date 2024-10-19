// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:salama_users/core/styles/colors.dart';
import 'package:shimmer/shimmer.dart';


class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage(
      {super.key,
      required this.url,
      required this.height,
      required this.width,
      this.borderRadius = 0});
  final String? url;
  final double height;
  final double width;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return url != null
        ? CachedNetworkImage(
            imageUrl: url!,
            imageBuilder: (context, imageProvider) => Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => ShimmerContainer(
              height: height,
              width: width,
              borderRadius: borderRadius,
            ),
            errorWidget: (context, url, error) => ImageErrorContainer(
              height: height,
              width: width,
              borderRadius: borderRadius,
            ),
          )
        : ImageErrorContainer(
            height: height,
            width: width,
            borderRadius: borderRadius,
          );
  }
}

class ShimmerContainer extends StatelessWidget {
  const ShimmerContainer({
    super.key,
    required this.height,
    required this.width,
    required this.borderRadius,
  });
  final double height, width, borderRadius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor:  AppColors.primaryGrey.withOpacity(0.5),
      highlightColor:  AppColors.primaryGrey.withOpacity(0.5),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: AppColors.primaryGrey.withOpacity(0.5)
        ),
      ),
    );
  }
}

class ImageErrorContainer extends StatelessWidget {
  const ImageErrorContainer({
    super.key,
    required this.height,
    required this.width,
    required this.borderRadius,
  });
  final double height, width, borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: AppColors.primaryGrey.withOpacity(0.2)
      ),
      child: const Center(
        child: Icon(Icons.error, size: 17),
      ),
    );
  }
}
