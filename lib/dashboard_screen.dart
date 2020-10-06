import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Parking")
      ),
      body: ListView(
      children: const <Widget>[
        Card(
          child: ListTile(
            leading: FlutterLogo(),
            title: Text('Slot 1'),
          ),
        ),
        Card(
          child: ListTile(
            leading: FlutterLogo(),
            title: Text('Slot 2'),
          ),
        ),
        Card(
          child: ListTile(
            leading: FlutterLogo(),
            title: Text('Slot 3'),
          ),
        ),
        SizedBox(height: 50.0),
        Card(
          child: ListTile(
            leading: FlutterLogo(),
            title: Text('Total Slots'),
            subtitle: Text('5'),
          ),
        ),
        Card(
          child: ListTile(
            leading: FlutterLogo(),
            title: Text('Available Slots'),
            subtitle: Text('2'),
          ),
        ),
      ],
    ),
    );
  }
}