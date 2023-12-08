import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String photoUrl;
  final String fcmToken;
  final String country;
  final String currency;
  final bool didUserSignUp;
  final String type;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.photoUrl,
    required this.fcmToken,
    required this.country,
    required this.currency,
    required this.didUserSignUp,
    required this.type,
  });


  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? photoUrl,
    String? fcmToken,
    String? country,
    String? currency,
    bool? didUserSignUp,
    String? type,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phone ?? this.phoneNumber,
      photoUrl: photoUrl ?? this.photoUrl,
      fcmToken: fcmToken ?? this.fcmToken,
      country: country ?? this.country,
      currency: currency ?? this.currency,
      didUserSignUp: didUserSignUp ?? this.didUserSignUp,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phoneNumber,
      'photoUrl': photoUrl,
      'fcmToken': fcmToken,
      'country': country,
      'currency': currency,
      'didUserSignUp': didUserSignUp,
      'type': type,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phone'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      fcmToken: map['fcmToken'] ?? '',
      country: map['country'] ?? '',
      currency: map['currency'] ?? '',
      didUserSignUp: map['didUserSignUp'] ?? false,
      type: map['type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, phone: $phoneNumber, photoUrl: $photoUrl, fcmToken: $fcmToken, country: $country, currency: $currency, didUserSignUp: $didUserSignUp, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is User &&
      other.id == id &&
      other.name == name &&
      other.email == email &&
      other.phoneNumber == phoneNumber &&
      other.photoUrl == photoUrl &&
      other.fcmToken == fcmToken &&
      other.country == country &&
      other.currency == currency &&
      other.didUserSignUp == didUserSignUp &&
      other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      phoneNumber.hashCode ^
      photoUrl.hashCode ^
      fcmToken.hashCode ^
      country.hashCode ^
      currency.hashCode ^
      didUserSignUp.hashCode ^
      type.hashCode;
  }
}
