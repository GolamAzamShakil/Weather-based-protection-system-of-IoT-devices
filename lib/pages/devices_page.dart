import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sdp4/features/firebase_devices.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({super.key});

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  final FirebaseDevices firebaseDevices = FirebaseDevices();

  final realTime = FirebaseDatabase.instance.ref("devices");

  final TextEditingController textController = TextEditingController();

  late VoidCallback? realtimeUpdate;

  String deviceName = "test";

  /*void updateDevice({String? deviceID}) {
    realTime.update({
      'id': deviceID,
      'condition': 0,
    });
  }*/

  void deviceAdd({String? deviceID}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (deviceID == null) {
                firebaseDevices.addDevice(textController.text);
              } else {
                firebaseDevices.updateDevice(deviceID, textController.text);
              }

              textController.clear();

              Navigator.pop(context);
            },
            child: Text("Add"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width / 100;
    var _height = MediaQuery.of(context).size.height / 100;

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("D E V I C E S")),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        //backgroundColor: Colors.transparent,
        elevation: 0,
        /*actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout),
          ),
        ],*/
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: deviceAdd,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firebaseDevices.getDevices(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List devicesList = snapshot.data!.docs;

            return ListView.builder(
              itemCount: devicesList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = devicesList[index];
                String deviceID = document.id;

                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                String deviceText = data['device'];

                return Slidable(
                  startActionPane: ActionPane(
                    motion: const BehindMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          realTime.child(deviceID.toString()).set({
                            //'title': deviceText,
                            'condition': 0,
                          });
                        },
                        icon: Icons.developer_board_off_rounded,
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    title: Text(deviceText),
                    subtitle: Text(deviceID.toString()),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            realTime.child(deviceID.toString()).set({
                              //'title': deviceText,
                              'condition': 0,
                            });
                          },
                          icon: const Icon(Icons.developer_board_off_rounded),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text("There hasn't added any devices yet."),
            );
          }
        },
      ),
    );
  }
}
