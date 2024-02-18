import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favorite_places/models/place.dart';

class FavoritePlaceProvider extends StateNotifier<List<Place>> {
  FavoritePlaceProvider() : super([]);
  void addPlace(Place place) {
    state = [...state, place];
  }
}

final favoritePlaceProvider =
    StateNotifierProvider<FavoritePlaceProvider, List<Place>>(
  (ref) => FavoritePlaceProvider(),
);
