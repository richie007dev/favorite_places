import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favorite_places/models/favorite_place.dart';

class FavoritePlaceProvider extends StateNotifier<List<FavoritePlace>> {
  FavoritePlaceProvider() : super([]);
  void addPlace(FavoritePlace place) {
    state = [...state, place];
  }
}

final favoritePlaceProvider =
    StateNotifierProvider<FavoritePlaceProvider, List<FavoritePlace>>(
  (ref) => FavoritePlaceProvider(),
);
