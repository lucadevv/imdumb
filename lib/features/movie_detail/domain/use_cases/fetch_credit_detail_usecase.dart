import 'package:dartz/dartz.dart';
import 'package:imdumb/core/utils/constans/app_language.dart';
import 'package:imdumb/core/utils/exeptions/app_exceptions.dart';
import 'package:imdumb/features/movie_detail/domain/entities/credit_detail_entity.dart';
import 'package:imdumb/features/movie_detail/domain/repository/movie_detail_repository.dart';

class FetchCreditDetailUsecase {
  final MovieDetailRepository _repository;

  FetchCreditDetailUsecase({required MovieDetailRepository repository})
      : _repository = repository;

  Future<Either<AppException, CreditDetailEntity>> fetchCreditDetail({
    required String creditId,
    String? language = AppLanguage.spanish,
  }) async {
    return await _repository.fetchCreditDetail(
      creditId: creditId,
      language: language,
    );
  }
}
