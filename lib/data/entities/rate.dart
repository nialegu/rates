class Rate {
  final String id;
  final String symbol;
  final String? currencySymbol;
  final String type;
  final String rateUsd;

  Rate({
    required this.id,
    required this.symbol,
    required this.currencySymbol,
    required this.type,
    required this.rateUsd,
  });

  factory Rate.fromJson(Map<String, dynamic> json) => Rate(
        id: json['id'],
        symbol: json['symbol'],
        currencySymbol: json['currencySymbol'],
        type: json['type'],
        rateUsd: json['rateUsd'],
      );

  @override
  bool operator ==(Object other) {
    return other is Rate && id == other.id;
  }
  @override
  int get hashCode => id.hashCode;

  // TODO find any resourses to pull logos
  String get imagePath =>
      "https://assets.coincap.io/assets/icons/${symbol.toLowerCase()}@2x.png";
  String get alternateImagePath =>
      "https://cryptologos.cc/logos/thumbs/$id.png";

  String get shortCourseUsd => rateUsd.substring(0, 12);
}
