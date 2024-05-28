import 'package:flutter/material.dart';
import 'route_builder_screen.dart';
import '../widgets/bottom_navigation.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> _premiumRoutes = [
    {
      'title': 'Исторический маршрут',
      'image': 'assets/image/costel.jpg',
      'description':
          'Откройте для себя богатую историю мира и посетите знаменитые исторические достопримечательности.',
    },
    {
      'title': 'Природный маршрут',
      'image': 'assets/image/gora.jpg',
      'description':
          'Насладитесь красотой природы и совершите увлекательный поход по живописным тропам.',
    },
    {
      'title': 'Культурный маршрут',
      'image': 'assets/image/theatre.jpg',
      'description':
          'Погрузитесь в культурную жизнь города и посетите известные музеи, театры и галереи.',
    },
    {
      'title': 'Digital Detox',
      'image': 'assets/image/detox.jpg',
      'description': 'Освободите себя от давления информации.',
    },
    // Добавьте другие премиум маршруты по необходимости
  ];

  void _showRouteDetails(BuildContext context, Map<String, dynamic> route) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(route['title']),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(route['image']),
              SizedBox(height: 16.0),
              Text(route['description']),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Закрыть'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Путеводитель путешественника',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
          overflow: TextOverflow.fade,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Добро пожаловать в путеводитель путешественника!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Откройте для себя мир увлекательных путешествий с нашим приложением. Создавайте персонализированные маршруты, исследуйте новые места и делитесь своими приключениями с друзьями.',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Популярные маршруты:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.75,
              ),
              itemCount: _premiumRoutes.length,
              itemBuilder: (BuildContext context, int index) {
                final route = _premiumRoutes[index];
                return GestureDetector(
                  onTap: () {
                    _showRouteDetails(context, route);
                  },
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(8.0),
                            ),
                            child: Image.asset(
                              route['image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            route['title'],
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RouteBuilderScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
