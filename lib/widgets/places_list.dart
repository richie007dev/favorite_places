import 'package:flutter/material.dart';
import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/place_detail.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.places});
  final List<Place> places;
  void _navigatePage(BuildContext context, String title) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => PlaceDetailScreen(title: title)),
    );
  }
  @override
  Widget build(BuildContext context) {
    if(places.isEmpty){
      return const Center(
        child: Text(
          'No places added yet!',
          style: TextStyle(color: Colors.white),
        ),
      );
    }
    return ListView.builder(
        itemCount: places.length,
        itemBuilder: (ctx, index) => ListTile(
          key: ValueKey(places[index]),
          title: Text(places[index].title),
          onTap: () {
            _navigatePage(context, places[index].title);
          },
        ));
  }
}