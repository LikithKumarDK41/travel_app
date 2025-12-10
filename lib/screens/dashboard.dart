import 'package:flutter/material.dart';
import '../layout/app_layout.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      child: Center(
        child: Text(
          "Dashboard Content Goes Here",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
