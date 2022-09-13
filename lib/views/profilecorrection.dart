import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/database/post.dart';
import 'package:project/database/sevices.dart';
import 'package:project/views/Popup.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late TextEditingController _name;
  late TextEditingController _biography;
  late TextEditingController _sno;
  late TextEditingController _year;
  int genderint = 0;
  int branchint = 0;

  DateTime? _datetime = DateTime.now();
  String? imgurl;
  String dropdownValue = "One";
  String dropValue = "ECE";
  var items = ['Male', 'Female', 'Others', 'Prefer Not to Say'];
  var items2 = ['ECE', 'CS', 'CSE', 'IT'];
  String year = "Enter you year of admission ";
  @override
  void initState() {
    _name = TextEditingController();
    _biography = TextEditingController();
    _sno = TextEditingController();
    _year = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _biography.dispose();
    _sno.dispose();
    _year.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const width = 325.0;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 200,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 100, 0, 0),
                    child: Text("Create Profile",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(100)),
                                child: Image.network(
                                  imgurl ??
                                      'https://t3.ftcdn.net/jpg/03/46/83/96/240_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg',
                                  height: 150,
                                  width: 150,
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () async {
                              final user = FirebaseAuth.instance.currentUser;
                              final uid = user?.uid;
                              String url = await uploadimage(uid.toString());
                              setState(() {
                                imgurl = url;
                              });
                            },
                            child: const Text("Upload Profile Picture")),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Name:"),
                        SizedBox(
                          width: width,
                          child: TextField(
                            controller: _name,
                            autocorrect: false,
                            enableSuggestions: false,
                            decoration: const InputDecoration(
                                hintText: "Enter you name here"),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Biography:"),
                        SizedBox(
                          width: width,
                          child: TextField(
                            controller: _biography,
                            obscureText: false,
                            autocorrect: false,
                            enableSuggestions: false,
                            decoration: const InputDecoration(
                                hintText: "Enter you biography here"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Center(
                    child: SizedBox(
                      width: width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Gender:"),
                          Center(
                            child: SizedBox(
                              width: width,
                              child: DropdownButtonFormField(
                                  dropdownColor: Colors.white,
                                  focusColor: Colors.black,
                                  hint: const Text("Input you gender"),
                                  items: items.map((items) {
                                    return DropdownMenuItem(
                                        child: Text(items), value: items);
                                  }).toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      dropdownValue = val! as String;
                                      switch (dropdownValue) {
                                        case 'Male':
                                          genderint = 0;
                                          break;
                                        case 'Female':
                                          genderint = 1;
                                          break;
                                        case 'Others':
                                          genderint = 2;
                                          break;
                                        case 'Prefer not to say':
                                          genderint = 3;
                                          break;
                                      }
                                    });
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: width,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Date of Birth:   " +
                                _datetime.toString().split(' ')[0]),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: ElevatedButton.icon(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.black)),
                                  label: const Icon(Icons.arrow_drop_down),
                                  icon:
                                      const Icon(Icons.calendar_month_outlined),
                                  onPressed: () {
                                    showDatePicker(
                                            context: context,
                                            initialDate: DateTime(2001),
                                            firstDate: DateTime(1901),
                                            lastDate: DateTime.now())
                                        .then((data) {
                                      setState(() {
                                        _datetime = data;
                                      });
                                    });
                                  }),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Center(
                    child: SizedBox(
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Student No.:"),
                          Center(
                            child: SizedBox(
                              width: width,
                              child: TextField(
                                controller: _sno,
                                decoration: const InputDecoration(
                                    hintText: "Enter your Student No."),
                                keyboardType: TextInputType.number,
                                onChanged: (val) async {
                                  String s = val;

                                  year = "20" + s.substring(0, 2);
                                  int branch = int.parse(s.substring(2, 4));
                                  branchint = branch;
                                  setState(() {
                                    switch (branch) {
                                      case 31:
                                        dropValue = "ECE";
                                        break;
                                      case 13:
                                        dropValue = "IT";
                                        break;
                                      case 12:
                                        dropValue = "CS";
                                        break;
                                      case 01:
                                        dropValue = "CSE";
                                        break;
                                    }
                                  });

                                  _year.text = year;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Center(
                    child: SizedBox(
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Branch:"),
                          DropdownButton<String>(
                            value: dropValue,
                            icon: const Icon(Icons.arrow_drop_down_rounded),
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            underline: Container(
                              height: 2,
                              width: width,
                              color: Colors.black,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropValue = newValue!;

                                switch (dropValue) {
                                  case 'IT':
                                    branchint = 13;
                                    break;
                                  case 'ECE':
                                    branchint = 31;
                                    break;
                                  case 'CS':
                                    branchint = 12;
                                    break;
                                  case 'CSE':
                                    branchint = 10;
                                    break;
                                }
                              });
                            },
                            items: items2
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Center(
                    child: SizedBox(
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Year:"),
                          Center(
                            child: SizedBox(
                              width: width,
                              child: TextField(
                                maxLength: 4,
                                controller: _year,
                                //decoration:  InputDecoration(hintText: year,hintStyle: const TextStyle(color: Colors.black)),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Center(
                    child: Container(
                      width: width,
                      decoration: const BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.black,
                            onSurface: Colors.grey,
                          ),
                          onPressed: () async {
                            final name = _name.text;
                            final bio = _biography.text;
                            final sno = _sno.text;
                            final year = int.parse(_year.text);

                            if (name == "") {
                              await showErrorPopup(
                                  context, 'Please Enter you Name');
                              return;
                            }
                            final user = FirebaseAuth.instance.currentUser;
                            String userw = " ";
                            if (user != null) userw = user.uid;

                            adduser(
                                userw,
                                name,
                                bio,
                                _datetime,
                                sno,
                                genderint,
                                branchint,
                                year,
                                imgurl ??
                                    'https://t3.ftcdn.net/jpg/03/46/83/96/240_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg');
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/email_verification/', (route) => false);
                          },
                          child: const Text(
                            "Sumbit",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
