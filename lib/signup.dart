import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  bool isDisabled = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  login(String email , password) async {
    
    try{
      
      Response response = await post(
        Uri.parse('https://reqres.in/api/login'),
        body: {
          'email' : email,
          'password' : password
        }
      );

      if(response.statusCode == 200){
        setState(() {
          isDisabled = true;
        });
        var data = jsonDecode(response.body.toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Token ID: '+ data['token']+' Login successfully'),
        ));
        Future.delayed(Duration(seconds: 3),(){
          Navigator.pushReplacementNamed(context, '/homepage');
        });

      }else {
        print('failed');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('failed'),
        ));

      }
    }catch(e){
      print(e.toString());
    }
  }
  void httpJob(AnimationController controller) async {
    controller.forward();
    print("delay start");
    await Future.delayed(Duration(seconds: 3), () {});
    print("delay stop");
    controller.reset();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up Api'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email'
              ),
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                  hintText: 'Password'
              ),
            ),
            SizedBox(height: 40,),
          ElevatedButton.icon(
      onPressed: isDisabled ? null : ()=>login(emailController.text.toString(), passwordController.text.toString()),
      style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16.0)),
    icon: isDisabled
    ? Container(
    width: 24,
    height: 24,
    padding: const EdgeInsets.all(2.0),
    child: const CircularProgressIndicator(
    color: Colors.white,
    strokeWidth: 3,
    ),
    )
        : const Icon(Icons.arrow_forward_rounded),
    label: const Text('SUBMIT'),
    )
      ]),
    ));
  }
}

