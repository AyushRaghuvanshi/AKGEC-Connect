
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({ Key? key }) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late TextEditingController _email ;
  late TextEditingController _password;
  @override
  void initState() {
    _email=TextEditingController();
    _password=TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    const width=325.0;
    return Scaffold(
      body: FutureBuilder(
        future: Firebase.initializeApp(
        ),
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.done:
              return SingleChildScrollView(
                child: Center(
                  child: SizedBox(
                    width: 400,
                    child: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start, 
                        children: [
                          const SizedBox(   
                      height: 200,
                      child:Padding(
                          padding: EdgeInsets.fromLTRB(30,100,0,0),
                          child: Text("Create Account",
                          style: TextStyle(fontSize: 35,
                            fontWeight: FontWeight.bold,
                          )),
                        ),
                      ),
                          Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Email ID:"),
                      SizedBox(
                    width: width,
                    child: TextField(controller: _email,
                                  
                                  autocorrect: false,
                                  enableSuggestions: false,
                                  decoration: const InputDecoration(hintText: "Enter you email here"),
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
                        const Text("Password:"),
                        SizedBox(
                          width: width,
                          child: TextField(controller: _password,
                                        obscureText: true,
                                        autocorrect: false,
                                        enableSuggestions: false,
                                        decoration: const InputDecoration(hintText: "Enter you password here"),      
                          ),
                        ),
                      ],
                    ),
                           ),
                         ),
                          
                          Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Center(
                  child: Container(
                    width: width,
                    decoration: const BoxDecoration(color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.black,
                            onSurface: Colors.grey,
                  ),
                          
                          onPressed: ()async{
                            final email=_email.text;
                            final password=_password.text;
                            await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
                          }, 
                          child: const Text("Register",style:TextStyle(color: Colors.white),)),
                  ),
                ),
                          ),
                          
                          
                          const Center(child: Text("Already have an account?",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black45),)),                          
                          Center(child: TextButton(onPressed: () {}, style:TextButton.styleFrom(
                            primary: Colors.black,
              
                            backgroundColor: Colors.white,
                            onSurface: Colors.grey)
                            ,child: const Text("Login",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),),))
                        ],
                      ),
                  ),
                ),
              );
            default:
              return const Center(child: Text("Loading..."));
          }          
        },        
      ),
    );
  }
}

