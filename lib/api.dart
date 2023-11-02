import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GitHubRepository {
  final String name;
  final String description;
  final int stars;
  final String ownerUsername;
  final String ownerAvatarUrl;

  GitHubRepository({
    required this.name,
    required this.description,
    required this.stars,
    required this.ownerUsername,
    required this.ownerAvatarUrl,
  });

  factory GitHubRepository.fromJson(Map<String, dynamic> json) {
    return GitHubRepository(
      name: json['name'],
      description: json['description'] ?? "",
      stars: json['stargazers_count'],
      ownerUsername: json['owner']['login'],
      ownerAvatarUrl: json['owner']['avatar_url'],
    );
  }
}

final githubRepositoriesProvider = FutureProvider<List<GitHubRepository>>(
      (ref) async {
    final response = await http.get(Uri.parse(
        'https://api.github.com/search/repositories?q=created:>2022-04-29&sort=stars&order=desc'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body)['items'];
      final repositories = jsonList.map((json) {
        return GitHubRepository.fromJson(json);
      }).toList();

      return repositories;
    } else {
      throw Exception('Failed to load GitHub repositories');
    }
  },
);