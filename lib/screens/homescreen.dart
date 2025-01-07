import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase1/screens/lampsscreen.dart';
import 'package:flutter_firebase1/screens/loginscreen.dart';
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

  String temperature = "0";
  String kelembapan = "0";
  String lampCount = "0";

  void _showLogoutPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Tutup popup
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Loginscreen()),
                );
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Monitoring Smart Home",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: const Color.fromRGBO(158, 105, 255, 100),
        leading: IconButton(
          icon: const Icon(Icons.logout), // Ikon profil
          onPressed: () {
            // Tambahkan aksi jika diperlukan
            _showLogoutPopup(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person), // Ikon menu
            onPressed: () {
              // Tampilkan popup logout saat ikon ditekan
              debugPrint("Menu icon pressed");
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: _firebaseApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Tidak koneksi ke Firebase");
          } else if (snapshot.hasData) {
            return content();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget content() {
    DatabaseReference testRef = FirebaseDatabase.instance.ref();

    testRef.child('/suhu').onValue.listen((event) {
      setState(() {
        temperature = event.snapshot.value.toString();
      });
    });

    testRef.child('/kelembapan').onValue.listen((event) {
      setState(() {
        kelembapan = event.snapshot.value.toString();
      });
    });

    testRef.child('/lamps').onValue.listen((event) {
      setState(() {
        lampCount = event.snapshot.children.length.toString();
      });
    });

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar ruang tamu disesuaikan dengan ukuran teks
          Image.asset(
            'assets/living.png',
            height: 200, // Sesuaikan tinggi gambar dengan teks
            width: double.infinity, // Mengisi lebar penuh
            fit: BoxFit
                .cover, // Menyesuaikan gambar dengan area tanpa merusak aspek rasio
          ),
          const SizedBox(height: 10),
          const Text(
            "Welcome to This Application",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          // Container untuk tampilan suhu dan kelembapan
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.deepPurple),
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                BannerChild(
                  title: "Temperature",
                  value: temperature,
                  unit: "°C",
                  images: "assets/thermometer.png",
                ),
                BannerChild(
                  title: "Humidity",
                  value: kelembapan,
                  unit: "%",
                  images: "assets/HumidityLogo.png",
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Devices",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 10),
          // Container untuk perangkat lampu
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              border: Border.all(color: Colors.black45, width: 4),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurple.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 1,
                  offset: const Offset(2.0, 2.0),
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
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "$lampCount Devices",
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    TextButton(
                        onPressed: () => {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const Lampsscreen();
                              }))
                            },
                        child: const Text(
                          "Details",
                          style: TextStyle(
                              fontSize: 16, color: Colors.lightBlueAccent),
                        ))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
