import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';

import 'package:travel_salesman/route_model.dart';
import 'package:travel_salesman/map_route.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RouteModel()),
        Provider.value(value: GlobalKey<GoogleMapStateBase>()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class RouteCellWidget extends StatelessWidget {
  final Place place;
  RouteCellWidget(this.place)
  : super(key: Key(place.thumbnail));

  @override
  Widget build(BuildContext context) {
    return Card(
      key: Key(place.thumbnail),
      child: ListTile(
        onTap: () => {},
        title: Wrap(
          spacing: 10,
          children: [
            Text(place.thumbnail, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(place.name),
          ],
        ),
      ),
    );
  }
}

class RouteDetailsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var route = Provider.of<RouteModel>(context);

    return ReorderableListView(
      onReorder: route.move,
      children: [
        for (var c in route.places)
          RouteCellWidget(c),
      ],
    );
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: Row(
          children: [
            Expanded(child: RouteWidget()),
            Expanded(child: RouteDetailsWidget()),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {},
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
