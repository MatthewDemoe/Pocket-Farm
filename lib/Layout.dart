import 'package:flutter/material.dart';

class Layout {
  final String title;
  final IconData icon;
  final Function builder;

  const Layout({this.title, this.icon, this.builder});
}

Widget buildTabBar(List<Layout> options) {
  return TabBar(
    isScrollable: true,
    tabs: options.map<Widget>((Layout option) {
      return Tab(
        text: option.title,
        icon: Icon(option.icon),
      );
    }).toList(),
  );
}

Widget buildTabBarView(List<Layout> options) {
  return TabBarView(
    children: options.map<Widget>((Layout option) {
      return Padding(
        padding: EdgeInsets.all(16.0),
        child: Card(
          color: Colors.white,
          child: option.builder(),
        ),
      );
    }).toList(),
  );  
}

