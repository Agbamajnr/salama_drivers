import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SlideToActionScreen extends StatefulWidget {
  @override
  _SlideToActionScreenState createState() => _SlideToActionScreenState();
}

class _SlideToActionScreenState extends State<SlideToActionScreen> {
  // Controls the position of the sliding icon
  double _dragPosition = 0.0;
  bool _isOnline = false;

  // Width of the button container
  final double _buttonWidth = 250.0;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: _buttonWidth,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Slide Text
          Center(
            child: Text(
              _isOnline ? 'Slide to go Offline' : 'Slide to go online',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Gap(10),
          // Slide Icon
          Positioned(
            left: _dragPosition,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                setState(() {
                  _dragPosition += details.delta.dx;

                  // Limit the drag position within the container
                  if (_dragPosition < 0) {
                    _dragPosition = 0;
                  } else if (_dragPosition > _buttonWidth - 60) {
                    _dragPosition = _buttonWidth - 60;
                  }
                });
              },
              onHorizontalDragEnd: (details) {
                // Check if dragged far enough to complete the action
                if (_dragPosition > _buttonWidth * 0.7) {
                  setState(() {
                    _isOnline = true;
                  });
                } else {
                  setState(() {
                    _dragPosition =
                        0; // Reset position if not dragged far enough
                  });
                }
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_forward, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
