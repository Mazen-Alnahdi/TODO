
import 'package:todo/core/usecase/usecase.dart';
import 'package:todo/core/utils/typedef.dart';
import 'package:todo/src/authentication/domain/entities/user.dart';
import 'package:todo/src/authentication/domain/repositories/authentication_repository.dart';

class GetUsers extends UsecaseWithoutParams<List<User>> {

  const GetUsers(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<List<User>> call() async => _repository.getUsers();

}