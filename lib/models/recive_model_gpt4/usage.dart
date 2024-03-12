import 'dart:convert';

class Usage {
  final int prompt_tokens;
  final int completion_tokens;
  final int total_tokens;
  Usage({
    required this.prompt_tokens,
    required this.completion_tokens,
    required this.total_tokens,
  });

  Usage copyWith({
    int? prompt_tokens,
    int? completion_tokens,
    int? total_tokens,
  }) {
    return Usage(
      prompt_tokens: prompt_tokens ?? this.prompt_tokens,
      completion_tokens: completion_tokens ?? this.completion_tokens,
      total_tokens: total_tokens ?? this.total_tokens,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'prompt_tokens': prompt_tokens,
      'completion_tokens': completion_tokens,
      'total_tokens': total_tokens,
    };
  }

  factory Usage.fromMap(Map<String, dynamic> map) {
    return Usage(
      prompt_tokens: map['prompt_tokens'].toInt() as int,
      completion_tokens: map['completion_tokens'].toInt() as int,
      total_tokens: map['total_tokens'].toInt() as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Usage.fromJson(String source) => Usage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Usage(prompt_tokens: $prompt_tokens, completion_tokens: $completion_tokens, total_tokens: $total_tokens)';

  @override
  bool operator ==(covariant Usage other) {
    if (identical(this, other)) return true;
  
    return 
      other.prompt_tokens == prompt_tokens &&
      other.completion_tokens == completion_tokens &&
      other.total_tokens == total_tokens;
  }

  @override
  int get hashCode => prompt_tokens.hashCode ^ completion_tokens.hashCode ^ total_tokens.hashCode;
}