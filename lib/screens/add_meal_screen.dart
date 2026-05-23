import 'package:flutter/material.dart';
import '../models/meal.dart';

class AddMealScreen extends StatefulWidget {
  final Meal? meal;
  const AddMealScreen({super.key, this.meal});

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  late TextEditingController _placeController;
  late TextEditingController _foodController;
  late TextEditingController _priceController;
  late TextEditingController _obsController;
  late Rating _selectedRating;

  @override
  void initState() {
    super.initState();
    _placeController = TextEditingController(text: widget.meal?.placeName ?? '');
    _foodController = TextEditingController(text: widget.meal?.foodName ?? '');
    _priceController = TextEditingController(text: widget.meal?.price ?? '');
    _obsController = TextEditingController(text: widget.meal?.observations ?? '');
    _selectedRating = widget.meal?.rating ?? Rating.maybe;
  }

  @override
  void dispose() {
    _placeController.dispose();
    _foodController.dispose();
    _priceController.dispose();
    _obsController.dispose();
    super.dispose();
  }

  void _saveMeal() {
    if (_placeController.text.trim().isEmpty || _foodController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha o local e o prato pedido!')),
      );
      return;
    }

    final newMeal = Meal(
      id: widget.meal?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      placeName: _placeController.text,
      foodName: _foodController.text,
      price: _priceController.text.isNotEmpty ? _priceController.text : 'R\$ 0,00',
      rating: _selectedRating,
      observations: _obsController.text,
      date: widget.meal?.date ?? DateTime.now().toString(),
    );

    Navigator.pop(context, newMeal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.meal == null ? 'Registrar Refeição' : 'Editar Registro',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _placeController,
              decoration: InputDecoration(
                labelText: 'Nome do Local',
                hintText: 'Ex: Restaurante do Jhow',
                prefixIcon: Icon(Icons.store, color: Theme.of(context).primaryColor),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _foodController,
              decoration: InputDecoration(
                labelText: 'Prato Consumido',
                hintText: 'Ex: Parmegiana de Frango',
                prefixIcon: Icon(Icons.restaurant_menu, color: Theme.of(context).primaryColor),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Preço',
                hintText: 'Ex: 35,00',
                prefixIcon: Icon(Icons.payments_outlined, color: Theme.of(context).primaryColor),
                prefixText: 'R\$ ',
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Como foi a experiência?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildRatingButton(Rating.yes, Icons.sentiment_very_satisfied, Colors.green, 'Voltaria'),
                  _buildRatingButton(Rating.maybe, Icons.sentiment_neutral, Colors.amber, 'Talvez'),
                  _buildRatingButton(Rating.none, Icons.sentiment_very_dissatisfied, Colors.red, 'Não'),
                ],
              ),
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _obsController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Observações Adicionais',
                hintText: 'O que você achou de especial?',
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 40),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: _saveMeal,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: const Text('Salvar Experiência', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingButton(Rating rating, IconData icon, Color color, String label) {
    final isSelected = _selectedRating == rating;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRating = rating;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: isSelected ? color : Colors.grey.shade400,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? color : Colors.grey.shade600,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
