
import 'package:chat_app/screens/verification_screen.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class RegistrationPage extends StatefulWidget{
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage>{

  final TextEditingController _phoneController = TextEditingController();
  PhoneNumber _phoneNumber = PhoneNumber();
  String? inputNumber;

  final phoneAuth = FirebasePhoneAuth();

  @override
  void dispose(){
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
      return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.chat,
        size: 100,
        ),
        SizedBox(height: 30),
        IntrinsicHeight(
          child: Padding(padding: EdgeInsets.all(16),
          child: Stack(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[350],
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                 width: 100,
                ),
                SizedBox(width: 8,),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                    color: Colors.grey[350],
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  )
                  )
              ],
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                 _phoneNumber = number;
                 debugPrint('${_phoneNumber.dialCode} ${_phoneController.text}');
                 inputNumber = '${_phoneNumber.dialCode} ${_phoneController.text}';
              },
              initialValue: _phoneNumber,
              selectorConfig: SelectorConfig(
                leadingPadding: 8.0,
                selectorType: PhoneInputSelectorType.DIALOG,
                setSelectorButtonAsPrefixIcon: false
              ),
              spaceBetweenSelectorAndTextField: 12,
              inputBorder: UnderlineInputBorder(
                borderSide: BorderSide.none
              ),
              searchBoxDecoration: InputDecoration(
                hintText: 'Search country...'
              ),
              cursorColor: Colors.black,
              //autoValidateMode: AutovalidateMode.onUserInteraction,
              textFieldController: _phoneController,
              ),
            )
          ],
        ),
        ),
          
        ),
        SizedBox(height: 10,),
        OutlinedButton(onPressed: (){
          phoneAuth.verifyNumber(inputNumber);
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const VerificationPage())
          );
        },
        style: OutlinedButton.styleFrom(backgroundColor: Colors.black, fixedSize: Size(200, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
        ),
        child: Text('Send', style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        )
      ],
    )
    ); 
  }
}