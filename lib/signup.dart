import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  // bool isDisabled = false;
  // @override
  // void initState(){
  //   super.initState();
  //   // Future((){
  //   //   isDisabled = false  ;
  //   // });
  //   WidgetsBinding.instance.addPostFrameCallback((_) => isDisabled = false  ;);
  //   // isDisabled = false  ;
  //
  // }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(String email , password) async {
    
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
          // isDisabled = true;
        });
        var data = jsonDecode(response.body.toString());
        print(data['token']);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Token ID: '+ data['token']+' Login successfully'),
        ));
        print('Login successfully');
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
            GestureDetector(
              onTap: (){
                login(emailController.text.toString(), passwordController.text.toString());
                // setState(() {
                //   isD
                // });
                // jsonDecode(source)
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  // color: isDisabled? Colors.grey:Colors.green,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text('Login'),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
