import 'package:flutter/material.dart';
import 'package:flutter_firebase1/widgets/lampscard.dart';

class Lampsscreen extends StatefulWidget {
  const Lampsscreen({super.key});

  @override
  State<Lampsscreen> createState() => _Lampsscreen();
}

class _Lampsscreen extends State<Lampsscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Lamps"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            primary: false,
            children: const [
              Lampscard(
                deviceName: "Lamp1",
              ),
              Lampscard(
                deviceName: "Lamp2",
              ),
              Lampscard(
                deviceName: "Lamp3",
              ),
              Lampscard(
                deviceName: "Lamp4",
              ),
            ],
          ),
        ));
  }
}
