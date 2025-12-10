import 'package:flutter/material.dart';
import 'header.dart';
import 'sidebar.dart';

class AppLayout extends StatelessWidget {
  final Widget child;

  const AppLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width >= 900;

    return Scaffold(
      appBar: isDesktop
          ? null
          : const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppHeader(),
      ),

      drawer: isDesktop ? null : const AppSidebar(),

      body: Row(
        children: [
          /// Desktop Sidebar
          if (isDesktop) const AppSidebar(),

          /// Main content
          Expanded(
            child: Column(
              children: [
                if (isDesktop) const AppHeader(),

                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
