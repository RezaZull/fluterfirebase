import 'package:flutter/material.dart';

class Lampscard extends StatefulWidget {
  final int deviceIndex;
  final String deviceName;
  final bool deviceFlagOn;
  final dynamic changeLampFlagOn;
  const Lampscard({
    super.key,
    required this.deviceName,
    required this.deviceFlagOn,
    required this.changeLampFlagOn,
    required this.deviceIndex,
  });

  @override
  State<Lampscard> createState() => _LampsCard();
}

class _LampsCard extends State<Lampscard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        border: Border.all(color: Colors.black45, width: 4),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.3),
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
                fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 4,
          ),
          Icon(
            Icons.lightbulb,
            size: 60,
            color: widget.deviceFlagOn ? Colors.yellow : Colors.grey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "OFF",
                style: TextStyle(
                    color: widget.deviceFlagOn ? Colors.grey : Colors.yellow,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Switch(
                    value: widget.deviceFlagOn,
                    activeColor: Colors.yellow,
                    onChanged: (value) {
                      widget.changeLampFlagOn(widget.deviceIndex, value);
                    }),
              ),
              Text(
                "ON",
                style: TextStyle(
                    color: widget.deviceFlagOn ? Colors.yellow : Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
