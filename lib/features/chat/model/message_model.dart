class MessageModel {
  final String userId;
  final String userName;
  final String text;
  final String id;
  final DateTime timestamp;

  MessageModel({
    required this.userId,
    required this.userName,
    required this.text,
    required this.id,
    required this.timestamp,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      userId: json['userId'],
      userName: json['userName'],
      text: json['text'],
      id: json['id'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'text': text,
      'id': id,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
