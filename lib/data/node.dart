/* -------------------------------------------------------------------------- */
/*                                   imports                                  */
/* -------------------------------------------------------------------------- */
import 'package:flutter/material.dart';

/* -------------------------------------------------------------------------- */
/*                                 Node entity                                */
/* -------------------------------------------------------------------------- */
class Node {
  /* ------------------------------- Attributes ------------------------------- */
  double positionX;
  double positionY;
  String text;
  Color color = Colors.orange;
  /* ------------------------------- Constructor ------------------------------ */
  Node({
    required this.positionX,
    required this.positionY,
    required this.text,
    required this.color,
  });
}

List<Node> nodes = [];
