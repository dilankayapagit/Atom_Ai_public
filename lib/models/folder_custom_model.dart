// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FolderCustomModel {
  final String? folderId;
  final String? folderName;
  final dynamic createAt;
  FolderCustomModel({
    this.folderId,
    this.folderName,
    this.createAt,
  });

  FolderCustomModel copyWith({
    String? folderId,
    String? folderName,
    dynamic createAt,
  }) {
    return FolderCustomModel(
      folderId: folderId ?? this.folderId,
      folderName: folderName ?? this.folderName,
      createAt: createAt ?? this.createAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'folderId': folderId,
      'folderName': folderName,
      'createAt': createAt,
    };
  }

  factory FolderCustomModel.fromMap(Map<String, dynamic> map) {
    return FolderCustomModel(
      folderId: map['folderId'] != null ? map['folderId'] as String : null,
      folderName:
          map['folderName'] != null ? map['folderName'] as String : null,
      createAt:
          map['createAt'] != null ? map['createAt'].toDate() as dynamic : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FolderCustomModel.fromJson(String source) =>
      FolderCustomModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'FolderCustomModel(folderId: $folderId, folderName: $folderName, createAt: $createAt)';

  @override
  bool operator ==(covariant FolderCustomModel other) {
    if (identical(this, other)) return true;

    return other.folderId == folderId &&
        other.folderName == folderName &&
        other.createAt == createAt;
  }

  @override
  int get hashCode =>
      folderId.hashCode ^ folderName.hashCode ^ createAt.hashCode;
}
