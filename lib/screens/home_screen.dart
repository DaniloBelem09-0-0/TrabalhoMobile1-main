import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/meal.dart';
import '../data/database_helper.dart';
import 'add_meal_screen.dart';
import 'meal_detail_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Meal> _meals = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMeals();
  }

  Future<void> _loadMeals() async {
    setState(() => _isLoading = true);
    try {
      final meals = await _dbHelper.getMeals();
      if (mounted) {
        setState(() {
          _meals = meals;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao carregar refeições: $e'),
            backgroundColor: Colors.redAccent,
            duration: const Duration(seconds: 8),
          ),
        );
      }
    }
  }

  Color _getRatingColor(Rating rating) {
    switch (rating) {
      case Rating.yes:
        return Colors.green.shade600;
      case Rating.maybe:
        return Colors.amber.shade700;
      case Rating.none:
        return Colors.red.shade600;
    }
  }

  Widget _getRatingIcon(Rating rating) {
    switch (rating) {
      case Rating.yes:
        return Icon(Icons.sentiment_very_satisfied, color: _getRatingColor(rating), size: 28);
      case Rating.maybe:
        return Icon(Icons.sentiment_neutral, color: _getRatingColor(rating), size: 28);
      case Rating.none:
        return Icon(Icons.sentiment_very_dissatisfied, color: _getRatingColor(rating), size: 28);
    }
  }

  void _deleteMeal(String id) async {
    await _dbHelper.deleteMeal(id);
    _loadMeals();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Refeição removida com sucesso!')),
    );
  }

  Future<void> _editMeal(Meal meal) async {
    final updatedMeal = await Navigator.push<Meal>(
      context,
      MaterialPageRoute(builder: (context) => AddMealScreen(meal: meal)),
    );

    if (updatedMeal != null) {
      await _dbHelper.updateMeal(updatedMeal);
      _loadMeals();
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Meal> highlightedMeals = _meals.where((m) => m.rating == Rating.yes).toList();
    if (highlightedMeals.isEmpty && _meals.isNotEmpty) {
      highlightedMeals.add(_meals.first);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Refeições'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _meals.isEmpty
              ? _buildEmptyState()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (highlightedMeals.isNotEmpty) ...[
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Favoritos 🌟',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 200,
                        child: PageView.builder(
                          itemCount: highlightedMeals.length,
                          itemBuilder: (context, index) {
                            final meal = highlightedMeals[index];
                            return _buildHighlightCard(meal);
                          },
                        ),
                      ),
                    ],
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Histórico',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        itemCount: _meals.length,
                        itemBuilder: (context, index) {
                          final meal = _meals[index];
                          return _buildMealTile(meal);
                        },
                      ),
                    ),
                  ],
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newMeal = await Navigator.push<Meal>(
            context,
            MaterialPageRoute(builder: (context) => const AddMealScreen()),
          );
          if (newMeal != null) {
            await _dbHelper.insertMeal(newMeal);
            _loadMeals();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.restaurant_menu, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            'Nenhuma refeição registrada.',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 18),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              final newMeal = await Navigator.push<Meal>(
                context,
                MaterialPageRoute(builder: (context) => const AddMealScreen()),
              );
              if (newMeal != null) {
                await _dbHelper.insertMeal(newMeal);
                _loadMeals();
              }
            },
            child: const Text('Registrar Primeira'),
          ),
        ],
      ),
    );
  }

  Widget _buildMealTile(Meal meal) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Card(
        margin: EdgeInsets.zero,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _getRatingColor(meal.rating).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: _getRatingIcon(meal.rating),
          ),
          title: Text(
            meal.placeName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              '${meal.foodName} • ${meal.price}',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
          trailing: PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'edit') _editMeal(meal);
              if (value == 'delete') _deleteMeal(meal.id);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit, size: 20, color: Colors.blue),
                    SizedBox(width: 8),
                    Text('Editar'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, size: 20, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Excluir'),
                  ],
                ),
              ),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MealDetailScreen(meal: meal),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHighlightCard(Meal meal) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MealDetailScreen(meal: meal),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.0),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF1B5E20),
                Theme.of(context).primaryColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24.0),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor.withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                right: -20,
                top: -20,
                child: Icon(Icons.restaurant_rounded, size: 100, color: Colors.white.withOpacity(0.1)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'RECOMENDADO',
                      style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    meal.placeName,
                    style: GoogleFonts.outfit(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    meal.foodName,
                    style: GoogleFonts.inter(fontSize: 16, color: Colors.white70),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '💰 ${meal.price}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.arrow_forward_ios, color: Theme.of(context).primaryColor, size: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
