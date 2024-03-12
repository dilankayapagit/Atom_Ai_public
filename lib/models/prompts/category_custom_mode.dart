// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CategoryCustomModel {
  final String? name;
  final String? titleTranslation;

  final String? id;
  final dynamic createAt;
  final dynamic titleTranslationModel;

  CategoryCustomModel({
    this.name,
    this.titleTranslation,
    this.id,
    this.createAt,
    this.titleTranslationModel,
  });

  CategoryCustomModel copyWith({
    String? name,
    String? titleTranslation,
    String? id,
    dynamic createAt,
    dynamic titleTranslationModel,
  }) {
    return CategoryCustomModel(
      name: name ?? this.name,
      titleTranslation: titleTranslation ?? this.titleTranslation,
      id: id ?? this.id,
      createAt: createAt ?? this.createAt,
      titleTranslationModel:
          titleTranslationModel ?? this.titleTranslationModel,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'titleTranslation': titleTranslation,
      'id': id,
      'createAt': createAt,
      'titleTranslationModel': titleTranslationModel,
    };
  }

  factory CategoryCustomModel.fromMap(Map<String, dynamic> map) {
    return CategoryCustomModel(
      name: map['name'] != null ? map['name'] as String : null,
      titleTranslation: map['titleTranslation'] != null
          ? map['titleTranslation'] as String
          : null,
      id: map['id'] != null ? map['id'] as String : null,
      createAt: map['createAt'] != null ? map['createAt'] as dynamic : null,
      titleTranslationModel: map['titleTranslationModel'] != null
          ? map['titleTranslationModel'] as dynamic
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryCustomModel.fromJson(String source) =>
      CategoryCustomModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CategoryCustomModel(name: $name, titleTranslation: $titleTranslation, id: $id, createAt: $createAt, titleTranslationModel: $titleTranslationModel)';
  }

  @override
  bool operator ==(covariant CategoryCustomModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.titleTranslation == titleTranslation &&
        other.id == id &&
        other.createAt == createAt &&
        other.titleTranslationModel == titleTranslationModel;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        titleTranslation.hashCode ^
        id.hashCode ^
        createAt.hashCode ^
        titleTranslationModel.hashCode;
  }
}
