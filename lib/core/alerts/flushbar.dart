
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:salama_users/main.dart';


class AppFlushbar {
  static void show(
    String text, {
    bool isError = true,
    String? title,
  }) {
    Flushbar(
      messageText: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: const BoxDecoration(
          border: Border(left: BorderSide(color: Colors.white)),
        ),
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 16),
        ),
      ),
      icon: Icon(
        isError ? Icons.error : Icons.check,
        color: Colors.white,
      ),
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      borderRadius: BorderRadius.circular(20),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: isError
          ? const Color.fromARGB(255, 175, 78, 71)
          : Colors.green
    ).show(navKey.currentContext!);
  }
}
