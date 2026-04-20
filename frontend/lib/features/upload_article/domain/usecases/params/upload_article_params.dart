import 'package:equatable/equatable.dart';

class UploadArticleParams extends Equatable {
  final String title;
  final String description;
  final String content;
  final List<int> thumbnailBytes;
  final String thumbnailFileName;

  const UploadArticleParams({
    required this.title,
    required this.description,
    required this.content,
    required this.thumbnailBytes,
    required this.thumbnailFileName,
  });

  @override
  List<Object?> get props =>
      [title, description, content, thumbnailBytes, thumbnailFileName];
}
