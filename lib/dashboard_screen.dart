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
      appBar: AppBar(title: const Text("Parking")),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('cars').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (ConnectionState.waiting == snapshot.connectionState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                  child: Text(
                      "Something went wrong ${snapshot.error!.toString()}"));
            }
            List<DocumentSnapshot> docs = snapshot.data!.docs;
            if (docs.isEmpty) {
              return const Center(
                child: Text("No data found"),
              );
            }
            return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, data) {
                  if (docs[data]['Status'] == 1) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          leading: const Image(
                              image: AssetImage('assets/redCar.png')),
                          title: Text('Slot ${data + 1}'),
                        ),
                      ),
                    );
                  } else if (docs[data]['Status'] == 2) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          leading: const Image(
                              image: AssetImage('assets/blueCar.png')),
                          title: Text('Slot ${data + 1}'),
                        ),
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: InkWell(
                        onTap: () async {
                          await FirebaseFirestore.instance
                              .collection('cars')
                              .doc("Car ${data + 1}")
                              .update({"Status": 2});
                        },
                        child: ListTile(
                          leading: const Image(
                              image: AssetImage('assets/greenCar-.png')),
                          title: Text('Slot ${data + 1}'),
                        ),
                      ),
                    ),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        tooltip: "Total Slots",
        onPressed: () {},
        child: const Text("4"),
      ),
    );
  }
}
