import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PopupLoader {
  Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: Center(
            child: Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(100),
                ),
              ),
              child: Center(
                child: SpinKitCircle(
                  color: Theme.of(context).primaryColor,
                  size: 30,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
