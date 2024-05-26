import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/user.dart';

class UserDetailPage extends StatelessWidget {
  final int userId;

  UserDetailPage({required this.userId, super.key});

  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pengguna'),
      ),
      body: FutureBuilder<User>(
        future: apiService.fetchUserById(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final user = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.avatar),
                    radius: 50,
                  ),
                  const SizedBox(height: 16),
                  Text('Nama: ${user.firstName} ${user.lastName}'),
                  const SizedBox(height: 8),
                  Text('Email: ${user.email}'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
