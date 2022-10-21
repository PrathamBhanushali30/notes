import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: MediaQuery.of(context).size.width,),
          ElevatedButton(
              onPressed: (){
                FirebaseAuth.instance.signOut()
                    .then((value) {
                      Navigator.pushReplacementNamed(context, '/login');
                })
                    .catchError((e) => print(e));
              },
              child: Text("Logout")),
        ],
      ),
    );
  }
}
