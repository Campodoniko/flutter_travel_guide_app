class TravelRoute {
  final String country;
  final String vacationType;
  final String budget;
  final String duration;
  final String transportation;

  TravelRoute({
    required this.country,
    required this.vacationType,
    required this.budget,
    required this.duration,
    required this.transportation,
  });

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'vacationType': vacationType,
      'budget': budget,
      'duration': duration,
      'transportation': transportation,
    };
  }

  factory TravelRoute.fromJson(Map<String, dynamic> json) {
    return TravelRoute(
      country: json['country'],
      vacationType: json['vacationType'],
      budget: json['budget'],
      duration: json['duration'],
      transportation: json['transportation'],
    );
  }
}
