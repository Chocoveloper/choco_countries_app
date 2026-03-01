// To parse this JSON data, do
//
//     final country = countryFromJson(jsonString);

import 'dart:convert';

List<Country> countryFromJson(String str) =>
    List<Country>.from(json.decode(str).map((x) => Country.fromJson(x)));

class Country {
  List<String> capital;
  String region;
  String subregion;
  int population;
  Name name;
  String nombreEspanol;
  Flags flags;

  Country({
    required this.capital,
    required this.region,
    required this.subregion,
    required this.population,
    required this.name,
    required this.nombreEspanol,
    required this.flags,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    capital       : List<String>.from(json["capital"].map((x) => x)),
    region        : json["region"],
    subregion     : json["subregion"],
    population    : json["population"],
    name          : Name.fromJson(json["name"]),
    flags         : Flags.fromJson(json["flags"]),
    nombreEspanol : json["translations"]?["spa"]?["common"] ?? "Sin traducción",
  );
}

class Flags {
  String png;
  String svg;
  String alt;

  Flags({required this.png, required this.svg, required this.alt});

  factory Flags.fromJson(Map<String, dynamic> json) =>
      Flags(png: json["png"], svg: json["svg"], alt: json["alt"]);
}

class Name {
  String common;
  String official;

  Name({required this.common, required this.official});

  factory Name.fromJson(Map<String, dynamic> json) =>
      Name(common: json["common"], official: json["official"]);
}
