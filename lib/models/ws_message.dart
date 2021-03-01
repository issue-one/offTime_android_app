import 'dart:convert';

class Message<T> {
  final String event;
  final T data;
  Message(this.event, this.data);
  factory Message.fromJson(Map<String, dynamic> json) =>
      Message(json["event"], json["data"]);

  String toJson() => jsonEncode({
        "event": event,
        "data": jsonEncode(data),
      });
}
