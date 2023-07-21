/* -------------------------------------------------------------------------- */
/*                                   imports                                  */
/* -------------------------------------------------------------------------- */
import 'package:flutter/material.dart';
import 'package:mygrapgview/custome_tree_graph.dart';

void main() => runApp(const MyApp());

/* -------------------------------------------------------------------------- */
/*                                   My App                                   */
/* -------------------------------------------------------------------------- */
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomeTreeGraph(),
    );
  }
}
