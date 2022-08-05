class Country {
  final String name;
  final String countryCode;
  final String flag;

  Country(this.name, this.countryCode, this.flag);

  static List<Country> languageList() {
    return <Country>[
      Country(' English', 'US', '🇺🇸'),
      Country(' Polish', 'PL', '🇵🇱'),
    ];
  }
}
