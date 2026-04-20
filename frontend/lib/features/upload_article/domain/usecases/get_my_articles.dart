import 'package:news_app_clean_architecture/core/usecase/usecase.dart';
import 'package:news_app_clean_architecture/features/upload_article/domain/entities/user_article.dart';
import 'package:news_app_clean_architecture/features/upload_article/domain/repository/user_article_repository.dart';

class GetMyArticlesUseCase
    implements UseCase<List<UserArticleEntity>, void> {
  final UserArticleRepository _repository;

  GetMyArticlesUseCase(this._repository);

  @override
  Future<List<UserArticleEntity>> call({void params}) {
    return _repository.getMyArticles();
  }
}
