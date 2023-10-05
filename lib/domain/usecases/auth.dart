import 'package:weather_app/domain/repositories/auth_repository.dart';

class AuthUseCases {
  final AuthRepository _authRepository;

  const AuthUseCases({required AuthRepository authRepository})
      : _authRepository = authRepository;

  Future<void> login(String email, String password) async {
    return _authRepository.logInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logInWithGoogle() async {
    return _authRepository.logInWithGoogle();
  }

  Future<void> signUp(String email, String password) async {
    return _authRepository.signUp(
      email: email,
      password: password,
    );
  }

  Future<void> logOut() async {
    return _authRepository.logOut();
  }
}
