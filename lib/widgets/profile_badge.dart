import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileBadge extends StatelessWidget {
  final VoidCallback onTap;
  const ProfileBadge({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(
            FirebaseAuth.instance.currentUser?.uid,
          )
          .get(),
      builder: (ctx, snapshot) {
        if (!snapshot.hasError && snapshot.hasData) {
          var data = snapshot.data as DocumentSnapshot<Map<String, dynamic>>?;
          return GestureDetector(
            onTap: onTap,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                (data!.data())!['imageUrl'] ?? '',
              ),
            ),
          );
        } else {
          return CircleAvatar(
            backgroundColor: Colors.grey.shade600,
          );
        }
      },
    );
  }
}
