import 'package:flutter/material.dart';

class ContentArea extends StatefulWidget {
  const ContentArea({super.key});

  @override
  State<ContentArea> createState() => _ContentAreaState();
}

class _ContentAreaState extends State<ContentArea> {
  double lastPoint = 0.0;
  double startPoint = 0.0;
  double updatedPoint = 0.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (point) {
        Size size = MediaQuery.of(context).size;
        double pixel = point.globalPosition.dx;

        if (pixel < size.width * 0.5) {
          print("Previous");
        } else if (pixel > size.width * 0.5) {
          print("Next");
        }
      },
      onHorizontalDragStart: (detail) {
        startPoint = lastPoint = updatedPoint = detail.globalPosition.dy;
      },
      onHorizontalDragUpdate: (details) {
        lastPoint = updatedPoint;
        updatedPoint = details.globalPosition.dy;
      },
      onHorizontalDragEnd: (details) {
        if (startPoint < updatedPoint) {
          print("Swipe Left");
        } else {
          print("swipe Right");
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8cG9ydHJhaXR8ZW58MHx8MHx8fDA%3D",
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
