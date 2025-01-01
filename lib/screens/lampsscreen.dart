import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase1/firebase_options.dart';
import 'package:flutter_firebase1/models/devices_lamp_model.dart';
import 'package:flutter_firebase1/widgets/lampscard.dart';

class Lampsscreen extends StatefulWidget {
  const Lampsscreen({super.key});

  @override
  State<Lampsscreen> createState() => _Lampsscreen();
}

class _Lampsscreen extends State<Lampsscreen> {
  final Future<FirebaseApp> _firebaseApp =
      Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  List<DevicesLampModel> lamps = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lamps"),
      ),
      body: FutureBuilder(
          future: _firebaseApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Tidak koneksi ke Firebase");
            } else if (snapshot.hasData) {
              return content();
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }

  void changeLampFlagOn(index, value) {
    DatabaseReference testRef = FirebaseDatabase.instance.ref();
    testRef.child("lamps/$index/flagOn").set(value);
  }

  Widget content() {
    DatabaseReference testRef = FirebaseDatabase.instance.ref();

    testRef.child('/lamps').onValue.listen((event) {
      List<DevicesLampModel> lampsData = [];
      for (final child in event.snapshot.children) {
        final map = child.value as Map;
        lampsData.add(DevicesLampModel.fromMap(map));
      }
      setState(() {
        lamps = lampsData;
      });
    });

    return Padding(
      padding: const EdgeInsets.all(20),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
          primary: false,
          itemCount: lamps.length,
          itemBuilder: (context, i) {
            return Lampscard(
              deviceName: lamps[i].name,
              deviceFlagOn: lamps[i].flagOn,
              changeLampFlagOn: changeLampFlagOn,
              deviceIndex: i,
            );
          }),
    );
  }
}
