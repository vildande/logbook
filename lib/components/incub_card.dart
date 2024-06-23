import 'package:flutter/material.dart';
import '../utility/data_loader.dart';

class IncubCard extends StatelessWidget {
  final UsageWithUser usageWithUser;
  final VoidCallback onTap;
  final VoidCallback onNavigate;

  const IncubCard({
    super.key,
    required this.usageWithUser,
    required this.onTap,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              usageWithUser.user.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                const Icon(Icons.timer, size: 12),
                const SizedBox(width: 3),
                Text(usageWithUser.usage.startTime, style: const TextStyle(fontSize: 14)),
                const Text(" - ", style: TextStyle(fontSize: 14)),
                if (usageWithUser.usage.endTime != null)
                  Text(
                    usageWithUser.usage.endTime!,
                    style: const TextStyle(fontSize: 14),
                  ),
                if (usageWithUser.usage.endTime == null && usageWithUser.usage.status.toLowerCase() == 'in progress')
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "Active",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
              ],
            ),
            if (usageWithUser.usage.status.toLowerCase() == 'cancelled')
              Container(
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Cancelled",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            const SizedBox(height: 10),
            Text(usageWithUser.usage.incubatorType, style: const TextStyle(fontSize: 14)),
            if (usageWithUser.isExpanded) ...[
              const SizedBox(height: 10),
              _buildInfoRow('Phone Number', usageWithUser.user.phoneNumber),
              _buildInfoRow('Usage Details', usageWithUser.usage.usageDetails, isDetails: true),
              if (usageWithUser.usage.status.toLowerCase() == 'cancelled') ...[
                const SizedBox(height: 10),
                _buildInfoRow('Comment', usageWithUser.usage.comment ?? 'No comment', isDetails: true, isComment: true),
              ],
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: onNavigate,
                  child: const Text('Go to history'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isDetails = false, bool isComment = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label:', style: const TextStyle(color: Colors.black87, fontSize: 12)),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              value,
              style: TextStyle(color: isComment && value == 'No comment' ? Colors.grey : Colors.black87, fontSize: 12),
              textAlign: isDetails ? TextAlign.left : TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
