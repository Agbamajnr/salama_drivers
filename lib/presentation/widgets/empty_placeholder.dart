import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EmptyPlaceholder extends StatelessWidget {
  final String text;
  const EmptyPlaceholder({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/empty.png"))
          ),
        ),
        const Gap(3),
        Text(
          text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
