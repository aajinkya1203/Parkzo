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
  late Widget temp;

  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) {
    setState(() {
      temp = Dashboard();
    });
    return Future.delayed(loginTime).then((_) async {
      AuthService obj = AuthService();
      dynamic res = await obj.signInWithEmailAndPass(data.name, data.password);
      if (res == null) {
        return "Something didn't go right";
      } else {
        return "";
      }
    });
  }

  Future<String?>? _createUser(SignupData data) {
    setState(() {
      temp = LPN();
    });
    return Future.delayed(loginTime).then((_) async {
      AuthService obj = AuthService();
      dynamic res = await obj.registerWithEmailAndPass(
          data.name ?? "", data.password ?? "");
      if (res == null) {
        return "Something didn't go right";
      } else {
        return "";
      }
    });
  }

  Future<String> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      return "";
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
