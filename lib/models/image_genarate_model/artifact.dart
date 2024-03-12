// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Artifact {
  final String? base64;
  final int? seed;
  final String? finishReason;
  final dynamic imgbytes;
  Artifact({
    this.base64,
    this.seed,
    this.finishReason,
    this.imgbytes,
  });

  Artifact copyWith({
    String? base64,
    int? seed,
    String? finishReason,
    dynamic imgbytes,
  }) {
    return Artifact(
      base64: base64 ?? this.base64,
      seed: seed ?? this.seed,
      finishReason: finishReason ?? this.finishReason,
      imgbytes: imgbytes ?? this.imgbytes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'base64': base64,
      'seed': seed,
      'finishReason': finishReason,
      'imgbytes': imgbytes,
    };
  }

  factory Artifact.fromMap(Map<String, dynamic> map) {
    return Artifact(
      base64: map['base64'] != null ? map['base64'] as String : null,
      seed: map['seed'] != null ? map['seed'] as int : null,
      finishReason:
          map['finishReason'] != null ? map['finishReason'] as String : null,
      imgbytes: map['imgbytes'] != null ? map['imgbytes'] as dynamic : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Artifact.fromJson(String source) =>
      Artifact.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Artifact(base64: $base64, seed: $seed, finishReason: $finishReason, imgbytes: $imgbytes)';
  }

  @override
  bool operator ==(covariant Artifact other) {
    if (identical(this, other)) return true;

    return other.base64 == base64 &&
        other.seed == seed &&
        other.finishReason == finishReason &&
        other.imgbytes == imgbytes;
  }

  @override
  int get hashCode {
    return base64.hashCode ^
        seed.hashCode ^
        finishReason.hashCode ^
        imgbytes.hashCode;
  }
}
