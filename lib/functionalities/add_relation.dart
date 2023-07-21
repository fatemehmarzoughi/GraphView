/* -------------------------------------------------------------------------- */
/*                                   imports                                  */
/* -------------------------------------------------------------------------- */
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mygrapgview/data/node.dart';
import 'package:mygrapgview/data/relation.dart';

/* -------------------------------------------------------------------------- */
/*                               add a  relation                              */
/* -------------------------------------------------------------------------- */

void addRelation(
  String? fromNode,
  String? toNode,
  int rgb1,
  int rgb2,
  int rgb3,
  double rgb4,
  double width,
) {
  var sourceNodeIndex;
  var destinationNodeIndex;

  // if the user didn't insert any value inside the text inputs
  if (fromNode == null || toNode == null) return;

  //check if the entered fromNode exists in the nodes or not
  Iterable<Node> fromNodeElement = nodes.where((element) {
    if (element.text == fromNode) {
      sourceNodeIndex = nodes.indexOf(element);
      return true;
    }
    return false;
  });
  if (fromNodeElement.isEmpty) {
    // node doesn't exists => create the source node
    nodes.add(
      Node(
        positionX: width / 2,
        positionY: 10,
        text: fromNode,
        color: Colors.orange,
      ),
    );

    // index of last inserted node (which is the one that we have add in previous line)
    sourceNodeIndex = nodes.length - 1;
  }

  //check if the entered toNode exists in the nodes or not
  Iterable<Node> toNodeElement = nodes.where((element) {
    if (element.text == toNode) {
      destinationNodeIndex = nodes.indexOf(element);
      return true;
    }
    return false;
  });
  if (toNodeElement.isEmpty) {
    // node doesn't exists => create the destination node

    /// search that how many childreen does the node have
    Iterable<Relation> parentNodes = relations
        .where((element) => element.sourceNode == nodes[sourceNodeIndex]);

    var numberOfChildren = parentNodes.length;
    var positionX;
    var positionY;

    //generate the position of the children
    if (numberOfChildren == 1) {
      positionX = nodes[sourceNodeIndex].positionX - 30;
      positionY = nodes[sourceNodeIndex].positionY + 30;
    } else if (numberOfChildren == 2) {
      positionX = nodes[sourceNodeIndex].positionX + 30;
      positionY = nodes[sourceNodeIndex].positionY + 30;
    } else if (numberOfChildren == 0) {
      positionX = nodes[sourceNodeIndex].positionX;
      positionY = nodes[sourceNodeIndex].positionY + 40;
    } else {
      var rng = Random().nextInt(100) - 100;
      positionX = nodes[sourceNodeIndex].positionX + rng;
      positionY = nodes[sourceNodeIndex].positionY + 50;
    }

    nodes.add(
      Node(
        positionX: positionX,
        positionY: positionY,
        text: toNode,
        color: Color.fromRGBO(rgb1, rgb2, rgb3, rgb4),
      ),
    );

    destinationNodeIndex = nodes.length - 1;
  }

  //create the relation between source node and destination node
  relations.add(
    Relation(
      sourceNode: nodes[sourceNodeIndex],
      destinationNode: nodes[destinationNodeIndex],
    ),
  );
}
