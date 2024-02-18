import 'package:favorite_places/widgets/new_place.dart';
import 'package:flutter/material.dart';

class FavoritePlaces extends StatelessWidget {
  const FavoritePlaces({super.key});
  void _addPlace(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => const NewPlace()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              _addPlace(context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
