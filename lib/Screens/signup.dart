import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {

  final _auth=FirebaseAuth.instance;
  late String email;
  late String password;
  final _firestore =FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: 'email',
            ),
            onChanged: (value){
              setState(() {
                email=value;
              });
            },
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'password',
            ),
            onChanged: (value){
              setState(() {
                password=value;
              });
            },
          ),
          ElevatedButton(
              onPressed: () async{
                 FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((signedInUser) {
                   _firestore.collection('users').add(
                     {
                       'email':email,
                       'pass': password,
                     }).then((value) {
                         Navigator.pushNamed(context, '/home');
                   }).catchError((e) => print(e));
                 }).catchError((e) => print(e));
              },
              child: Text('signup')),
        ],
      ),
    );
  }
}
