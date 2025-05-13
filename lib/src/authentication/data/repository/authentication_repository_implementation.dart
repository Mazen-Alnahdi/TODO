import 'package:dartz/dartz.dart';
import 'package:todo/core/errors/exceptions.dart';
import 'package:todo/core/errors/failure.dart';
import 'package:todo/core/utils/typedef.dart';
import 'package:todo/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:todo/src/authentication/domain/entities/user.dart';
import 'package:todo/src/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImplementation extends AuthenticationRepository {
  //Dependency inversion
  const AuthenticationRepositoryImplementation(this._remoteDataSource);

  final AuthenticationRemoteDataSource _remoteDataSource;

  @override
  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    //Test Driven Development
    //Call the remote data source
    // make sure to returns the proper data if there is no exception
    // // check if the method returns proper data
    // // check if when the remoteDataSource throws an exception,
    // we return a failure and if it
    try {
      await _remoteDataSource.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );
      return const Right(null);
    } on APIException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() {
    // TODO: implement getUsers
    throw UnimplementedError();
  }
}
