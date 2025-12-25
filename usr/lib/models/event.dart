class Event {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final int maxParticipants;
  final List<String> participants;
  final List<String> pendingRequests;
  final bool isActive;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.maxParticipants,
    this.participants = const [],
    this.pendingRequests = const [],
    this.isActive = true,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      maxParticipants: json['maxParticipants'],
      participants: List<String>.from(json['participants'] ?? []),
      pendingRequests: List<String>.from(json['pendingRequests'] ?? []),
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'maxParticipants': maxParticipants,
      'participants': participants,
      'pendingRequests': pendingRequests,
      'isActive': isActive,
    };
  }
}
