import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';


class FirebasePhoneAuth{

  FirebaseAuth auth = FirebaseAuth.instance;
  late final String _verificationId;

  Future<void> verifyNumber(String? number) async{
    await auth.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (PhoneAuthCredential credential) async{
        await auth.signInWithCredential(credential);

        print('Sucessfully verified');
      }, 
      verificationFailed: (FirebaseAuthException e){
        if(e.code == 'invalid-phone-number'){
          print('The provided phone number is not valid');
        }else if(e.code =='phone-number-already-exists'){
          print('The phone number is in use try another one');
        }
      }, 
      codeSent: (String verificationId, int? resendToken) async{
          _verificationId = verificationId;
          //signInWithCode(smsCode)
        
      }, 
      codeAutoRetrievalTimeout: (String verificationId){},
        timeout: const Duration(seconds: 35)
      );
  }

  Future<void> signInWithCode(String smsCode)async{
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: _verificationId, smsCode: smsCode);
      await auth.signInWithCredential(credential);
      
  }
}