import 'package:news_app_clean_architecture/core/usecase/usecase.dart';
import 'package:news_app_clean_architecture/features/upload_article/domain/entities/user_article.dart';
import 'package:news_app_clean_architecture/features/upload_article/domain/repository/user_article_repository.dart';

class GetAllUserArticlesUseCase
    implements UseCase<List<UserArticleEntity>, void> {
  final UserArticleRepository _repository;

  GetAllUserArticlesUseCase(this._repository);

  @override
  Future<List<UserArticleEntity>> call({void params}) {
    return _repository.getAllUserArticles();
  }
}
