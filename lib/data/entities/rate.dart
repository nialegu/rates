import '../enums/rate_type.dart';

class Rate {
  final String id;
  final String symbol;
  final String? currencySymbol;
  final RateType type;
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
        type: RateType.fromString(json['type']),
        rateUsd: json['rateUsd'],
      );

  @override
  bool operator ==(Object other) {
    return other is Rate && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;

  String get imagePath =>
      "https://assets.coincap.io/assets/icons/${symbol.toLowerCase()}@2x.png";
  String get alternateImagePath =>
      "https://cryptologos.cc/logos/thumbs/$id.png";

  String get coursePreservationAccuracy {
    final integerPart = rateUsd.substring(0, rateUsd.indexOf("."));
    String fractionalPart =
        rateUsd.replaceAll(integerPart, "").replaceAll('.', '');
    while (fractionalPart.endsWith("0")) {
      if (fractionalPart.length == 2) break;
      fractionalPart = fractionalPart.substring(0, fractionalPart.length - 2);
      if (!fractionalPart.endsWith("00")) break;
    }
    if (fractionalPart.length > 18) {
      return "$integerPart.${fractionalPart.substring(0, 18)}";
    } else if (fractionalPart.length == 1) {
      return "$integerPart.${fractionalPart}0";
    } else {
      return "$integerPart.$fractionalPart";
    }
  }
}
