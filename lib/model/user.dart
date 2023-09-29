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
}

class Address {
  late final String street;
  late final String suite;
  late final String city;
  late final String zipcode;
  late final Geo geo;

  Address(this.street, this.suite, this.city, this.zipcode, this.geo);
}

class Geo {
  late final String lat;
  late final String lng;

  Geo(this.lat, this.lng);
}

class Company {
  late final String name;
  late final String catchPhrase;
  late final String bs;

  Company(this.name, this.catchPhrase, this.bs);
}