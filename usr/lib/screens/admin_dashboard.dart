import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/event_provider.dart';
import '../models/event.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final events = context.watch<EventProvider>().events;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _createEvent(context),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return Card(
            child: ExpansionTile(
              title: Text(event.title),
              subtitle: Text('Participants: ${event.participants.length}/${event.maxParticipants}'),
              children: [
                if (event.pendingRequests.isNotEmpty)
                  ...event.pendingRequests.map((userId) => ListTile(
                        title: Text('Request from: $userId'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.check, color: Colors.green),
                              onPressed: () => _approveRequest(context, event.id, userId),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close, color: Colors.red),
                              onPressed: () => _rejectRequest(context, event.id, userId),
                            ),
                          ],
                        ),
                      )),
                if (event.pendingRequests.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('No pending requests'),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _createEvent(BuildContext context) {
    // Placeholder for create event dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Event'),
        content: const Text('Event creation form would go here. For MVP, use mock data.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _approveRequest(BuildContext context, String eventId, String userId) {
    context.read<EventProvider>().approveRequest(eventId, userId);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Request approved')),
    );
  }

  void _rejectRequest(BuildContext context, String eventId, String userId) {
    context.read<EventProvider>().rejectRequest(eventId, userId);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Request rejected')),
    );
  }
}
