import 'package:firebase_exam_demo/core/either/either.dart';
import 'package:firebase_exam_demo/core/failure/failure.dart';
import 'package:firebase_exam_demo/core/usecase/usecase.dart';
import 'package:firebase_exam_demo/features/user/domain/repository/authentication.dart';

class LogoutUseCase implements UseCase<void, NoParams> {
  final AuthenticationRepository repository;

  LogoutUseCase({required this.repository});
  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return repository.logout();
  }
}
