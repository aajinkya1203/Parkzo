import 'package:cloud_firestore/cloud_firestore.dart';
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
      body: StreamBuilder(
        stream: Firestore.instance.collection('cars').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator());
          }
          List<DocumentSnapshot> docs = snapshot.data.documents;
          print("DOcs ${docs[3]['Status']}");
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, data){
              print("Data $data");
              if(docs[data]['Status'] == 1){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                  child: ListTile(
                      leading: Image(image: AssetImage('assets/redCar.png')),
                      title: Text('Slot ${data+1}'),
                    ),
                  ),
                );
              } else if(docs[data]['Status'] == 2){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                  child: ListTile(
                      leading: Image(image: AssetImage('assets/blueCar.png')),
                      title: Text('Slot ${data+1}'),
                    ),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                child: InkWell(
                  onTap: () async{
                    await Firestore.instance.collection('cars').document("Car ${data+1}").updateData({"Status": 2});
                  },
                    child: ListTile(
                      leading: Image(image: AssetImage('assets/greenCar-.png')),
                      title: Text('Slot ${data+1}'),
                    ),
                ),
                ),
              );
            }
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Total Slots",
        onPressed: () {},
        child: Text("4"),
      ),
    );
  }
}