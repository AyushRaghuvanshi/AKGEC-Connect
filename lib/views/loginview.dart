import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';






class LoginView extends StatefulWidget {
  const LoginView({Key? key, }) : super(key: key);
  

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

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
                        child:Padding(
                            padding: EdgeInsets.fromLTRB(30,100,0,0),
                            child: Text("Login",
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
                        const Text("User ID:"),
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
                              await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
                              
                              Navigator.of(context).pushNamedAndRemoveUntil('/mainpage/', (route) => false);
                            }, 
                            child: const Text("Login",style:TextStyle(color: Colors.white),)),
                    ),
                  ),
                            ),
                            
                            
                            const Center(child: Text("Don't have an account?",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black45),)),                          
                            Center(child: TextButton(onPressed: () {
                              Navigator.of(context).pushNamedAndRemoveUntil('/register/', (route) => false);
                            }, style:TextButton.styleFrom(
                              primary: Colors.black,
                
                              backgroundColor: Colors.white,
                              onSurface: Colors.grey)
                              ,child: const Text("Register",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),),))
                          ],
                        ),
                    ),
                  ),
                ),
    );
  }
}