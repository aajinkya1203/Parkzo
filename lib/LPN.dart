import 'package:flutter/material.dart';
import 'package:parking/dashboard_screen.dart';
import 'package:parking/services/AuthService.dart';

class LPN extends StatefulWidget {
  @override
  _LPNState createState() => _LPNState();
}

class _LPNState extends State<LPN> {
  final _formKey = GlobalKey<FormState>();
  String lpn = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Enter your LPN",
            style: TextStyle(color: Colors.black, fontSize: 25.0),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.greenAccent, width: 2.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        hintText: 'License Plate Number',
                        filled: true),

                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your LPN to continue';
                      }
                      setState(() {
                        lpn = value.toString();
                      });
                      return null;
                    },
                  ),
                ),
                RaisedButton(
                  onPressed: () async {
                    // Validate returns true if the form is valid, otherwise false.
                    if (_formKey.currentState!.validate()) {
                      AuthService obj = AuthService();
                      dynamic data = await obj.addLPN(lpn);
                      if (data) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => Dashboard(),
                        ));
                      }
                    }
                  },
                  child: const Text('Proceed'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
