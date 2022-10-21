import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Screens/phonelogin.dart';
import 'package:firebase/Screens/users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:auth_buttons/auth_buttons.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {

  late String email;
  late String password;

  final _firestore = FirebaseFirestore.instance;

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
              onPressed: (){
                FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
                    .then((firebaseUser) {
                      Navigator.of(context).pushReplacementNamed('/home');
                })
                    .catchError((e) => print(e));
              },
              child: Text('signin')),
          ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/signup');
              },
              child: Text('signup')),

          GoogleAuthButton(
            themeMode: ThemeMode.dark,
            onPressed: (){
              signInWithGoogle().then((onValue){
                _firestore.collection('users').doc('auth').collection('gusers').add({
                  'email': email1, 'image': imageUrl, 'name': name,
                }).then((onValue){
                  Navigator.pushNamed(context, '/home');
                }).catchError((e) => print(e));
              });
            },
          ),
          InkWell(
            onTap: (){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => CallLogin()), (route) => false);
            },
            child: Text('Login using phone'),
          )

          // FacebookAuthButton(
          //   themeMode: ThemeMode.dark,
          //   onPressed: (){
          //     signInWithFacebook().then((onValue){
          //       _firestore.collection('users').doc('auth').collection('fusers').add({
          //         'email': email2, 'image': imageUrl1, 'name': name1,
          //       }).then((onValue) {
          //         Navigator.pushNamed(context, '/home');
          //       }).catchError((e) => print(e));
          //     });
          //   },
          // ),
        ],
      ),
    );
  }
}
