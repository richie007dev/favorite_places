import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favorite_places/models/place.dart';

class UserPlacesProvider extends StateNotifier<List<Place>> {
  UserPlacesProvider() : super(const []);
  void addPlace(Place place) {
    state = [...state, place];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesProvider, List<Place>>(
  (ref) => UserPlacesProvider(),
);
