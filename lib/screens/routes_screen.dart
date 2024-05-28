import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter_travel_guide_app/models/route.dart';
import './route_builder_screen.dart';

class RoutesScreen extends StatefulWidget {
  @override
  _RoutesScreenState createState() => _RoutesScreenState();
}

class _RoutesScreenState extends State<RoutesScreen> {
  List<TravelRoute> _routes = [];

  @override
  void initState() {
    super.initState();
    _loadRoutes();
  }

  Future<void> _loadRoutes() async {
    print('Loading routes...');
    final prefs = await SharedPreferences.getInstance();
    final routeKeys = prefs.getKeys().where((key) => key.startsWith('route_'));
    print('Route keys: $routeKeys');
    final routes = <TravelRoute>[];
    for (final key in routeKeys) {
      final jsonString = prefs.getString(key);
      print('Route JSON: $jsonString');
      try {
        final routeData = json.decode(jsonString!);
        final route = TravelRoute.fromJson(routeData);
        routes.add(route);
      } catch (e) {
        print('Error decoding route JSON: $e');
      }
    }
    setState(() {
      _routes = routes;
    });
    print('Routes loaded: ${_routes.length}');
  }

  void _navigateToRouteBuilder() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RouteBuilderScreen()),
    );
    _loadRoutes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Маршруты'),
      ),
      body: _routes.isEmpty
          ? Center(child: Text('Нет сохраненных маршрутов'))
          : ListView.builder(
              itemCount: _routes.length,
              itemBuilder: (context, index) {
                final route = _routes[index];
                return ListTile(
                  title: Text('${route.country} - ${route.vacationType}'),
                  subtitle: Text(
                    '${route.budget}, ${route.duration}, ${route.transportation}',
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToRouteBuilder,
        child: Icon(Icons.add),
      ),
    );
  }
}
