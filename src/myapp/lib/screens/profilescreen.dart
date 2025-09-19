import 'package:flutter/material.dart';
import '/models/userdata.dart';

class ProfileScreen extends StatelessWidget {
  final UserData userData;

  const ProfileScreen({super.key, required this.userData});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  'https://via.placeholder.com/100',
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: userData.login,
              decoration: InputDecoration(labelText: 'login'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: userData.email,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 20),

            const Divider(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
