/* -------------------------------------------------------------------------- */
/*                                   imports                                  */
/* -------------------------------------------------------------------------- */
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mygrapgview/data/relation.dart';

/* -------------------------------------------------------------------------- */
/*                                 Line drawer                                */
/* -------------------------------------------------------------------------- */
class ShapePainter extends CustomPainter {
  /* ------------------------------- Attributes ------------------------------- */
  int indexOfRelation;
  /* ------------------------------- Constructor ------------------------------ */
  ShapePainter({
    required this.indexOfRelation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    /* -------------------------------- draw line ------------------------------- */
    Paint _paint = Paint()
      ..color = Colors.white
      ..strokeWidth = .5
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;
    /* ------------------- draw circle in the end of the line ------------------- */
    Paint _paintCircle = Paint()
      ..color = Colors.white
      ..strokeWidth = .4
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;

    /* ------------------------- Generate starting point ------------------------ */
    // double startingPoint = relations[indexOfRelation].sourceNode.positionX + 15;
    // bool childInTheRightSide =
    //     relations[indexOfRelation].destinationNode.positionX + 15 >
    //         relations[indexOfRelation].sourceNode.positionX + 50;
    // bool childInTheMiddle =
    //     relations[indexOfRelation].destinationNode.positionX + 15 <
    //             relations[indexOfRelation].sourceNode.positionX + 50 &&
    //         relations[indexOfRelation].destinationNode.positionX + 15 >
    //             relations[indexOfRelation].sourceNode.positionX + 10;
    // double sourceNodeWidth =
    //     (relations[indexOfRelation].sourceNode.text.length * 3.5) + 25;
    // double sourceNodeHeight = 6;

    // if (childInTheRightSide) {
    //   startingPoint =
    //       relations[indexOfRelation].sourceNode.positionX + sourceNodeWidth;
    //   sourceNodeHeight = 5.8;
    //   print('bring the starting point to right');
    // } else if (childInTheMiddle) {
    //   startingPoint = relations[indexOfRelation].sourceNode.positionX +
    //       (sourceNodeWidth / 2);
    //   sourceNodeHeight = 11.8;
    //   print('bring the starting point to middle');
    // } else {
    //   startingPoint = relations[indexOfRelation].sourceNode.positionX - 1;
    //   sourceNodeHeight = 5.8;

    //   print('bring the starting point to left');
    // }
    /* ----------------------------------- *** ---------------------------------- */

    var path = Path()
      /* ----------------------------- Starting point ----------------------------- */
      ..moveTo(
        relations[indexOfRelation].sourceNode.positionX + 15,
        (relations[indexOfRelation].sourceNode.positionY + 11.8) / 1.055,
      )
      /* ------------------------------ Curved design ----------------------------- */
      ..cubicTo(
        1.015 * (relations[indexOfRelation].sourceNode.positionX + 15),
        1.015 * (relations[indexOfRelation].sourceNode.positionY + 15),
        (relations[indexOfRelation].sourceNode.positionX + 15) / 1.025,
        (relations[indexOfRelation].destinationNode.positionY) / 1.025,
        relations[indexOfRelation].destinationNode.positionX + 15 / 1.025,
        relations[indexOfRelation].destinationNode.positionY / 1.015,
      )
      /* -------------------------------- end Point ------------------------------- */
      ..lineTo(
        relations[indexOfRelation].destinationNode.positionX + 15,
        relations[indexOfRelation].destinationNode.positionY,
      );

    Path dashPath = Path();

    double dashWidth = 2.0;
    double dashSpace = 1.0;
    double distance = 0.0;

    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        dashPath.addPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth;
        distance += dashSpace;
      }
    }
    canvas.drawCircle(
      Offset(
        relations[indexOfRelation].sourceNode.positionX + 15,
        relations[indexOfRelation].sourceNode.positionY + 11,
      ),
      1,
      _paintCircle,
    );
    canvas.drawPath(dashPath, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
