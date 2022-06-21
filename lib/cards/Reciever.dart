import 'package:flutter/material.dart';

class Reciever extends StatefulWidget {
  const Reciever({Key? key, required this.msg}) : super(key: key);
  final String msg;
  @override
  State<Reciever> createState() => _RecieverState();
}

class _RecieverState extends State<Reciever> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.greenAccent,
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(child: Text(widget.msg)),
        ),
      ),
    );
  }
}
