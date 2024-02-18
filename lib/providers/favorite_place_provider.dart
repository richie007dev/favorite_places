import 'package:favorite_places/data/dummy_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final favoritePlaceProvider = Provider((ref) => dummyPlaces);
