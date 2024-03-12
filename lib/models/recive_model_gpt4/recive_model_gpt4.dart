import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'choice.dart';
import 'usage.dart';

class ReciveModelGpt4 {
  final String id;
  final String object;
  final int created;
  final String model;
  final Usage usage;
  final List<Choice> choices;
  ReciveModelGpt4({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.usage,
    required this.choices,
  });

  ReciveModelGpt4 copyWith({
    String? id,
    String? object,
    int? created,
    String? model,
    Usage? usage,
    List<Choice>? choices,
  }) {
    return ReciveModelGpt4(
      id: id ?? this.id,
      object: object ?? this.object,
      created: created ?? this.created,
      model: model ?? this.model,
      usage: usage ?? this.usage,
      choices: choices ?? this.choices,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'object': object,
      'created': created,
      'model': model,
      'usage': usage.toMap(),
      'choices': choices.map((x) => x.toMap()).toList(),
    };
  }

  factory ReciveModelGpt4.fromMap(Map<String, dynamic> map) {
    return ReciveModelGpt4(
      id: map['id'] as String,
      object: map['object'] as String,
      created: map['created'].toInt() as int,
      model: map['model'] as String,
      usage: Usage.fromMap(map['usage'] as Map<String,dynamic>),
      choices: List<Choice>.from((map['choices'] as List<dynamic>).map<Choice>((x) => Choice.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReciveModelGpt4.fromJson(String source) => ReciveModelGpt4.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReciveMOdelGpt4(id: $id, object: $object, created: $created, model: $model, usage: $usage, choices: $choices)';
  }

  @override
  bool operator ==(covariant ReciveModelGpt4 other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.object == object &&
      other.created == created &&
      other.model == model &&
      other.usage == usage &&
      listEquals(other.choices, choices);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      object.hashCode ^
      created.hashCode ^
      model.hashCode ^
      usage.hashCode ^
      choices.hashCode;
  }
}