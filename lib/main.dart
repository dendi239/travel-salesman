import 'dart:math';

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

  RouteCellWidget(this.place) : super(key: Key(place.thumbnail));

  @override
  Widget build(BuildContext context) {
    return Card(
      key: Key(place.thumbnail),
      child: ListTile(
        onTap: () => {},
        title: Wrap(
          spacing: 10,
          children: [
            Text(place.thumbnail,
                style: TextStyle(fontWeight: FontWeight.bold)),
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
        for (var c in route.places) RouteCellWidget(c),
      ],
    );
  }
}

class MyScaffold extends StatefulWidget{
  @override
  _MyScaffoldState createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold>{
  bool expanded = true;
  var rightPanelWidth;
  var buttonWidth;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    rightPanelWidth = max(width / 4, 228.0);
    buttonWidth = max(width / 20, 60.0);
    final height = mediaQuery.size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps Sample App'),
        backgroundColor: Colors.green[700],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Expanded(child: RouteWidget()),
          Positioned(
            right: 0,
            top: 0,
            height: height,
            child: AnimatedContainer(
              color: Colors.white,
              duration: const Duration(milliseconds: 200),
              width: expanded ? rightPanelWidth : 0,
              child: RouteDetailsWidget(),
            ),
          ),
          Positioned(
            right: expanded ? rightPanelWidth - buttonWidth / 2 : 0,
            width: buttonWidth,
            child: FloatingActionButton(
              child: Icon(
                  expanded ? Icons.arrow_forward_ios : Icons.arrow_back_ios),
              onPressed: () => setState(() {
                expanded = !expanded;
              }),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: Icon(Icons.add),
      ),
    );
  }
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: MyScaffold(),
    );
  }
}
