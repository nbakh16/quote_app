import 'package:cloud_firestore/cloud_firestore.dart';

class QuoteModel {
  final String? id;
  final String quote;
  final String author;
  final String addedBy;
  final Timestamp? createdAt;

  QuoteModel({
    this.id,
    required this.quote,
    required this.author,
    required this.addedBy,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'quote': quote,
      'author': author,
      'addedBy': addedBy,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  factory QuoteModel.fromMap(Map<String, dynamic> map, String documentId) {
    return QuoteModel(
      id: documentId,
      quote: map['quote'] as String,
      author: map['author'] as String,
      addedBy: map['addedBy'] as String,
      createdAt: map['createdAt'] as Timestamp,
    );
  }
}
