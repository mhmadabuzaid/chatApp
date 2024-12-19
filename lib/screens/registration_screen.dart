import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class RegistrationScreen extends StatefulWidget {
  static const String id ='registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
 late   String email;
 late  String password;
 final _auth=FirebaseAuth.instance;
 bool showSpinner=false;

 void checkFirebase() async {
   try {
     // Check if any Firebase app is already initialized
     if (Firebase.apps.isEmpty) {
       await Firebase.initializeApp();
       print("Firebase has been successfully initialized.");
     } else {
       print("Firebase is already initialized.");
     }
   } catch (e) {
     print("Error initializing Firebase: $e");
   }
 }
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkFirebase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                  email=value;
                  print(email);
                },
                decoration: ktextinputDecoration.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                 obscureText: true,
                 onChanged: (value) {
                  //Do something with the user input.
                  password=value;
                  print(password);
                }

                ,
                decoration: ktextinputDecoration.copyWith(hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed:   () async{
                      setState(() {
                        showSpinner=true;
                      });
                      //Implement registration functionality.

                        try {
                          final user = await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);

                          Navigator.pushNamed(context, ChatScreen.id);
                          setState(() {
                            showSpinner=false;
                          });
                        }
                        catch (e) {
                          print(e);
                        }


                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
