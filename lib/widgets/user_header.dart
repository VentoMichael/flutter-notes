import 'package:flutter/material.dart';
import '../models/user.dart';
import '../constants.dart'; // Import the constants file

class UserHeader extends StatelessWidget {
  final User user;

  const UserHeader({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 24.0), // Added more space at the top
      decoration: BoxDecoration(
        color: userHeaderBackgroundColor, // Use a color or gradient
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24.0),
          bottomRight: Radius.circular(24.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blueGrey.shade700,
            radius: 40.0,
            child: Text(
              user.name.isNotEmpty ? user.name[0] : '?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: userHeaderTextColor, // Use color constant
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user.position ?? 'Unknown Position',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.person_outline, color: primaryColor, size: 20.0),
                    const SizedBox(width: 8),
                    Text(
                      'Role: ${user.role}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
