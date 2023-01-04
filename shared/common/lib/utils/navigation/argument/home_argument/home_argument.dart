import 'package:dependencies/equatable/equatable.dart';

class HomeArgument extends Equatable {
  final String username;
  final String name;
  final String email;
  final String emailVerifiedAt;
  final String ktp;
  final String balance;
  final String profilePicture;
  final String cardNumber;

  const HomeArgument({
    required this.username,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.ktp,
    required this.balance,
    required this.profilePicture,
    required this.cardNumber,
  });

  @override
  List<Object?> get props => [
        username,
        name,
        email,
        emailVerifiedAt,
        ktp,
        balance,
        profilePicture,
        cardNumber,
      ];
}
