import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:theeran/api.dart';

class GitHubRepositoriesList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repositoriesAsyncValue = ref.watch(githubRepositoriesProvider);

    return repositoriesAsyncValue.when(
      data: (repositories) {
        return ListView.builder(
          itemCount: repositories.length,
          itemBuilder: (context, index) {
            final repository = repositories[index];
            return Card(
              elevation: 5,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(repository.ownerAvatarUrl),
                ),
                title: Text(repository.name),
                subtitle: Text(repository.description),
                trailing: Text('Stars: ${repository.stars.toString()}'),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator(color: Colors.green,)),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
    );
  }
}
