import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon:const  Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppLocalizations.of(context)!.notification,
          style:const TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          _buildNotificationItem(
            title: 'Lorem ipsum dolor sit amet',
            description:
                'Donec sit amet feugiat diam. Vestibulum tempor tempor pulvinar.',
            date: '3 hours ago',
            isNew: true,
            icon: Icons
                .notifications, // Replace with your custom icon if available
          ),
          _buildNotificationItem(
            title: 'Lorem ipsum dolor sit amet',
            description: 'Donec sit amet feugiat diam.',
            date: '15 Sep 2024, 11:12 AM',
            isNew: false,
            icon: Icons.settings, // Replace with your custom icon if available
          ),
          _buildNotificationItem(
            title: 'Lorem ipsum dolor sit amet',
            description: 'Donec sit amet feugiat diam.',
            date: '15 Sep 2024, 11:12 AM',
            isNew: false,
            icon: Icons.photo, // Replace with your custom icon if available
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem({
    required String title,
    required String description,
    required String date,
    required bool isNew,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: isNew ? Colors.blue.shade100 : Colors.transparent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 30),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
