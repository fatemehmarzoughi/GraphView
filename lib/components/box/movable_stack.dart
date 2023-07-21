/* -------------------------------------------------------------------------- */
/*                                   imports                                  */
/* -------------------------------------------------------------------------- */

import 'package:flutter/material.dart';
import 'package:mygrapgview/data/node.dart';

/* -------------------------------------------------------------------------- */
/*                                Movable Stack                               */
/* -------------------------------------------------------------------------- */
class MoveableStackItem extends StatefulWidget {
  /* ------------------------------- Attributes ------------------------------- */
  final String text;
  final double positionY;
  final double positionX;
  final Color color;
  /* ------------------------------- Constructor ------------------------------ */
  const MoveableStackItem({
    Key? key,
    required this.text,
    required this.positionX,
    required this.positionY,
    required this.color,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MoveableStackItemState();
  }
}

class _MoveableStackItemState extends State<MoveableStackItem> {
  bool reload = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late int index;
    nodes.forEach(
      (n) {
        if (n.text == widget.text) {
          index = nodes.indexOf(n);
        }
      },
    );
    return Positioned(
      top: nodes[index].positionY,
      left: nodes[index].positionX,
      child: GestureDetector(
        onTapUp: (tapInfo) {
          showAlert(index);
        },
        onPanUpdate: (tapInfo) {
          nodes[index].positionX += tapInfo.delta.dx;
          nodes[index].positionY += tapInfo.delta.dy;
          setState(() {
            reload = true;
          });
        },
        child: Container(
          padding: const EdgeInsets.only(right: 10, left: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: widget.color,
            border: Border.all(
              color: Colors.white,
              width: .1,
            ),
          ),
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                widget.text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  showAlert(int index) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(nodes[index].text),
      ),
    );
  }
}
