class Rate {
  final String id;
  final String symbol;
  final String? currencySymbol;
  final String type;
  final String rateUsd;

  Rate(
      {required this.id,
      required this.symbol,
      required this.currencySymbol,
      required this.type,
      required this.rateUsd});

  factory Rate.fromJson(Map<String, dynamic> json) => Rate(
        id: json['id'],
        symbol: json['symbol'],
        currencySymbol: json['currencySymbol'],
        type: json['type'],
        rateUsd: json['rateUsd'],
      );
}
