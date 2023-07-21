import 'package:flutter/material.dart';
import 'package:appsoed/home.dart';
import 'package:appsoed/livechat.dart';

void main() {
  runApp(MaterialApp(
    // home: const Home(),
    initialRoute: "/",
    routes: {
      "/": (context) => const Home(),
      "/livechat": (context) => const LiveChat()
    },
  ));
}
