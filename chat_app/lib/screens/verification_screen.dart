import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class VerificationPage extends StatefulWidget{
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState()=> _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage>{

  final TextEditingController _verifyController = TextEditingController();
  final phoneAuth = FirebasePhoneAuth();

  @override
  Widget build(BuildContext context){
    return Material(
      child: Center(
      child: Column(
        children: [
          AppBar(
            title: Text('Verify +92 321 5129493'),
          ),
          SizedBox(height: 10,),
          Text('Enter 6-digit code'),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 100),
            child: TextField(
            textAlign: TextAlign.center,
            maxLength: 6,
            controller: _verifyController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(16),
              hintText: '- - -  - - -',
              counterText: '',
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black,
                style: BorderStyle.solid
                )
              ),
            ),
            keyboardType: TextInputType.phone,
            cursorColor: Colors.black,
          ),
          ),
        SizedBox(height: 10,),
        OutlinedButton(onPressed: (){
          phoneAuth.signInWithCode(_verifyController.text);
          debugPrint('Successfully signed in');
        },
        style: OutlinedButton.styleFrom(backgroundColor: Colors.black, fixedSize: Size(200, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
        ),
        child: Text('Verify', style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        )
        ],
      ),
    ),
  );
  }
}