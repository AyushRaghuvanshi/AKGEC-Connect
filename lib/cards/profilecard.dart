import 'package:flutter/material.dart';
import 'package:project/database/following_system.dart';
import 'package:project/mainpagesections/profilepage.dart';

class profilecard extends StatefulWidget {
  const profilecard(
      {Key? key, required this.name, required this.pic, required this.id})
      : super(key: key);
  final String name, pic, id;

  @override
  State<profilecard> createState() => _profilecardState();
}

class _profilecardState extends State<profilecard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () async {
          try {
            await check_if_following(widget.id);
          } catch (e) {}
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage(id: widget.id)),
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
