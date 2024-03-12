import 'dart:convert';

import 'message.dart';

class Choice {
  final Message message;
  final String finish_reason;
  final int index;
  Choice({
    required this.message,
    required this.finish_reason,
    required this.index,
  });

  Choice copyWith({
    Message? message,
    String? finish_reason,
    int? index,
  }) {
    return Choice(
      message: message ?? this.message,
      finish_reason: finish_reason ?? this.finish_reason,
      index: index ?? this.index,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message.toMap(),
      'finish_reason': finish_reason,
      'index': index,
    };
  }

  factory Choice.fromMap(Map<String, dynamic> map) {
    return Choice(
      message: Message.fromMap(map['message'] as Map<String, dynamic>),
      finish_reason: map['finish_reason'] as String,
      index: map['index'].toInt() as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Choice.fromJson(String source) =>
      Choice.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Choice(message: $message, finish_reason: $finish_reason, index: $index)';

  @override
  bool operator ==(covariant Choice other) {
    if (identical(this, other)) return true;

    return other.message == message &&
        other.finish_reason == finish_reason &&
        other.index == index;
  }

  @override
  int get hashCode =>
      message.hashCode ^ finish_reason.hashCode ^ index.hashCode;
}
