// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NotifySendModel {
  final String? token;
  final String? title;
  final String? body;
    final String? img;

  final String? type;
  final String? id;
  final dynamic createdAt;

  NotifySendModel({
    this.token,
    this.title,
    this.body,
    this.img,
    this.type,
    this.id,
    this.createdAt,
  });

  NotifySendModel copyWith({
    String? token,
    String? title,
    String? body,
    String? img,
    String? type,
    String? id,
    dynamic createdAt,
  }) {
    return NotifySendModel(
      token: token ?? this.token,
      title: title ?? this.title,
      body: body ?? this.body,
      img: img ?? this.img,
      type: type ?? this.type,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'title': title,
      'body': body,
      'img': img,
      'type': type,
      'id': id,
      'createdAt': createdAt,
    };
  }

  factory NotifySendModel.fromMap(Map<String, dynamic> map) {
    return NotifySendModel(
      token: map['token'] != null ? map['token'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      body: map['body'] != null ? map['body'] as String : null,
      img: map['img'] != null ? map['img'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as dynamic : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotifySendModel.fromJson(String source) =>
      NotifySendModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NotifySendModel(token: $token, title: $title, body: $body, img: $img, type: $type, id: $id, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant NotifySendModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.token == token &&
      other.title == title &&
      other.body == body &&
      other.img == img &&
      other.type == type &&
      other.id == id &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return token.hashCode ^
      title.hashCode ^
      body.hashCode ^
      img.hashCode ^
      type.hashCode ^
      id.hashCode ^
      createdAt.hashCode;
  }
}
