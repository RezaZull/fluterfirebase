import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});
  @override
  State<MainApp> createState() => _MainApp();
}

class _MainApp extends State<MainApp> {
  final Future<FirebaseApp> _firebaseApp =
      Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  String isOnValue = "true";
  String temperatureValue = "0";
  String isOpenValue = "true";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Smart Home',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
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
              })),
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
    return Column(
      children: [
        const Center(
          child: Text("Hallo Rafifah "),
        ),
        Center(
          child: Text("Temperature $temperatureValue"),
        ),
        Center(
          child: Text("Status Lampu $isOnValue"),
        ),
        Switch(
          value: isOnValue == 'true',
          onChanged: (bool value) {
            testRef.child('data/isOn').set(value);
          },
        ),
        Center(
          child: Text("Status Jendela $isOpenValue"),
        ),
        Switch(
            value: isOpenValue == 'true',
            onChanged: (bool value) {
              testRef.child('data/isOpen').set(value);
            })
      ],
    );
  }
}
