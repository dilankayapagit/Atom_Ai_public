// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PayCustomPay {
  final String? payName;
  final String? payId;
  final String? entitleId;
  final String? type;
  final int? maxTxt;
  final int? wordsAnu;
  final String? engine;
  final int? maxImg;

  PayCustomPay({
    this.payName,
    this.payId,
    this.entitleId,
    this.type,
    this.maxTxt,
    this.wordsAnu,
    this.engine,
    this.maxImg,
  });

  PayCustomPay copyWith({
    String? payName,
    String? payId,
    String? entitleId,
    String? type,
    int? maxTxt,
    int? wordsAnu,
    String? engine,
    int? maxImg,
  }) {
    return PayCustomPay(
      payName: payName ?? this.payName,
      payId: payId ?? this.payId,
      entitleId: entitleId ?? this.entitleId,
      type: type ?? this.type,
      maxTxt: maxTxt ?? this.maxTxt,
      wordsAnu: wordsAnu ?? this.wordsAnu,
      engine: engine ?? this.engine,
      maxImg: maxImg ?? this.maxImg,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'payName': payName,
      'payId': payId,
      'entitleId': entitleId,
      'type': type,
      'maxTxt': maxTxt,
      'wordsAnu': wordsAnu,
      'engine': engine,
      'maxImg': maxImg,
    };
  }

  factory PayCustomPay.fromMap(Map<String, dynamic> map) {
    return PayCustomPay(
      payName: map['payName'] != null ? map['payName'] as String : null,
      payId: map['payId'] != null ? map['payId'] as String : null,
      entitleId: map['entitleId'] != null ? map['entitleId'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      maxTxt: map['maxTxt'] != null ? map['maxTxt'] as int : null,
      wordsAnu: map['wordsAnu'] != null ? map['wordsAnu'] as int : null,
      engine: map['engine'] != null ? map['engine'] as String : null,
      maxImg: map['maxImg'] != null ? map['maxImg'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PayCustomPay.fromJson(String source) =>
      PayCustomPay.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PayCustomPay(payName: $payName, payId: $payId, entitleId: $entitleId, type: $type, maxTxt: $maxTxt, wordsAnu: $wordsAnu, engine: $engine, maxImg: $maxImg)';
  }

  @override
  bool operator ==(covariant PayCustomPay other) {
    if (identical(this, other)) return true;
  
    return 
      other.payName == payName &&
      other.payId == payId &&
      other.entitleId == entitleId &&
      other.type == type &&
      other.maxTxt == maxTxt &&
      other.wordsAnu == wordsAnu &&
      other.engine == engine &&
      other.maxImg == maxImg;
  }

  @override
  int get hashCode {
    return payName.hashCode ^
      payId.hashCode ^
      entitleId.hashCode ^
      type.hashCode ^
      maxTxt.hashCode ^
      wordsAnu.hashCode ^
      engine.hashCode ^
      maxImg.hashCode;
  }
}
