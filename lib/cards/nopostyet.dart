import 'package:flutter/material.dart';

class Nopostyet extends StatefulWidget {
  const Nopostyet({Key? key}) : super(key: key);

  @override
  State<Nopostyet> createState() => _NopostyetState();
}

class _NopostyetState extends State<Nopostyet> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: const [
        const Icon(Icons.cancel_outlined, size: 100),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Text("NO POST YET", style: TextStyle(fontSize: 25)),
        )
      ],
    ));
  }
}
