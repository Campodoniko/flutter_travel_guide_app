import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_travel_guide_app/models/route.dart';
import 'dart:convert';
import './routes_screen.dart';

class RouteBuilderScreen extends StatefulWidget {
  @override
  _RouteBuilderScreenState createState() => _RouteBuilderScreenState();
}

class _RouteBuilderScreenState extends State<RouteBuilderScreen> {
  final _formKey = GlobalKey<FormState>();
  String _country = '';
  String _vacationType = '';
  String _budget = '';
  String _duration = '';
  String _transportation = '';

  List<String> _countries = ['Россия', 'США', 'Франция', 'Италия', 'Испания'];
  List<String> _vacationTypes = [
    'Пляжный отдых',
    'Экскурсионный тур',
    'Активный отдых',
    'Шопинг'
  ];
  List<String> _budgetOptions = ['Эконом', 'Средний', 'Высокий', 'Люкс'];
  List<String> _durationOptions = [
    '3-5 дней',
    '7-10 дней',
    '2 недели',
    '1 месяц'
  ];
  List<String> _transportationOptions = [
    'Самолет',
    'Поезд',
    'Автобус',
    'Автомобиль'
  ];

  Future<void> _saveRoute() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      TravelRoute route = TravelRoute(
        country: _country,
        vacationType: _vacationType,
        budget: _budget,
        duration: _duration,
        transportation: _transportation,
      );

      String jsonData = json.encode(route.toJson());

      final prefs = await SharedPreferences.getInstance();
      final routeId = DateTime.now().millisecondsSinceEpoch.toString();
      await prefs.setString('route_$routeId', jsonData);

      print('Route saved: $jsonData');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RoutesScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Создание маршрута'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Поле выбора страны
              DropdownButtonFormField<String>(
                value: _country.isNotEmpty ? _country : null,
                items: _countries.map((String country) {
                  return DropdownMenuItem<String>(
                    value: country,
                    child: Text(country),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _country = newValue!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Страна',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, выберите страну';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              // Поле выбора типа отдыха
              DropdownButtonFormField<String>(
                value: _vacationType.isNotEmpty ? _vacationType : null,
                items: _vacationTypes.map((String vacationType) {
                  return DropdownMenuItem<String>(
                    value: vacationType,
                    child: Text(vacationType),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _vacationType = newValue!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Тип отдыха',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, выберите тип отдыха';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              // Поле выбора бюджета
              DropdownButtonFormField<String>(
                value: _budget.isNotEmpty ? _budget : null,
                items: _budgetOptions.map((String budget) {
                  return DropdownMenuItem<String>(
                    value: budget,
                    child: Text(budget),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _budget = newValue!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Бюджет',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, выберите бюджет';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              // Поле выбора продолжительности
              DropdownButtonFormField<String>(
                value: _duration.isNotEmpty ? _duration : null,
                items: _durationOptions.map((String duration) {
                  return DropdownMenuItem<String>(
                    value: duration,
                    child: Text(duration),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _duration = newValue!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Продолжительность',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, выберите продолжительность';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              // Поле выбора транспорта
              DropdownButtonFormField<String>(
                value: _transportation.isNotEmpty ? _transportation : null,
                items: _transportationOptions.map((String transportation) {
                  return DropdownMenuItem<String>(
                    value: transportation,
                    child: Text(transportation),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _transportation = newValue!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Транспорт',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, выберите транспорт';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _saveRoute,
                child: Text('Сохранить маршрут'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
