import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase1/screens/lampsscreen.dart';
import 'package:flutter_firebase1/widgets/banner_child.dart';
import '../firebase_options.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});
  @override
  State<Homescreen> createState() => _Homescreen();
}

class _Homescreen extends State<Homescreen> {
  final Future<FirebaseApp> _firebaseApp =
      Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  String isOnValue = "true";
  String temperatureValue = "0";
  String isOpenValue = "true";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Center(
          child: Text("Monitoring Smart Home"),
        ),
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

  Widget content() {
    DatabaseReference testRef = FirebaseDatabase.instance.ref();

    testRef.child('data/isOn').onValue.listen((event) {
      setState(() {
        isOnValue = event.snapshot.value.toString();
      });
    });
    testRef.child('data/temperature').onValue.listen((event) {
      setState(() {
        temperatureValue = event.snapshot.value.toString();
      });
    });
    testRef.child('data/isOpen').onValue.listen((event) {
      setState(() {
        isOpenValue = event.snapshot.value.toString();
      });
    });

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.lightBlue),
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            child: const Row(
              children: [
                BannerChild(
                  title: "Temperature",
                  value: "24",
                  unit: "°C",
                  images: "assets/thermometer.png",
                ),
                BannerChild(
                  title: "Humidity",
                  value: "40",
                  unit: "%",
                  images: "assets/HumidityLogo.png",
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Devices",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.blue, width: 4),
              boxShadow: [
                BoxShadow(
                  color: Colors.lightBlue.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 1,
                  offset: const Offset(2.0, 2.0), // changes position of shadow
                ),
              ],
            ),
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/lightbulb.png',
                  height: 60,
                  width: 60,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Lamp',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      '4 Devices',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                      ),
                    ),
                    TextButton(
                        onPressed: () => {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const Lampsscreen();
                              }))
                            },
                        child: const Text("Details"))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );

    // return Padding(
    //   padding: const EdgeInsets.all(20),
    //   child: GridView.count(
    //     crossAxisCount: 2,
    //     crossAxisSpacing: 10,
    //     mainAxisSpacing: 10,
    //     primary: false,
    //     children: [
    //       Container(
    //         decoration: BoxDecoration(
    //           color: Colors.white,
    //           border: Border.all(color: Colors.blue, width: 4),
    //           boxShadow: [
    //             BoxShadow(
    //               color: Colors.lightBlue.withOpacity(0.3),
    //               spreadRadius: 2,
    //               blurRadius: 1,
    //               offset: const Offset(2.0, 2.0), // changes position of shadow
    //             ),
    //           ],
    //         ),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             const Text(
    //               'Temperature',
    //               style: TextStyle(
    //                   fontSize: 24,
    //                   color: Colors.blue,
    //                   fontWeight: FontWeight.bold),
    //             ),
    //             const SizedBox(
    //               height: 4,
    //             ),
    //             Row(
    //               children: [
    //                 Image.asset(
    //                   'assets/thermometer.png',
    //                   height: 60,
    //                   width: 60,
    //                 ),
    //                 const Text('30°C',
    //                     style: TextStyle(
    //                         fontSize: 40,
    //                         fontWeight: FontWeight.bold,
    //                         color: Colors.blue))
    //               ],
    //             )
    //           ],
    //         ),
    //       ),
    //       Container(
    //         decoration: BoxDecoration(
    //           color: Colors.white,
    //           border: Border.all(color: Colors.blue, width: 4),
    //           boxShadow: [
    //             BoxShadow(
    //               color: Colors.lightBlue.withOpacity(0.3),
    //               spreadRadius: 2,
    //               blurRadius: 1,
    //               offset: const Offset(2.0, 2.0), // changes position of shadow
    //             ),
    //           ],
    //         ),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             const Text(
    //               'Humidity',
    //               style: TextStyle(
    //                   fontSize: 24,
    //                   color: Colors.blue,
    //                   fontWeight: FontWeight.bold),
    //             ),
    //             const SizedBox(
    //               height: 4,
    //             ),
    //             Row(
    //               children: [
    //                 Image.asset(
    //                   'assets/HumidityLogo.png',
    //                   height: 60,
    //                   width: 60,
    //                 ),
    //                 const Text('30%',
    //                     style: TextStyle(
    //                         fontSize: 40,
    //                         fontWeight: FontWeight.bold,
    //                         color: Colors.blue))
    //               ],
    //             )
    //           ],
    //         ),
    //       ),
    //       Container(
    //         decoration: BoxDecoration(
    //           color: Colors.white,
    //           border: Border.all(color: Colors.blue, width: 4),
    //           boxShadow: [
    //             BoxShadow(
    //               color: Colors.lightBlue.withOpacity(0.3),
    //               spreadRadius: 2,
    //               blurRadius: 1,
    //               offset: const Offset(2.0, 2.0), // changes position of shadow
    //             ),
    //           ],
    //         ),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             const Text(
    //               'Lamp',
    //               style: TextStyle(
    //                   fontSize: 24,
    //                   color: Colors.blue,
    //                   fontWeight: FontWeight.bold),
    //             ),
    //             const SizedBox(
    //               height: 4,
    //             ),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 Image.asset(
    //                   'assets/lightbulb.png',
    //                   height: 60,
    //                   width: 60,
    //                 ),
    //               ],
    //             )
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );

    // return Padding(
    //   padding: const EdgeInsets.all(20),
    //   child: Column(
    //     children: [
    //       Container(
    //         color: Colors.blue,
    //         child: const Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: [
    //             Text('Suhu'),
    //             SizedBox(
    //               width: 20,
    //             ),
    //             Text('kelembapan'),
    //           ],
    //         ),
    //       ),
    //       const Center(
    //         child: Text("Hallo Rafifah "),
    //       ),
    //       Center(
    //         child: Text("Temperature $temperatureValue"),
    //       ),
    //       Center(
    //         child: Text("Status Lampu $isOnValue"),
    //       ),
    //       Switch(
    //         value: isOnValue == 'true',
    //         onChanged: (bool value) {
    //           testRef.child('data/isOn').set(value);
    //         },
    //       ),
    //       Center(
    //         child: Text("Status Jendela $isOpenValue"),
    //       ),
    //       Switch(
    //           value: isOpenValue == 'true',
    //           onChanged: (bool value) {
    //             testRef.child('data/isOpen').set(value);
    //           }),
    //     ],
    //   ),
    // );
  }
}
