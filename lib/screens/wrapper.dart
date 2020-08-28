import 'package:flutter/material.dart';

import '../LoginScreen.dart';
import '../authService.dart';
import 'Home.dart';


class MyUser {
  final String uid;

  MyUser({this.uid});
}




class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {



    // return either Home or Authenticate Widget
    return  StreamBuilder<MyUser>(
      stream: AuthService().myUser,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          if(snapshot.data == null){
            print("Null user");
            return LoginScreen();
          }else{
            print(snapshot.data.uid);
            return Home();
          }
        }
        
      }
    );
  }
}
