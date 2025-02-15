import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:list_of_users_test_task/di/locator.dart';
import 'package:list_of_users_test_task/presentation/pages/users_search/users_search_page.dart';

void main() async{
  await dotenv.load(fileName: ".env");
  initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: UsersSearchPage(),
    );
  }
}
