import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:parking/LPN.dart';
import 'package:parking/services/AuthService.dart';
import 'dashboard_screen.dart';



class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  Widget temp;

  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) {
    print('Name: ${data.name}, Password: ${data.password}');
    setState(() {
      temp = Dashboard();
    });
    return Future.delayed(loginTime).then((_) async {
      AuthService obj = AuthService();
      dynamic res = await obj.signInWithEmailAndPass(data.name, data.password);
      if (res == null) {
        return "Something didn't go right";
      } else {
        
        return null;
      }
    });
  }

  Future<String> _createUser(LoginData data) {
    print('Here Name: ${data.name}, Password: ${data.password}');
    setState(() {
      temp = LPN();
    });
    print("temp: $temp");
    return Future.delayed(loginTime).then((_) async {
      // if (!users.containsKey(data.name)) {
      //   return 'Username not exists';
      // }
      // if (users[data.name] != data.password) {
      //   return 'Password does not match';
      // }
      AuthService obj = AuthService();
      dynamic res = await obj.registerWithEmailAndPass(data.name, data.password);
      if (res == null) {
        return "Something didn't go right";
      } else {
        return null;
      }
    });
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      // if (!users.containsKey(name)) {
      //   return 'Username not exists';
      // }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Parking',
      onLogin: _authUser,
      onSignup: _createUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => temp,
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}