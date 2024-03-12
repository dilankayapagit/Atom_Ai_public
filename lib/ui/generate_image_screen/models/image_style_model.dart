import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ImageStyleModel {
  final String? id;
  final String? img;
  final String? title;
  ImageStyleModel({
     this.id,
     this.img,
     this.title,
  });

  ImageStyleModel copyWith({
    String? id,
    String? img,
    String? title,
  }) {
    return ImageStyleModel(
      id: id ?? this.id,
      img: img ?? this.img,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'img': img,
      'title': title,
    };
  }

  factory ImageStyleModel.fromMap(Map<String, dynamic> map) {
    return ImageStyleModel(
      id: map['id'] != null ? map['id'] as String : null,
      img: map['img'] != null ? map['img'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageStyleModel.fromJson(String source) => ImageStyleModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ImageStyleModel(id: $id, img: $img, title: $title)';

  @override
  bool operator ==(covariant ImageStyleModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.img == img &&
      other.title == title;
  }

  @override
  int get hashCode => id.hashCode ^ img.hashCode ^ title.hashCode;
}
