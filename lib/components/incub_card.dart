import 'package:flutter/material.dart';

class IncubCard extends StatelessWidget {
  final String name;
  final String startTime;
  final String? endTime;
  final String incubatorType;

  const IncubCard({
    super.key,
    required this.name,
    required this.startTime,
    this.endTime,
    required this.incubatorType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name),
              Row(
                children: [
                  const Icon(Icons.timer, size: 12),
                  const SizedBox(width: 3), // empty space
                  Text(startTime, style: const TextStyle(fontSize: 10)),
                  const Text(
                    " - ",
                    style: TextStyle(fontSize: 10),
                  ),
                  if (endTime != null)
                    Text(endTime!, style: const TextStyle(fontSize: 10)),
                  if (endTime == null)
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "Active",
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            incubatorType,
            style: const TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }
}
