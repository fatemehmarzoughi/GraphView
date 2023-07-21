/* -------------------------------------------------------------------------- */
/*                                   imports                                  */
/* -------------------------------------------------------------------------- */
import 'package:mygrapgview/data/relation.dart';

/* -------------------------------------------------------------------------- */
/*                              remove a relation                             */
/* -------------------------------------------------------------------------- */
void removeRelation(String? fromNode, String? toNode) {
  relations.removeWhere(
    (element) =>
        element.sourceNode.text == fromNode &&
        element.destinationNode.text == toNode,
  );
}
