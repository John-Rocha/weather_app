import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/domain/entities/user_entity.dart';
import 'package:weather_app/domain/usecases/auth.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late AuthUseCases authUseCases;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    authUseCases = AuthUseCases(authRepository: mockAuthRepository);
  });

  const testUserEntity = UserEntity(
    id: '123',
    email: '',
    name: '',
    photoUrl: '',
  );

  group('test authentication', () {
    test('should return success for login with email and password', () {
      // arrange
      when(mockAuthRepository.logInWithEmailAndPassword(
        email: testUserEntity.email,
        password: '12345',
      )).thenAnswer((_) async => Future.value());

      // act
      final result = authUseCases.login('', '');

      // assert
      expect(result, isA<Future<void>>());
    });

    test('should return success google login', () {
      // arrange
      when(mockAuthRepository.logInWithGoogle())
          .thenAnswer((_) async => Future.value());

      // act
      final result = authUseCases.logInWithGoogle();

      // assert
      expect(result, isA<Future<void>>());
    });

    test('should return success for sign up with email and password', () {
      // arrange
      when(mockAuthRepository.signUp(
        email: testUserEntity.email,
        password: '12345',
      )).thenAnswer((_) async => Future.value());

      // act
      final result = authUseCases.signUp('', '');

      // assert
      expect(result, isA<Future<void>>());
    });

    test('should return success for logout', () {
      // arrange
      when(mockAuthRepository.logOut()).thenAnswer((_) async => Future.value());

      // act
      final result = authUseCases.logOut();

      // assert
      expect(result, isA<Future<void>>());
    });
  });
}
