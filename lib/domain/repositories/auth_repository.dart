import 'package:weather_app/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> logInWithGoogle();

  Future<void> signUp({
    required String email,
    required String password,
  });

  UserEntity get currentUser;

  Stream<UserEntity> get user;

  Future<void> logOut();
}
