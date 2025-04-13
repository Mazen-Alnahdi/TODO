
import 'package:dartz/dartz.dart';
import 'package:todo/core/errors/failure.dart';
import 'package:todo/core/utils/typedef.dart';
import '../entities/user.dart';

abstract class AuthenticationRepository {
 const AuthenticationRepository();

 ResultVoid createUser({
   required String createdAt,
   required String name,
   required String avatar
});

 ResultFuture<List<User>> getUsers();
}