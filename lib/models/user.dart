import 'dart:convert';


class User {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String photoURL;
  final String fcmToken;
  final String country;
  final String currency;
  final bool didUserSignUp;
  final String type;
  final String token;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.photoURL,
    required this.fcmToken,
    required this.country,
    required this.currency,
    required this.didUserSignUp,
    required this.type,
    required this.token,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? photoURL,
    String? fcmToken,
    String? country,
    String? currency,
    bool? didUserSignUp,
    String? type,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoURL: photoURL ?? this.photoURL,
      fcmToken: fcmToken ?? this.fcmToken,
      country: country ?? this.country,
      currency: currency ?? this.currency,
      didUserSignUp: didUserSignUp ?? this.didUserSignUp,
      type: type ?? this.type,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'photoURL': photoURL,
      'fcmToken': fcmToken,
      'country': country,
      'currency': currency,
      'didUserSignUp': didUserSignUp,
      'type': type,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      photoURL: map['photoURL'] ?? '',
      fcmToken: map['fcmToken'] ?? '',
      country: map['country'] ?? '',
      currency: map['currency'] ?? '',
      didUserSignUp: map['didUserSignUp'] ?? false,
      type: map['type'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, phoneNumber: $phoneNumber, photoURL: $photoURL, fcmToken: $fcmToken, country: $country, currency: $currency, didUserSignUp: $didUserSignUp, type: $type, token: $token)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.photoURL == photoURL &&
        other.fcmToken == fcmToken &&
        other.country == country &&
        other.currency == currency &&
        other.didUserSignUp == didUserSignUp &&
        other.type == type &&
        other.token == token;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        photoURL.hashCode ^
        fcmToken.hashCode ^
        country.hashCode ^
        currency.hashCode ^
        didUserSignUp.hashCode ^
        type.hashCode ^
        token.hashCode;
  }
}
// class UserProvider extends StateNotifier<User> {
//   UserProvider(super.state);

//   void setUser(User user) {
//     state = user;
//   }

  
// }

// final userProvider = StateNotifierProvider<UserProvider, User>((ref) {
//   return UserProvider(User(
//     id: '',
//     name: '',
//     email: '',
//     phoneNumber: '',
//     photoURL: '',
//     fcmToken: '',
//     country: '',
//     currency: '',
//     didUserSignUp: false,
//     type: '',
//     token: '',
//   ));
// });