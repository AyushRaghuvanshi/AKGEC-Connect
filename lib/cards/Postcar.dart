// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Postcard extends StatefulWidget {
  const Postcard(
      {Key? key,
      required this.post,
      required this.profilepicture,
      required this.name})
      : super(key: key);

  final String post, profilepicture, name;
  @override
  State<Postcard> createState() => _PostcardState();
}

class _PostcardState extends State<Postcard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
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
                          widget.profilepicture,
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ),
                    Text(
                      widget.name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(widget.post),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
