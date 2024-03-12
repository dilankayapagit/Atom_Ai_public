// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PromptTranslationModel {
  final String? en;
  final String? fr;
  final String? es;
  final String? de;
  final String? it;
  final String? zh;
  final String? ja;
  PromptTranslationModel({
    this.en,
    this.fr,
    this.es,
    this.de,
    this.it,
    this.zh,
    this.ja,
  });
 

  PromptTranslationModel copyWith({
    String? en,
    String? fr,
    String? es,
    String? de,
    String? it,
    String? zh,
    String? ja,
  }) {
    return PromptTranslationModel(
      en: en ?? this.en,
      fr: fr ?? this.fr,
      es: es ?? this.es,
      de: de ?? this.de,
      it: it ?? this.it,
      zh: zh ?? this.zh,
      ja: ja ?? this.ja,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'en': en,
      'fr': fr,
      'es': es,
      'de': de,
      'it': it,
      'zh': zh,
      'ja': ja,
    };
  }

  factory PromptTranslationModel.fromMap(Map<String, dynamic> map) {
    return PromptTranslationModel(
      en: map['en'] != null ? map['en'] as String : null,
      fr: map['fr'] != null ? map['fr'] as String : null,
      es: map['es'] != null ? map['es'] as String : null,
      de: map['de'] != null ? map['de'] as String : null,
      it: map['it'] != null ? map['it'] as String : null,
      zh: map['zh'] != null ? map['zh'] as String : null,
      ja: map['ja'] != null ? map['ja'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PromptTranslationModel.fromJson(String source) => PromptTranslationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PromptTranslationModel(en: $en, fr: $fr, es: $es, de: $de, it: $it, zh: $zh, ja: $ja)';
  }

  @override
  bool operator ==(covariant PromptTranslationModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.en == en &&
      other.fr == fr &&
      other.es == es &&
      other.de == de &&
      other.it == it &&
      other.zh == zh &&
      other.ja == ja;
  }

  @override
  int get hashCode {
    return en.hashCode ^
      fr.hashCode ^
      es.hashCode ^
      de.hashCode ^
      it.hashCode ^
      zh.hashCode ^
      ja.hashCode;
  }
}
