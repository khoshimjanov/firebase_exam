import 'package:firebase_exam_demo/core/either/either.dart';
import 'package:firebase_exam_demo/features/user/domain/entity/authenticated_user.dart';

import '../../../../core/failure/failure.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, AuthenticatedUserEntity>> getUser()async{


// if(5==5){
//   return Right(AuthenticatedUserEntity(email: ''));
// }
return Left(ServerFailure(code: 400,message: 'error'));
  }

  Future<Either<Failure, AuthenticatedUserEntity>> login(String email, String password);

  Future<Either<Failure, void>> logout();
}