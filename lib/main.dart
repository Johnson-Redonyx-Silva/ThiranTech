import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:theeran/github_repositories_list.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: 'GitHub Repositories',
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: const Text('GitHub Repositories'),
          ),
          body: GitHubRepositoriesList(),
        ),
      ),
    );
  }
}
