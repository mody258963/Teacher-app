import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/besnese_logic/email_auth/email_auth_cubit.dart';
import 'package:teacher/costanse/pages.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController cpasswordcontroller = TextEditingController();
  final TextEditingController socialcontroller = TextEditingController();

  void _Circelindecator(BuildContext context) {
    AlertDialog alertDialog = const AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      ),
    );
    showDialog(
        context: context,
        barrierColor: Colors.white.withOpacity(0),
        barrierDismissible: false,
        builder: (context) {
          return alertDialog;
        });
  }

  Widget _buildloginAuth() {
    return BlocListener<EmailAuthCubit, EmailAuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, EmailAuthState state) {
        if (state is LoginLoading) {
          _Circelindecator(context);
        }
        if (state is Loginfails) {
          AlertDialog(
            title: Text('dont play with me'),
          );
        }
        if (state is SignupTeacherSuccess) {
          Navigator.maybePop(context);
          Navigator.of(context, rootNavigator: true)
              .pushReplacementNamed(homescreen);
        }
      },
      child: Container(),
    );
  }

  Widget _TitleText(String text) {
    return Text(text);
  }

  Widget _Button(onPressed) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        height: height * 0.10,
        width: width * 0.70,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text('Sign up'),
        ));
  }

  Widget _TextFeild(String hint, input, int short,int long, BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        width: width * 0.70,
        height: height * 0.10,
        child: TextFormField(
          validator: (value) {
            if (value!.length > long) {
              return "Email is very long";
            }
            if (value.length < short) {
              return "Email is very short";
            } else {
              return null;
            }
          },
          controller: input,
          maxLines: 1,
          decoration: InputDecoration(
            hintText: hint,
            enabledBorder: const UnderlineInputBorder(
              //<-- SEE HERE
              borderSide: BorderSide(width: 2.3, color: Colors.black),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 3.8),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildloginAuth(),
              _TitleText('Sign Up'),
              _TextFeild('Name', namecontroller, 3, 20,context),
              _TextFeild('Email', emailcontroller, 14,40,  context),
              _TextFeild('Password', passwordcontroller, 7, 18,context),
              _TextFeild('Confirm Password', cpasswordcontroller, 7, 18,context),
              _TextFeild('Social Link', socialcontroller, 20, 500,context),
              _Button(() {
                context.read<EmailAuthCubit>().signupTeacher(
                    namecontroller.text,
                    emailcontroller.text,
                    passwordcontroller.text,
                    cpasswordcontroller.text,
                    socialcontroller.text);
              })  
            ],
          ),
        ),
      ),
    );
  }
}
