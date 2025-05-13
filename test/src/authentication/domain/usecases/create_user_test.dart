// What does the class depend on?
//Answer -- AuthenticationRepository
//How can we create a fake version of the dependency
//Answer --Use Mocktail
//How do we control with our dependencies
//Answer -- Using the Mocktail APIs

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:todo/src/authentication/domain/usecases/create_user.dart';

import 'authentication_repository.mock.dart';

void main() {
  late CreateUser usecase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthenticationRepository();
    usecase = CreateUser(repository);
  });

  const params = CreateUserParams.empty();

  test('Should call the [Repository.createUser] ', () async {
    //Arrange
    //STUB
    when(
      () => repository.createUser(
        createdAt: any(named: 'createdAt'),
        name: any(named: 'name'),
        avatar: any(named: 'avatar'),
      ),
    ).thenAnswer((_) async => const Right(null));

    //Act
    final result = await usecase(params);

    //Assert
    expect(result, equals(const Right<dynamic, void>(null)));

    verify(
      () => repository.createUser(
        createdAt: params.createdAt,
        name: params.name,
        avatar: params.avatar,
      ),
    ).called(1);

    verifyNoMoreInteractions(repository);
  });
}
