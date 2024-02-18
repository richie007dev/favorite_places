import 'package:favorite_places/models/favorite_place.dart';
import 'package:favorite_places/providers/favorite_place_provider.dart';
import 'package:favorite_places/widgets/new_place.dart';
import 'package:favorite_places/widgets/place_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritePlaces extends ConsumerStatefulWidget {
  const FavoritePlaces({super.key});

  @override
  ConsumerState<FavoritePlaces> createState() => _FavoritePlacesState();
}

class _FavoritePlacesState extends ConsumerState<FavoritePlaces> {

  void _addPlace(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => const NewPlace()),
    );
  }

  void _navigatePage(BuildContext context, String title) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => PlaceDetails(title: title)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<FavoritePlace> favoritePlaces = ref.watch(favoritePlaceProvider);
    
    
    Widget content = const Center(
      child: Text('No places added yet!', style: TextStyle(color: Colors.white),),
    );
    if(favoritePlaces.isNotEmpty){
     content = ListView.builder(
          itemCount: favoritePlaces.length,
          itemBuilder: (ctx, index) => ListTile(
            key: ValueKey(favoritePlaces[index]),
            title: Text(favoritePlaces[index].title),
            onTap: () {
              _navigatePage(context, favoritePlaces[index].title);
            },
          ));
    }
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
      body: content,
    );
  }
}
