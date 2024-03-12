// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'artifact.dart';

class ImageGenarateModel {
  final List<Artifact>? artifacts;
  ImageGenarateModel({
    this.artifacts,
  });

  ImageGenarateModel copyWith({
    List<Artifact>? artifacts,
  }) {
    return ImageGenarateModel(
      artifacts: artifacts ?? this.artifacts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'artifacts': artifacts!.map((x) => x.toMap()).toList(),
    };
  }

  factory ImageGenarateModel.fromMap(Map<String, dynamic> map) {
    return ImageGenarateModel(
      artifacts: map['artifacts'] != null
          ? List<Artifact>.from(
              (map['artifacts'] as List<dynamic>).map<Artifact?>(
                (x) => Artifact.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageGenarateModel.fromJson(String source) =>
      ImageGenarateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ImageGenarateModel(artifacts: $artifacts)';

  @override
  bool operator ==(covariant ImageGenarateModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.artifacts, artifacts);
  }

  @override
  int get hashCode => artifacts.hashCode;
}
