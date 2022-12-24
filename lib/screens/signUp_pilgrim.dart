import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rafad1/screens/LoginPage.dart';
import 'package:rafad1/screens/logOutPilgrim.dart'; //شادن سوي النفقيتر له
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class SignUpPilgrim extends StatefulWidget {
  static const String screenRoute = 'signUP_pilgrim';
  const SignUpPilgrim({Key? key}) : super(key: key);

  @override
  State<SignUpPilgrim> createState() => _SignUpPilgrimState();
}

class _SignUpPilgrimState extends State<SignUpPilgrim> {
  // 1 in insert data
  // 2 i put controller in each feild
  // 3 in line 286 i write Map
String ?name ;
 String ?email ;
  String ?number;
 String ?hajId ;
 String ?disease;
 String ?pharma ;
String ?password ;
  final _signupFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("sign up as pilgrim"),
          backgroundColor: const Color(0xFF455D83),
          elevation: 0,
        ), //عشان سهم رجوع

        backgroundColor: const Color(0xffEEF1F3),
        body: SingleChildScrollView(
          child: Form(
            key: _signupFormKey,
            child: Column(
              children: [
                const PageHeader(),
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
            image: AssetImage("assests/images/background.png"),
            fit: BoxFit.cover),
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      const PageHeading(
                        title: 'Sign up as Pilgrim',
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // SizedBox(
                      //   height: 130,
                      //   child: Image.asset('assets/images/logo.png'),
                      // ), //هنا حق الللوقو
                      // CustomInputField(
                      //     labelText: 'Pilgrim Name *',
                      //     hintText: 'Your full name',
                      //     isDense: true,
                          
                      //     validator: (textValue) {
                      //       if (textValue == null || textValue.isEmpty) {
                      //         return 'Name field is required!';
                      //       }
                      //       String patttern =
                      //           (r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
                      //       RegExp regExp = RegExp(patttern);
                      //       if (!regExp.hasMatch(textValue)) {
                      //         return 'Please enter valid name';
                      //       }
                      //       return null;
                      //     }),

                      TextFormField(
                      inputFormatters: [
            //FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))
            FilteringTextInputFormatter.allow(RegExp("[a-zA-Z- -]"))
       ],
       keyboardType: TextInputType.text,
                        onChanged: (value){
                          
                          setState(() {
                            name=value;
                          });
                        },
                        validator:(value){
                          if (value == null || value.isEmpty) {
                         return 'Name field is required!';
                         
                        }else if (value.length<10){
                          return 'Please enter valid name';
                        }

                        
                        String patttern =
                                (r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
                            RegExp regExp = RegExp(patttern);
                            if (!regExp.hasMatch(value)) {
                              return 'Please enter valid name';
                            }
                            return null;
                        ;},
                      decoration: 
                      InputDecoration(labelText: 'Pilgrim Name *',
                      hintText: 'Your full name',
                          
                          isDense: true,
                          
                          ),
                      ),


                      const SizedBox(
                        height: 16,
                      ),
                      CustomInputField(
                          labelText: 'Email *',
                          hintText: 'Your email id',
                          isDense: true,
                          
                          validator: (textValue) {
                            if (textValue == null || textValue.isEmpty) {
                              return 'Email is required!';
                            }
                            if (!EmailValidator.validate(textValue)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomInputField(
                          labelText: 'Phone number *',
                          hintText: 'Your phone number',
                          isDense: true,
                          
                          validator: (textValue) {
                            //الحمدلله ضبط

                            if (textValue == null || textValue.isEmpty) {
                              return 'Phone number is required!';
                            }
                            String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                            RegExp regExp = new RegExp(patttern);
                            if (!regExp.hasMatch(textValue)) {
                              return 'Please enter valid Phone number';
                            }
                            if (textValue.length != 10) {
                              return 'Phone Number must be of 10 digit';
                            }

                            return null;
                          }),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomInputField(
                          labelText: 'haj permission ID*',
                          hintText: 'your haj permission ID',
                          isDense: true,
                         
                          validator: (textValue) {
                            if (textValue == null || textValue.isEmpty) {
                              return 'ID is required!';
                            }
                            if (!textValue.contains(RegExp(r'[0-9]'))) {
                              return 'Please enter valid ID';
                            }
                            if (textValue.length != 10) {
                              return 'ID must be of 10 digit';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomInputField(
                          labelText: 'chronic disease',
                          hintText: 'if you suffer from any chronic disease',
                          isDense: true,
                        
                          validator: (textValue) {
                            //تأكدي  هل صحيح لاني مافيه شرط هنا اساسا
                            return null;
                          }),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomInputField(
                          labelText: 'pharmaceutical',
                          hintText: 'if you are taking any pharmaceutical',
                          isDense: true,
                          
                          validator: (textValue) {
                            //تأكدي  هل صحيح لاني مافيه شرط هنا اساسا

                            return null;
                          }),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomInputField(
                        labelText: 'Password *',
                        hintText: 'Your password',
                        isDense: true,
                        obscureText: true,
                        
                        validator: (textValue) {
                          if (textValue == null || textValue.isEmpty) {
                            return 'Password is required!';
                          }
                          if (!textValue.contains(RegExp(r'[0-9]'))) {
                            return "Password must contain a digit";
                          }
                          if (!textValue.contains(RegExp(r'[A-Z]'))) {
                            return "Password must contain at least one upper case";
                          }
                          if (!textValue.contains(RegExp(r'[a-z]'))) {
                            return "Password must contain at least one lower case";
                          }
                          if (textValue.length < 6) {
                            return "Password must be at least 6 characters in length";
                          }

                          // if (textValue != null) {
                          //   String userPassword = textValue;
                          // }
                          return null;
                        },
                        suffixIcon: true,
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      CustomFormButton(
                        innerText: 'Sign up',
                        onPressed: ()async {
                        
                          if(_signupFormKey.currentState!.validate()){
                            // setState(() {
                              
                            // });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Submitting data..')), );
                              
                            // await FirebaseFirestore.instance.collection("reem").doc()
        //                     .set({
        //                       'name': '${name.text}',
        // 'email': '${email.text}',
        // 'number': '${number.text}',
        // 'hajId': '${hajId.text}',
        // 'disease': '${disease.text}',
        // 'pharma': '${pharma.text}',
        // 'password': '${password.text}',
        //                   });
        await FirebaseFirestore.instance.collection("reem").add({
        'name': name,
        'email': email,
        'number': number,
        'hajId': hajId,
        'disease': disease,
        'pharma': pharma,
        'password':password,
                          });
                          
                              }

                        },
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account ? ',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xff939393),
                                  fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()))
                              },
                              child: const Text(
                                'Log-in',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleSignupUser()async {
    // signup user pilgrim Be careful
    // if (_signupFormKey.currentState!.validate()) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Submitting data..')),
    //   );
    // }
    // if (_signupFormKey.currentState!.validate()) {
      

      Map<String, dynamic> pilgrims = {
        'name': name,
        'email': email,
        'number': number,
        'hajId': hajId,
        'disease': disease,
        'pharma': pharma,
        'password': password,
      };
      await FirebaseFirestore.instance
          .collection('pilgrims')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(pilgrims).catchError((e){
            ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e)),);
          });
    }
  }


class CustomFormButton extends StatelessWidget {
  final String innerText;
  final void Function()? onPressed;
  const CustomFormButton(
      {Key? key, required this.innerText, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: const Color(0xFF455D83),
        borderRadius: BorderRadius.circular(26),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          innerText,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}

class CustomInputField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final String? Function(String?) validator;
  final bool suffixIcon;
  final bool? isDense;
  final bool obscureText;
  

  const CustomInputField(
      {Key? key,
      required this.labelText,
      required this.hintText,
      required this.validator,
      this.suffixIcon = false,
      this.isDense,
      this.obscureText = false,
     
     })
      : super(key: key);

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  //
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.labelText,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          TextFormField(
           
            obscureText: (widget.obscureText && _obscureText),
            decoration: InputDecoration(
              isDense: (widget.isDense != null) ? widget.isDense : false,
              hintText: widget.hintText,
              suffixIcon: widget.suffixIcon
                  ? IconButton(
                      icon: Icon(
                        _obscureText
                            ? Icons.remove_red_eye
                            : Icons.visibility_off_outlined,
                        color: const Color(0xFF7D8DBA),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : null,
              suffixIconConstraints: (widget.isDense != null)
                  ? const BoxConstraints(maxHeight: 33)
                  : null,
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: widget.validator,
          ),
        ],
      ),
    );
  }
}

class PageHeader extends StatelessWidget {
  const PageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.3,
      child: Image.asset('assets/images/logo.png'),
    );
  }
}

class PageHeading extends StatelessWidget {
  final String title;
  const PageHeading({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 25),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'NotoSerif'),
      ),
    );
  }
}
