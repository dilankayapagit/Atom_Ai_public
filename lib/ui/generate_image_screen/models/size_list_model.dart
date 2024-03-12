// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class SizeListModel {
  final String? title;
  final List<int>? size;
  SizeListModel({
    this.title,
    this.size,
  });

  SizeListModel copyWith({
    String? title,
    List<int>? size,
  }) {
    return SizeListModel(
      title: title ?? this.title,
      size: size ?? this.size,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'size': size,
    };
  }

  factory SizeListModel.fromMap(Map<String, dynamic> map) {
    return SizeListModel(
      title: map['title'] != null ? map['title'] as String : null,
      size: map['size'] != null
          ? List<int>.from((map['size'] as List<int>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SizeListModel.fromJson(String source) =>
      SizeListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SizeListModel(title: $title, size: $size)';

  @override
  bool operator ==(covariant SizeListModel other) {
    if (identical(this, other)) return true;

    return other.title == title && listEquals(other.size, size);
  }

  @override
  int get hashCode => title.hashCode ^ size.hashCode;
}
