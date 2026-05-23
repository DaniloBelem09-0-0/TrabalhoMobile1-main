enum Rating { none, maybe, yes }

class Meal {
  final String id;
  final String placeName;
  final String foodName;
  final String price;
  final Rating rating;
  final String observations;
  final String date;

  Meal({
    required this.id,
    required this.placeName,
    required this.foodName,
    required this.price,
    required this.rating,
    required this.observations,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'placeName': placeName,
      'foodName': foodName,
      'price': price,
      'rating': rating.index,
      'observations': observations,
      'date': date,
    };
  }

  factory Meal.fromMap(Map<String, dynamic> map) {
    return Meal(
      id: map['id'],
      placeName: map['placeName'],
      foodName: map['foodName'],
      price: map['price'],
      rating: Rating.values[map['rating']],
      observations: map['observations'],
      date: map['date'] ?? '',
    );
  }

  Meal copyWith({
    String? id,
    String? placeName,
    String? foodName,
    String? price,
    Rating? rating,
    String? observations,
    String? date,
  }) {
    return Meal(
      id: id ?? this.id,
      placeName: placeName ?? this.placeName,
      foodName: foodName ?? this.foodName,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      observations: observations ?? this.observations,
      date: date ?? this.date,
    );
  }
}
