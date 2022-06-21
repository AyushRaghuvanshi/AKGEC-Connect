import 'package:flutter/material.dart';

class Sender extends StatefulWidget {
  const Sender({Key? key, required this.msg}) : super(key: key);
  final String msg;
  @override
  State<Sender> createState() => _SenderState();
}

class _SenderState extends State<Sender> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(child: Text(widget.msg)),
        ),
      ),
    );
  }
}
