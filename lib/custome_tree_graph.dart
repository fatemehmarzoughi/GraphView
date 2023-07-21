/* -------------------------------------------------------------------------- */
/*                                   imports                                  */
/* -------------------------------------------------------------------------- */
import 'package:flutter/material.dart';
import 'package:mygrapgview/data/node.dart';
import 'package:mygrapgview/components/line/draw_lines.dart';
import 'package:mygrapgview/functionalities/add_relation.dart';
import 'package:mygrapgview/functionalities/remove_node.dart';
import 'package:mygrapgview/functionalities/remove_relation.dart';
import 'package:mygrapgview/components/box/movable_stack.dart';
import 'package:mygrapgview/data/relation.dart';

/* -------------------------------------------------------------------------- */
/*                             Custome Tree Graph                             */
/* -------------------------------------------------------------------------- */
class CustomeTreeGraph extends StatefulWidget {
  const CustomeTreeGraph({Key? key}) : super(key: key);

  @override
  State<CustomeTreeGraph> createState() => _CustomeTreeGraphState();
}

class _CustomeTreeGraphState extends State<CustomeTreeGraph> {
  String? removableNodeText;

  String? fromNode;
  String? toNode;

  bool reload = false;

  int rgb1 = 255;
  int rgb2 = 1;
  int rgb3 = 1;
  double rgb4 = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          toolBar(context),
          space(context),
        ],
      ),
    );
  }

  Widget toolBar(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          /* ------------------------------ add node inputes ----------------------------- */
          Wrap(
            direction: Axis.horizontal,
            children: [
              SizedBox(
                width: 100,
                child: TextFormField(
                  key: const Key('from_text_input'),
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(labelText: 'from'),
                  onChanged: (text) {
                    setState(() {
                      fromNode = text;
                    });
                  },
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              SizedBox(
                width: 100,
                child: TextFormField(
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(labelText: 'to'),
                  onChanged: (text) {
                    setState(() {
                      toNode = text;
                    });
                  },
                ),
              ),
            ],
          ),
          Wrap(
            children: [
              Container(
                padding: const EdgeInsets.only(right: 15),
                width: 100,
                child: TextFormField(
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(labelText: 'rgb'),
                  onChanged: (text) {
                    setState(() {
                      rgb1 = int.parse(text);
                    });
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 15),
                width: 100,
                child: TextFormField(
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(labelText: 'rgb'),
                  onChanged: (text) {
                    setState(() {
                      rgb2 = int.parse(text);
                    });
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 15),
                width: 100,
                child: TextFormField(
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(labelText: 'rgb'),
                  onChanged: (text) {
                    setState(() {
                      rgb3 = int.parse(text);
                    });
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 15),
                width: 100,
                child: TextFormField(
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(labelText: 'rgb'),
                  onChanged: (text) {
                    setState(() {
                      rgb4 = double.parse(text);
                    });
                  },
                ),
              ),
            ],
          ),
          /* -------------------- add and remove relations buttons -------------------- */
          Column(
            children: [
              ElevatedButton(
                key: const Key('add_btn'),
                onPressed: () {
                  addRelation(
                    fromNode,
                    toNode,
                    rgb1,
                    rgb2,
                    rgb3,
                    rgb4,
                    MediaQuery.of(context).size.width,
                  );
                  setState(() {
                    reload = !reload;
                  });
                },
                child: const Text('add relation'),
              ),
              const SizedBox(
                height: 1,
              ),
              ElevatedButton(
                key: const Key('remove_relation_btn'),
                onPressed: () {
                  removeRelation(fromNode, toNode);
                  setState(() {
                    reload = !reload;
                  });
                },
                child: const Text('remove relation'),
              ),
            ],
          ),
          /* ---------------------------- remove node input ---------------------------- */
          Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              SizedBox(
                width: 100,
                child: TextFormField(
                  key: const Key('remove_text_input'),
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(labelText: "node's title"),
                  onChanged: (text) {
                    setState(() {
                      removableNodeText = text;
                    });
                  },
                ),
              ),
              ElevatedButton(
                key: const Key('remove_btn'),
                onPressed: () {
                  if (removableNodeText != null) {
                    var removableNode = nodes.where(
                      (e) => e.text == removableNodeText,
                    );
                    removeNode(removableNode.first, true);
                    setState(() {
                      reload = !reload;
                    });
                  }
                },
                child: const Text('remove'),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget space(BuildContext context) {
    return Expanded(
      key: const Key('convas'),
      child: InteractiveViewer(
        panEnabled: true,
        boundaryMargin: const EdgeInsets.all(800),
        minScale: .0001,
        maxScale: 6,
        child: Container(
          width: MediaQuery.of(context).size.width * 3,
          clipBehavior: Clip.none,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.orange,
              width: 1,
            ),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              ...List<Widget>.generate(
                relations.length,
                (index) {
                  return CustomPaint(
                    size: MediaQuery.of(context).size,
                    painter: ShapePainter(indexOfRelation: index),
                  );
                },
              ),
              ...List<Widget>.generate(
                nodes.length,
                (index) {
                  return MoveableStackItem(
                    text: nodes[index].text,
                    positionX: nodes[index].positionX,
                    positionY: nodes[index].positionY,
                    color: nodes[index].color,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
