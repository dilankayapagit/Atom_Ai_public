// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class NoteFirebaseModel {
  final String? title;
  final String? docId;
  final String? note;
  final String? parentId;
  final bool? locked;
  final bool? pinned;
  final List<Map<String, String>>? noteQuillList;
  final dynamic noteQuill;
  final dynamic updateAt;

  NoteFirebaseModel({
    this.title,
    this.docId,
    this.note,
    this.parentId,
    this.locked,
    this.pinned,
    this.noteQuillList,
    this.noteQuill,
    this.updateAt,
  });

  NoteFirebaseModel copyWith({
    String? title,
    String? docId,
    String? note,
    String? parentId,
    bool? locked,
    bool? pinned,
    List<Map<String, String>>? noteQuillList,
    dynamic noteQuill,
    dynamic updateAt,
  }) {
    return NoteFirebaseModel(
      title: title ?? this.title,
      docId: docId ?? this.docId,
      note: note ?? this.note,
      parentId: parentId ?? this.parentId,
      locked: locked ?? this.locked,
      pinned: pinned ?? this.pinned,
      noteQuillList: noteQuillList ?? this.noteQuillList,
      noteQuill: noteQuill ?? this.noteQuill,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'docId': docId,
      'note': note,
      'parentId': parentId,
      'locked': locked,
      'pinned': pinned,
      'noteQuillList': noteQuillList,
      'noteQuill': noteQuill,
      'updateAt': updateAt,
    };
  }

  factory NoteFirebaseModel.fromMap(Map<String, dynamic> map) {
    return NoteFirebaseModel(
      title: map['title'] != null ? map['title'] as String : null,
      docId: map['docId'] != null ? map['docId'] as String : null,
      note: map['note'] != null ? map['note'] as String : null,
      parentId: map['parentId'] != null ? map['parentId'] as String : null,
      locked: map['locked'] != null ? map['locked'] as bool : null,
      pinned: map['pinned'] != null ? map['pinned'] as bool : null,
      noteQuillList:
          (map['noteQuillList'] as List<dynamic>?)?.cast<Map<String, String>>(),
      noteQuill: map['noteQuill'] as dynamic,
      updateAt: map['updateAt'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteFirebaseModel.fromJson(String source) =>
      NoteFirebaseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NoteFirebaseModel(title: $title, docId: $docId, note: $note, parentId: $parentId, locked: $locked, pinned: $pinned, noteQuillList: $noteQuillList, noteQuill: $noteQuill, updateAt: $updateAt)';
  }

  @override
  bool operator ==(covariant NoteFirebaseModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.docId == docId &&
        other.note == note &&
        other.parentId == parentId &&
        other.locked == locked &&
        other.pinned == pinned &&
        listEquals(other.noteQuillList, noteQuillList) &&
        other.noteQuill == noteQuill &&
        other.updateAt == updateAt;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        docId.hashCode ^
        note.hashCode ^
        parentId.hashCode ^
        locked.hashCode ^
        pinned.hashCode ^
        noteQuillList.hashCode ^
        noteQuill.hashCode ^
        updateAt.hashCode;
  }
}
