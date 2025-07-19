class PetProtectionProduct {
  final int id;
  final String name;
  final String image;

  // Add new attributes
  final bool tick;
  final bool flea;
  final bool earMite;
  final bool demodexMite;
  final bool sarcopticMite;
  final bool lice;
  final bool heartworm;
  final bool mosquito;
  final bool roundworm;
  final bool hookworm;
  final bool whipworm;
  final bool tapeworm;

  PetProtectionProduct({
    required this.id,
    required this.name,
    required this.image,
    required this.tick,
    required this.flea,
    required this.earMite,
    required this.demodexMite,
    required this.sarcopticMite,
    required this.lice,
    required this.heartworm,
    required this.mosquito,
    required this.roundworm,
    required this.hookworm,
    required this.whipworm,
    required this.tapeworm,
  });

  factory PetProtectionProduct.fromJson(Map<String, dynamic> json) {
    return PetProtectionProduct(
      id: json['id'],
      name: json['name'],
      image: 'assets/images/canimax.png', // Assuming a default image path
      tick: json['tick'],
      flea: json['flea'],
      earMite: json['ear_mite'],
      demodexMite: json['demodex_mite'],
      sarcopticMite: json['sarcoptic_mite'],
      lice: json['lice'],
      heartworm: json['heartworm'],
      mosquito: json['mosquito'],
      roundworm: json['roundworm'],
      hookworm: json['hookworm'],
      whipworm: json['whipworm'],
      tapeworm: json['tapeworm'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'tick': tick,
        'flea': flea,
        'ear_mite': earMite,
        'demodex_mite': demodexMite,
        'sarcoptic_mite': sarcopticMite,
        'lice': lice,
        'heartworm': heartworm,
        'mosquito': mosquito,
        'roundworm': roundworm,
        'hookworm': hookworm,
        'whipworm': whipworm,
        'tapeworm': tapeworm,
      };
}
