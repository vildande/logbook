import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logbook/components/cancel_record_dialog.dart';
import 'package:logbook/components/confirm_end_dialog.dart';
import 'package:logbook/components/edit_record_dialog.dart';
import '../utility/data_loader.dart';
import '../models/user_model.dart';
import '../bloc/user_bloc.dart';

class IncubCard extends StatefulWidget {
  final User user;
  final bool isExpanded;
  final VoidCallback onNavigate;

  const IncubCard({
    super.key,
    required this.user,
    required this.isExpanded,
    required this.onNavigate,
  });

  @override
  _IncubCardState createState() => _IncubCardState();
}

class _IncubCardState extends State<IncubCard> {
  late bool isExpanded;

  @override
  void initState() {
    super.initState();
    isExpanded = widget.isExpanded;
  }

  void _toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  Future<void> _editRecord(User user) async {
    final updatedUser = await showDialog<User>(
      context: context,
      builder: (BuildContext context) {
        return EditRecordDialog(user: user);
      },
    );
    if (updatedUser != null) {
      context.read<UserBloc>().add(EditUserEvent(user: updatedUser));
    }
  }

  Future<void> _cancelRecord(User user) async {
    final comment = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return CancelRecordDialog();
      },
    );
    if (comment != null) {
      context
          .read<UserBloc>()
          .add(CancelUserEvent(user: user, comment: comment));
    }
  }

  Future<void> _endRecord(User user) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return ConfirmEndDialog();
      },
    );
    if (confirmed == true) {
      context.read<UserBloc>().add(EndUserEvent(user: user));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleExpand,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.user.name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                  ),
                  onPressed: _toggleExpand,
                ),
              ],
            ),

            Row(
              children: [
                const Icon(Icons.timer, size: 12),
                const SizedBox(width: 3),
                Text(widget.user.startTime,
                    style: const TextStyle(fontSize: 14)),
                    
                // const Text(" - ", style: TextStyle(fontSize: 14)),
                // if (widget.user.endTime != null)
                //   Text(
                //     widget.user.endTime!,
                //     style: const TextStyle(fontSize: 14),
                //   ),
                // if (widget.user.endTime == null &&
                //     widget.user.status.toLowerCase() == 'in progress')
                //   Container(
                //     margin: const EdgeInsets.only(left: 5),
                //     padding:
                //         const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                //     decoration: BoxDecoration(
                //       color: Colors.green,
                //       borderRadius: BorderRadius.circular(20),
                //     ),
                //     child: const Text(
                //       "Active",
                //       style: TextStyle(color: Colors.white, fontSize: 14),
                //     ),
                //   ),
              ],
            ),

            if (widget.user.status.toLowerCase() == 'cancelled')
              Container(
                margin: const EdgeInsets.only(top: 5),
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
            Text(widget.user.incubatorType,
                style: const TextStyle(fontSize: 14)),
            if (isExpanded) ...[
              const SizedBox(height: 10),
              _buildInfoRow('Phone Number', widget.user.phoneNumber),
              _buildInfoRow('Usage Details', widget.user.usageDetails,
                  isDetails: true),
              if (widget.user.status.toLowerCase() == 'cancelled') ...[
                const SizedBox(height: 10),
                _buildInfoRow('Comment', widget.user.comment ?? 'No comment',
                    isDetails: true, isComment: true),
              ],
              const SizedBox(height: 10),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => _editRecord(widget.user),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text('Edit'),
                    ),
                    ElevatedButton(
                      onPressed: () => _endRecord(widget.user),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text('End'),
                    ),
                    ElevatedButton(
                      onPressed: () => _cancelRecord(widget.user),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                      ),
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value,
      {bool isDetails = false, bool isComment = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label:',
              style: const TextStyle(color: Colors.black87, fontSize: 12)),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                color: isComment && value == 'No comment'
                    ? Colors.grey
                    : Colors.black87,
                fontSize: 12,
              ),
              textAlign: isDetails ? TextAlign.left : TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
