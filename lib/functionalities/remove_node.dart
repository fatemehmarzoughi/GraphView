/* -------------------------------------------------------------------------- */
/*                                   imports                                  */
/* -------------------------------------------------------------------------- */
import 'package:mygrapgview/data/node.dart';
import 'package:mygrapgview/data/relation.dart';

/* -------------------------------------------------------------------------- */
/*                                 remove node                                */
/* -------------------------------------------------------------------------- */

/// This variable must be defined outside the removeNode function because,
/// removeNode function is a recursive one
List<Node> childrenNodes = [];

void removeNode(Node node, bool firstIteration) {
  //chack if the node has children or not
  relations.forEach((element) {
    if (element.sourceNode == node) {
      childrenNodes.add(element.destinationNode);
    }
  });

  // remove all the relations between the node and it's parents
  relations.removeWhere((element) => element.destinationNode == node);
  // remove all the relations between the node and it's children
  relations.removeWhere((element) => element.sourceNode == node);
  //remove the node itself
  nodes.remove(node);

  if (!firstIteration) childrenNodes.remove(childrenNodes.first);

  if (childrenNodes.isEmpty) {
    childrenNodes = [];
    return;
  }

  //call this function for the node's children again
  removeNode(childrenNodes.first, false);
}
