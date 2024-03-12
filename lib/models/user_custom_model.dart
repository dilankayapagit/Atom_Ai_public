// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserCustomModel {
  final String? userId;
  final String? phoneNumber;
  final String? email;
  final String? name;
  final String? icon;
  final int? wordCount;
  final int? imgCount;

  final String? pushToken;

  final dynamic wordCntReset;
  final dynamic updatedAt;
  final dynamic createdAt;
  UserCustomModel({
    this.userId,
    this.phoneNumber,
    this.email,
    this.name,
    this.icon,
    this.wordCount,
    this.imgCount,
    this.pushToken,
    this.wordCntReset,
    this.updatedAt,
    this.createdAt,
  });


  

  UserCustomModel copyWith({
    String? userId,
    String? phoneNumber,
    String? email,
    String? name,
    String? icon,
    int? wordCount,
    int? imgCount,
    String? pushToken,
    dynamic wordCntReset,
    dynamic updatedAt,
    dynamic createdAt,
  }) {
    return UserCustomModel(
      userId: userId ?? this.userId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      wordCount: wordCount ?? this.wordCount,
      imgCount: imgCount ?? this.imgCount,
      pushToken: pushToken ?? this.pushToken,
      wordCntReset: wordCntReset ?? this.wordCntReset,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'phoneNumber': phoneNumber,
      'email': email,
      'name': name,
      'icon': icon,
      'wordCount': wordCount,
      'imgCount': imgCount,
      'pushToken': pushToken,
      'wordCntReset': wordCntReset,
      'updatedAt': updatedAt,
      'createdAt': createdAt,
    };
  }

  factory UserCustomModel.fromMap(Map<String, dynamic> map) {
    return UserCustomModel(
      userId: map['userId'] != null ? map['userId'] as String : null,
      phoneNumber: map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      icon: map['icon'] != null ? map['icon'] as String : null,
      wordCount: map['wordCount'] != null ? map['wordCount'] as int : null,
      imgCount: map['imgCount'] != null ? map['imgCount'] as int : null,
      pushToken: map['pushToken'] != null ? map['pushToken'] as String : null,
      wordCntReset: map['wordCntReset'] != null ? map['wordCntReset'].toDate() as dynamic : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'].toDate() as dynamic : null,
      createdAt: map['createdAt'] != null ? map['createdAt'].toDate() as dynamic : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserCustomModel.fromJson(String source) => UserCustomModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserCustomModel(userId: $userId, phoneNumber: $phoneNumber, email: $email, name: $name, icon: $icon, wordCount: $wordCount, imgCount: $imgCount, pushToken: $pushToken, wordCntReset: $wordCntReset, updatedAt: $updatedAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant UserCustomModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.userId == userId &&
      other.phoneNumber == phoneNumber &&
      other.email == email &&
      other.name == name &&
      other.icon == icon &&
      other.wordCount == wordCount &&
      other.imgCount == imgCount &&
      other.pushToken == pushToken &&
      other.wordCntReset == wordCntReset &&
      other.updatedAt == updatedAt &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
      phoneNumber.hashCode ^
      email.hashCode ^
      name.hashCode ^
      icon.hashCode ^
      wordCount.hashCode ^
      imgCount.hashCode ^
      pushToken.hashCode ^
      wordCntReset.hashCode ^
      updatedAt.hashCode ^
      createdAt.hashCode;
  }
}
