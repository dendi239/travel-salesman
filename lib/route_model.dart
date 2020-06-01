import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';

class Place {
  final GeoCoord coord;
  final String thumbnail;
  final String name;

  Place(this.coord, this.thumbnail, this.name);
}

class RouteModel extends ChangeNotifier {
  final List<Place> places = [
    Place(GeoCoord(49.8522, 37.7333), "A", "Меловые горы"),
    Place(GeoCoord(49.3198, 36.9171), "B", "Каньон в Балаклейском районе"),
    Place(GeoCoord(49.6144, 36.3188), "C", "Харьковский чернобыль"),
    Place(GeoCoord(49.6867, 35.8332), "D", "Голубое озеро"),
  ];

  void add(Place place) {
    places.add(place);
    notifyListeners();
  }

  void move(int oldIndex, int newIndex) {
    var movedPlace = places.removeAt(oldIndex);
    if (newIndex >= oldIndex) newIndex -= 1;
    places.insert(newIndex, movedPlace);
    notifyListeners();
  }

  void center(MapOperations map) {
    map.clearMarkers();

    GeoCoord mmin = places.first.coord, mmax = places.first.coord;
    for (var place in places) {
      map.addMarkerRaw(place.coord, label: place.thumbnail);
      mmin = GeoCoord(
        min(mmin.latitude, place.coord.latitude),
        min(mmin.longitude, place.coord.longitude),
      );
      mmax = GeoCoord(
        max(mmax.latitude, place.coord.latitude),
        max(mmax.longitude, place.coord.longitude),
      );
    }

    map.clearDirections();

    for (int i = 0; i + 1 < places.length; ++i) {
      map.addDirection(
        places[i].coord,
        places[i + 1].coord,
        startLabel: places[i].thumbnail,
        endLabel: places[i + 1].thumbnail,
      );
    }

    map.moveCamera(GeoCoordBounds(southwest: mmin, northeast: mmax));
  }
}
