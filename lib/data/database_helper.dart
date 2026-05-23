import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/meal.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  late final SupabaseClient _client;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<void> init() async {
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL'] ?? '',
      anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
    );
    _client = Supabase.instance.client;
  }

  Future<int> insertMeal(Meal meal) async {
    await _client.from('meals').insert(meal.toMap());
    return 1;
  }

  Future<List<Meal>> getMeals() async {
    final response = await _client.from('meals').select().order('date', ascending: false);
    return response.map((json) => Meal.fromMap(json)).toList();
  }

  Future<int> updateMeal(Meal meal) async {
    await _client.from('meals').update(meal.toMap()).eq('id', meal.id);
    return 1;
  }

  Future<int> deleteMeal(String id) async {
    await _client.from('meals').delete().eq('id', id);
    return 1;
  }
}
