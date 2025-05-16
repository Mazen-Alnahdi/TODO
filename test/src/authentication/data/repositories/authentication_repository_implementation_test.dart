import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo/core/errors/exceptions.dart';
import 'package:todo/core/errors/failure.dart';
import 'package:todo/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:todo/src/authentication/data/repository/authentication_repository_implementation.dart';
import 'package:todo/src/authentication/domain/entities/user.dart';

class MockAuthenticationRemoteDataSource extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRepositoryImplementation repositoryImplementation;
  setUp(() {
    remoteDataSource = MockAuthenticationRemoteDataSource();
    repositoryImplementation = AuthenticationRepositoryImplementation(
      remoteDataSource,
    );
  });

  const tException = APIException(
    message: 'Unknown Error Occurred',
    statusCode: 500,
  );

  group('create user', () {
    final createdAt = "whatever.createdAt";
    final name = 'whatever.name';
    final avatar = 'whatever.avatar';

    test('Should call the [RemoteDataSource.createUser] and '
        'complete successfully when the remote source is successful', () async {
      //arrange
      when(
        () => remoteDataSource.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        ),
      ).thenAnswer((_) async => Future.value());

      //act
      final result = await repositoryImplementation.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );

      //assert
      expect(result, equals(const Right(null)));
      verify(
        () => remoteDataSource.createUser(
          createdAt: createdAt,
          name: name,
          avatar: avatar,
        ),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test('Should return a [APIFailure] when the call to '
        'the remote source is unsuccessful', () async {
      when(
        () => remoteDataSource.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        ),
      ).thenThrow(tException);

      final result = await repositoryImplementation.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );

      expect(
        result,
        equals(
          Left(
            ApiFailure(
              message: tException.message,
              statusCode: tException.statusCode,
            ),
          ),
        ),
      );

      verify(
        () => remoteDataSource.createUser(
          createdAt: createdAt,
          name: name,
          avatar: avatar,
        ),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });

  group('get users', () {
    test(
      'should call the [RemoteDataSource.getUser] and '
      'return [List<User>] when call to remote source is successful',
      () async {
        //arrange
        when(() => remoteDataSource.getUsers()).thenAnswer((_) async => []);

        //act
        final result = await repositoryImplementation.getUsers();

        //assert
        expect(result, isA<Right<dynamic, List<User>>>());
        verify(() => remoteDataSource.getUsers()).called(1);
        verifyNoMoreInteractions(remoteDataSource);
        //dart cant see the Right and Left thus we use
        // the isA function to properly compare the types
      },
    );

    test('should return a [APIFailure] when the call to '
        'the remote source is unsuccessful', () async {
      when(() => remoteDataSource.getUsers()).thenThrow(tException);

      final result = await repositoryImplementation.getUsers();

      expect(
        result,
        Left(
          ApiFailure(
            message: tException.message,
            statusCode: tException.statusCode,
          ),
        ),
      );
    });
  });
}
