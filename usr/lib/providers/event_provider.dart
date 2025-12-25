import 'package:flutter/material.dart';
import '../models/event.dart';

class EventProvider with ChangeNotifier {
  List<Event> _events = [
    Event(
      id: '1',
      title: 'Monthly Leadership Dinner',
      description: 'An exclusive dinner for women in leadership positions to network and share experiences.',
      date: DateTime.now().add(const Duration(days: 30)),
      maxParticipants: 10,
      participants: ['user1', 'user2'],
      pendingRequests: ['user3'],
    ),
  ];

  List<Event> get events => _events;

  void addEvent(Event event) {
    _events.add(event);
    notifyListeners();
  }

  void requestJoinEvent(String eventId, String userId) {
    final eventIndex = _events.indexWhere((e) => e.id == eventId);
    if (eventIndex != -1) {
      _events[eventIndex].pendingRequests.add(userId);
      notifyListeners();
    }
  }

  void approveRequest(String eventId, String userId) {
    final eventIndex = _events.indexWhere((e) => e.id == eventId);
    if (eventIndex != -1) {
      _events[eventIndex].pendingRequests.remove(userId);
      _events[eventIndex].participants.add(userId);
      notifyListeners();
    }
  }

  void rejectRequest(String eventId, String userId) {
    final eventIndex = _events.indexWhere((e) => e.id == eventId);
    if (eventIndex != -1) {
      _events[eventIndex].pendingRequests.remove(userId);
      notifyListeners();
    }
  }
}
