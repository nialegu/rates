enum RateType {
  fiat,
  crypto,
  other; 

  static RateType fromString(String type) {
    switch(type) {
      case "fiat": return RateType.fiat;
      case "crypto": return RateType.crypto;
      default: return RateType.other;
    }
  }
}