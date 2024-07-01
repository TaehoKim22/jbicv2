import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbicv2/src/models/book_user.dart';
import 'package:jbicv2/src/notifiers/profile_notifier.dart';

final profileNotifierProvider = Provider.family<ProfileNotifier, int>((ref, userId) {
  return ProfileNotifier(userId);
});

final profileDataProvider = FutureProvider.family<BookUser, int>((ref, userId) async {
  final profileNotifier = ref.watch(profileNotifierProvider(userId));
  return await profileNotifier.loadBookUser();
});

class ProfilePage extends ConsumerWidget {
  final int userId;

  const ProfilePage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileData = ref.watch(profileDataProvider(userId));

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: _buildProfileContent(context, profileData, ref),
    );
  }

  Widget _buildProfileContent(BuildContext context, AsyncValue<BookUser> profileData, WidgetRef ref) {
    return profileData.when(
      data: (user) => _buildProfileHeader(context, user, ref),
      error: (error, stackTrace) => Center(
        child: Text('Error: $error'),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, BookUser user, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40.0,
                backgroundImage: user.photoURL != null ? NetworkImage(user.photoURL!) : null,
                child: user.photoURL == null ? Text(user.userName[0]) : null,
              ),
              const SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.userName, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  _handleDeleteButtonClick(ref, user);
                },
                child: const Text('Sign Out'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleDeleteButtonClick(WidgetRef ref, BookUser user) {
    // Implement delete functionality here
    ref.read(profileNotifierProvider(userId)).SignOut();
  }
}
