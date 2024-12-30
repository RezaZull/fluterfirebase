import 'package:flutter/material.dart';

class Lampscard extends StatefulWidget {
  final String deviceName;
  const Lampscard({
    super.key,
    required this.deviceName,
  });

  @override
  State<Lampscard> createState() => _LampsCard();
}

class _LampsCard extends State<Lampscard> {
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.deviceName,
            style: const TextStyle(
                fontSize: 24, color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 4,
          ),
          Image.asset(
            'assets/lightbulb.png',
            height: 60,
            width: 60,
          ),
          Switch(
              value: status,
              onChanged: (value) {
                setState(() {
                  status = value;
                });
              })
        ],
      ),
    );
  }
}
