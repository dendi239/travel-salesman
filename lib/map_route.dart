import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';

import 'package:travel_salesman/route_model.dart';

class RouteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var route = Provider.of<RouteModel>(context);
    var key = Provider.of<GlobalKey<GoogleMapStateBase>>(context);

    var map = GoogleMap(key: key);
    var foo = GoogleMap.of(key);

    if (foo != null) {
      route.center(foo);
    }

    return map;
  }
}
