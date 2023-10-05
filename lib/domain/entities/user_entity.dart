import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String? name;
  final String? email;
  final String? photoUrl;

  const UserEntity({
    required this.id,
    this.name,
    this.email,
    this.photoUrl,
  });

  static const empty = UserEntity(id: '');

  bool get isEmpty => this == UserEntity.empty;

  bool get isNotEmpty => this != UserEntity.empty;

  @override
  List<Object?> get props => [id, name, email, photoUrl];
}
