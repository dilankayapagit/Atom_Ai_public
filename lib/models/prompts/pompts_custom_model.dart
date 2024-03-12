// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PromptsCustomModel {
  final String? prompt;
  final String? title;
  final String? titleTranslation;

  final String? id;
  final String? categoryId;
  final String? categoryName;

  final String? imgUrl;
  final dynamic createAt;

  final dynamic titleTranslationModel;
  final dynamic promptTranslationModel;

  PromptsCustomModel({
    this.prompt,
    this.title,
    this.titleTranslation,
    this.id,
    this.categoryId,
    this.categoryName,
    this.imgUrl,
    this.createAt,
    this.titleTranslationModel,
    this.promptTranslationModel,
  });
  PromptsCustomModel copyWith({
    String? prompt,
    String? title,
    String? titleTranslation,
    String? id,
    String? categoryId,
    String? categoryName,
    String? imgUrl,
    dynamic createAt,
    dynamic titleTranslationModel,
    dynamic promptTranslationModel,
  }) {
    return PromptsCustomModel(
      prompt: prompt ?? this.prompt,
      title: title ?? this.title,
      titleTranslation: titleTranslation ?? this.titleTranslation,
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      imgUrl: imgUrl ?? this.imgUrl,
      createAt: createAt ?? this.createAt,
      titleTranslationModel:
          titleTranslationModel ?? this.titleTranslationModel,
      promptTranslationModel:
          promptTranslationModel ?? this.promptTranslationModel,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'prompt': prompt,
      'title': title,
      'titleTranslation': titleTranslation,
      'id': id,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'imgUrl': imgUrl,
      'createAt': createAt,
      'titleTranslationModel': titleTranslationModel,
      'promptTranslationModel': promptTranslationModel,
    };
  }

  factory PromptsCustomModel.fromMap(Map<String, dynamic> map) {
    return PromptsCustomModel(
      prompt: map['prompt'] != null ? map['prompt'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      titleTranslation: map['titleTranslation'] != null
          ? map['titleTranslation'] as String
          : null,
      id: map['id'] != null ? map['id'] as String : null,
      categoryId:
          map['categoryId'] != null ? map['categoryId'] as String : null,
      categoryName:
          map['categoryName'] != null ? map['categoryName'] as String : null,
      imgUrl: map['imgUrl'] != null ? map['imgUrl'] as String : null,
      createAt: map['createAt'] != null ? map['createAt'] as dynamic : null,
      titleTranslationModel: map['titleTranslationModel'] != null
          ? map['titleTranslationModel'] as dynamic
          : null,
      promptTranslationModel: map['promptTranslationModel'] != null
          ? map['promptTranslationModel'] as dynamic
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PromptsCustomModel.fromJson(String source) =>
      PromptsCustomModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PromptsCustomModel(prompt: $prompt, title: $title, titleTranslation: $titleTranslation, id: $id, categoryId: $categoryId, categoryName: $categoryName, imgUrl: $imgUrl, createAt: $createAt, titleTranslationModel: $titleTranslationModel, promptTranslationModel: $promptTranslationModel)';
  }

  @override
  bool operator ==(covariant PromptsCustomModel other) {
    if (identical(this, other)) return true;

    return other.prompt == prompt &&
        other.title == title &&
        other.titleTranslation == titleTranslation &&
        other.id == id &&
        other.categoryId == categoryId &&
        other.categoryName == categoryName &&
        other.imgUrl == imgUrl &&
        other.createAt == createAt &&
        other.titleTranslationModel == titleTranslationModel &&
        other.promptTranslationModel == promptTranslationModel;
  }

  @override
  int get hashCode {
    return prompt.hashCode ^
        title.hashCode ^
        titleTranslation.hashCode ^
        id.hashCode ^
        categoryId.hashCode ^
        categoryName.hashCode ^
        imgUrl.hashCode ^
        createAt.hashCode ^
        titleTranslationModel.hashCode ^
        promptTranslationModel.hashCode;
  }
}
