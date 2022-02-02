import 'package:flutter/material.dart';
import 'feedback_position_provider.dart';
import 'root_app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => FeedbackPositionProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: RootApp(),
        ),
      );
}
