import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_app/features/auth/presentation/auth_page.dart';

class HomePage extends StatelessWidget {
  static const routeName = 'home';
  final String userEmail;
  const HomePage({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //create quote
        },
        child: Icon(Icons.add),
      ),
      body: Center(
        child: Text('Home'),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quote App',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            userEmail,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            context.goNamed(AuthPage.routeName);
          },
          icon: Icon(
            Icons.logout,
          ),
        ),
      ],
      backgroundColor: Colors.purple,
      foregroundColor: Colors.white,
    );
  }
}
