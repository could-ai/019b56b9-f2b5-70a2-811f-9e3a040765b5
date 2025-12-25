import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/event_provider.dart';
import '../models/event.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final events = context.watch<EventProvider>().events;
    final user = context.watch<AuthProvider>().currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Events'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthProvider>().logout();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return Card(
            child: ListTile(
              title: Text(event.title),
              subtitle: Text('${event.date.month}/${event.date.day}/${event.date.year} - Participants: ${event.participants.length}/${event.maxParticipants}'),
              trailing: event.pendingRequests.contains(user!.id) ? const Text('Pending') : ElevatedButton(
                onPressed: () => _requestJoin(context, event.id),
                child: const Text('Request Join'),
              ),
              onTap: () => _showEventDetails(context, event),
            ),
          );
        },
      ),
    );
  }

  void _requestJoin(BuildContext context, String eventId) {
    context.read<EventProvider>().requestJoinEvent(eventId, context.read<AuthProvider>().currentUser!.id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Join request submitted')),
    );
  }

  void _showEventDetails(BuildContext context, Event event) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(event.title),
        content: Text(event.description),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
