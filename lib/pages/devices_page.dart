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
  bool _enabled = true;
  List<bool> enabled = [];
  //var enabled = [];
  //var enabled = List<bool>();
  String _deviceID = '';

  final FirebaseDevices firebaseDevices = FirebaseDevices();

  final realTime = FirebaseDatabase.instance.ref();

  final TextEditingController textController = TextEditingController();

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
  void initState() {
    super.initState();
    readRealTime();
    //readRealTimeOnce();
  }

  void readRealTime() {
    realTime.child('devices').onValue.listen((event) {
      //final realData = Map<String, dynamic>.from(event.snapshot.value);
      DataSnapshot dataSnapshot = event.snapshot;

      //Object? values = dataSnapshot.value;

      if (dataSnapshot.exists) {
        for (var child in dataSnapshot.children) {
          print("\n${child.toString()}");
        }
      }
    });
  }

  void readRealTimeOnce() {
    /*realTime.child('devices').get().then((snapshot) {
      final realData = Map<String, dynamic>.from(snapshot.value);
    });*/
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width / 100;
    var _height = MediaQuery.of(context).size.height / 100;
    //bool _enabled = true;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16))),
        title: const Text("D E V I C E S"),
        titleTextStyle: const TextStyle(
          color: Color(0xffe2e2e9),
          fontWeight: FontWeight.w500,
          fontSize: 17,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
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
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: deviceAdd,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        clipBehavior: Clip.antiAlias,
        elevation: 8,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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

                //enabled = List<bool>.filled(devicesList.length, true);
                //enabled.fillRange(0, 3, true);
                if (enabled.isEmpty) {
                  enabled = List<bool>.filled(devicesList.length, true);
                }

                if (_deviceID.isEmpty) {
                  _deviceID = deviceID;
                }

                return Slidable(
                  startActionPane: ActionPane(
                    motion: const BehindMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          realTime.child('devices/${deviceID.toString()}').set({
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
                    isThreeLine: false,
                    //shape: ShapeBorder.,
                    //style: ,
                    //tileColor: Colors.blueGrey[100],
                    selectedColor: Colors.grey[350],
                    iconColor: Colors.tealAccent,
                    //titleTextStyle: ,
                    //titleAlignment: ListTileTitleAlignment.center,
                    title: Text(deviceText),
                    subtitle: Text(deviceID.toString()),
                    /*trailing: Row(
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
                        ),
                        Switch(
                          value: true,
                          onChanged: (bool? value) {
                            if (value == true) {
                              realTime.child(deviceID.toString()).set({
                                //'title': deviceText,
                                'condition': 1,
                              });
                            }
                            realTime.child(deviceID.toString()).set({
                              //'title': deviceText,
                              'condition': 0,
                            });
                            value = false;
                          },
                        ),
                      ],
                    ),*/
                    trailing: Switch(
                      value: enabled[index], //enabled[index],
                      onChanged: (bool value) {
                        /*realTime.child(deviceID.toString()).set({
                          //'title': deviceText,
                          'condition': enabled[index].toString(),
                        });*/
                        print(enabled);
                        //enabled[index] = value;
                        setState(() {
                          realTime.child('devices/${deviceID.toString()}').set({
                            'title': deviceText,
                            'condition': value.toString(),
                          });
                          enabled[index] = value;
                          print(enabled);
                        });
                      },
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
