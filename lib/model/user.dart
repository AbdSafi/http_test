class Users {
  late final int id;
  late final String name;
  late final String username;
  late final String email;
  late final Address address;
  late final String phone;
  late final String website;
  late final Company company;

  Users(this.id, this.name, this.username, this.email, this.address, this.phone,
      this.website, this.company);

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
        json['id'],
        json['name'],
        json['username'],
        json['email'],
        Address.fromJson(json['address']),
        json['phone'],
        json['website'],
        Company.fromJson(json['company']));
  }
}

class Address {
  late final String street;
  late final String suite;
  late final String city;
  late final String zipcode;
  late final Geo geo;

  Address(this.street, this.suite, this.city, this.zipcode, this.geo);

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      json['street'],
      json['suite'],
      json['city'],
      json['zipcode'],
      Geo.fromJson(json['geo']),
    );
  }
}

class Geo {
  late final String lat;
  late final String lng;

  Geo(this.lat, this.lng);

  factory Geo.fromJson(Map<String, dynamic> json) {
    return Geo(
      json['lat'],
      json['lng'],
    );
  }
}

class Company {
  late final String name;
  late final String catchPhrase;
  late final String bs;

  Company(this.name, this.catchPhrase, this.bs);

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      json['name'],
      json['catchPhrase'],
      json['bs'],
    );
  }
}