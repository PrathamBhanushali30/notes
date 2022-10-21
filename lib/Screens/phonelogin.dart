// ignore_for_file: prefer_function_declarations_over_variables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dash.dart';

class CallLogin extends StatefulWidget {
  const CallLogin({Key? key}) : super(key: key);

  @override
  State<CallLogin> createState() => _CallLoginState();
}

class _CallLoginState extends State<CallLogin> {

  String? phoneNo, smssent, verificationId;

  Future<void> verifyPhone() async{
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId){
      verificationId = verId;
    };
    final PhoneCodeSent smsCodeSent = (String verId, [int? forceCodeResend]){
      verificationId = verId;
      smsCodeDialog(context).then((value){
        print("Code Sent");
      });
    };
    final PhoneVerificationCompleted verificationCompleted = (AuthCredential auth){};
    final PhoneVerificationFailed verificationFailed = (FirebaseAuthException e){
      print('${e.message}');
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: smsCodeSent,
        codeAutoRetrievalTimeout: autoRetrieve,);
  }

  Future smsCodeDialog(BuildContext context){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
      return AlertDialog(
        title: Text('provide OTP'),
        content: TextField(
          onChanged: (value){
            smssent = value;
          },
        ),
        contentPadding: EdgeInsets.all(10.0),
        actions: [
          ElevatedButton(
              onPressed: (){
                if(FirebaseAuth.instance.currentUser != null){
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Dash()));
                }
                else{
                  Navigator.of(context).pop();
                  signIn(smssent!);
                }
              },
              child: Text("Done",style: TextStyle(color: Colors.white),)),
        ],
      );
    });
  }

  Future<void> signIn(String smsCode) async{
    final AuthCredential credential = PhoneAuthProvider.credential(
      smsCode: smsCode,
      verificationId: verificationId ?? "",
    );
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      Navigator.of(context).pushReplacementNamed('/login');
    }).catchError((e) => print(e));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: "Phone Number",
            ),
            onChanged: (value){
              this.phoneNo = value;
            },
          ),
          SizedBox(height: 20.0,),
          ElevatedButton(
              onPressed: verifyPhone,
              child: Text("Verify")),
        ],
      ),
    );
  }
}
