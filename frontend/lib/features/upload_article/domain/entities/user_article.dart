import 'package:equatable/equatable.dart';

class UserArticleEntity extends Equatable {
  final String? id;
  final String authorId;
  final String? authorEmail;
  final String title;
  final String description;
  final String content;
  final String? thumbnailUrl;
  final DateTime publishedAt;

  const UserArticleEntity({
    this.id,
    required this.authorId,
    this.authorEmail,
    required this.title,
    required this.description,
    required this.content,
    this.thumbnailUrl,
    required this.publishedAt,
  });

  @override
  List<Object?> get props => [
        id,
        authorId,
        authorEmail,
        title,
        description,
        content,
        thumbnailUrl,
        publishedAt,
      ];
}
