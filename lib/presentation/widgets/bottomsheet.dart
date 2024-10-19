import 'package:flutter/material.dart';


enum AnimationStyles { defaultStyle, custom, none }

class SheetComponents {
  AnimationStyle? _getAnimationStyle(AnimationStyles style) {
    return switch (style) {
      AnimationStyles.defaultStyle => null,
      AnimationStyles.custom => AnimationStyle(
          duration: const Duration(seconds: 1),
          reverseDuration: const Duration(seconds: 1),
        ),
      AnimationStyles.none => AnimationStyle.noAnimation,
    };
  }

void modalBottomSheet(
  BuildContext context,
  Widget content, {
  double initialChildSize = 0.5,
  double maxChildSize = 0.9,
  Widget? header,
  Widget? footer,
}) {
  showModalBottomSheet(
    showDragHandle: true,
    isScrollControlled: true,
    context: context,
    constraints: const BoxConstraints(
      maxWidth: 640,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(10)
      ),
    ),
    sheetAnimationStyle: _getAnimationStyle(AnimationStyles.custom),
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: initialChildSize,
        maxChildSize: maxChildSize,
        minChildSize: 0.1,
        expand: false,
        builder: (context, scrollController) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              children: [
                if (header != null) header,
                Expanded(
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      SliverToBoxAdapter(child: content),
                    ],
                  ),
                ),
                if (footer != null) footer,
              ],
            ),
          );
        },
      );
    },
  );
}


  void standardSideSheet(
    BuildContext context,
    double elevation,
    isScrollControlled,
    double maxheight,
    Widget content,
    AnimationStyles animationStyle,
  ) {
    showBottomSheet(
      showDragHandle: true,
      elevation: elevation,
      context: context,
      constraints: BoxConstraints(
        maxWidth: 640,
        maxHeight: MediaQuery.of(context).size.height * maxheight,
      ),
      sheetAnimationStyle: _getAnimationStyle(animationStyle),
      builder: (context) {
        return content;
      },
    );
  }
}