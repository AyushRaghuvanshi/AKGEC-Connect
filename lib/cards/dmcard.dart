import 'package:flutter/material.dart';
import 'package:project/mainpagesections/dmprofile.dart';

class dmcard extends StatefulWidget {
  const dmcard(
      {Key? key, required this.name, required this.pic, required this.id})
      : super(key: key);
  final String name, pic, id;

  @override
  State<dmcard> createState() => _dmcardState();
}

class _dmcardState extends State<dmcard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => dmprofile(
                    name: widget.name, pic: widget.pic, id: widget.id)),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(200)),
                      child: Image.network(
                        widget.pic,
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                  Text(
                    widget.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
