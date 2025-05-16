import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:todo/core/errors/exceptions.dart';
import 'package:todo/core/utils/constants.dart';
import 'package:todo/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:todo/src/authentication/data/models/user_model.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthenticationRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = AuthenticationRemoteDataSourceImplementation((client));
    registerFallbackValue(Uri());
  });

  group('createUser', () {
    test(
      'Should complete successfully when the status code is 200 or 201',
      () async {
        when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
          (_) async => http.Response('User Created Successfully', 201),
        );

        final methodCall = await remoteDataSource.createUser;

        expect(
          methodCall(createdAt: 'createdAt', name: 'name', avatar: 'avatar'),
          completes,
        );

        verify(
          () => client.post(
            Uri.https(kBaseUrl, kCreateUserEndpoint),
            body: jsonEncode({
              'createdAt': 'createdAt',
              'name': 'name',
              'avatar': 'avatar',
            }),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );

    test(
      'Should throw [APIException] when the status code is not 200 nor 201',
      () async {
        when(
          () => client.post(any(), body: any(named: 'body')),
        ).thenAnswer((_) async => http.Response('Invalid email address', 400));
        final methodCall = remoteDataSource.createUser;

        expect(
          () async => methodCall(
            createdAt: 'createdAt',
            name: 'name',
            avatar: 'avatar',
          ),
          throwsA(
            APIException(message: 'Invalid email address', statusCode: 400),
          ),
        );
        verify(
          () => client.post(
            Uri.https(kBaseUrl, kCreateUserEndpoint),
            body: jsonEncode({
              'createdAt': 'createdAt',
              'name': 'name',
              'avatar': 'avatar',
            }),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );
  });

  group('getUser', () {
    final tUser = [UserModel.empty()];
    test(
      'Should return [List<User>] when the status code is 200 or 201',
      () async {
        when(() => client.get(any())).thenAnswer(
          (_) async => http.Response(jsonEncode([tUser.first.toMap()]), 200),
        );
        final result = await remoteDataSource.getUsers();

        expect(result, equals(tUser));

        verify(
          () => client.get(Uri.https(kBaseUrl, kGetUserEndpoint)),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );
    test(
      'Should throw [APIException] when the status code is not 200 nor 201',
      () async {
        const tMessage = 'Server Down, Server Down, I repeat Server Down.';
        when(
          () => client.get(any()),
        ).thenAnswer((_) async => http.Response(tMessage, 500));

        final methodCall = remoteDataSource.getUsers;

        expect(
          () => methodCall(),
          throwsA(APIException(message: tMessage, statusCode: 500)),
        );

        verify(
          () => client.get(Uri.https(kBaseUrl, kGetUserEndpoint)),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );
  });
}
