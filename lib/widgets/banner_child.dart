import 'package:flutter/material.dart';

class BannerChild extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final String images;
  const BannerChild({
    super.key,
    required this.title,
    required this.value,
    required this.unit,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Image.asset(
            images,
            height: 60,
            width: 60,
          ),
          Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "$value$unit",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }
}
