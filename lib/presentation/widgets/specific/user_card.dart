import 'package:flutter/material.dart';
import 'package:core_kit/core_kit.dart';
import 'package:global_vin/domain/entities/user_entity.dart';

class UserCard extends StatelessWidget {
  final UserEntity user;
  final VoidCallback? onTap;

  const UserCard({
    super.key,
    required this.user,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundImage:
              user.avatarUrl != null ? NetworkImage(user.avatarUrl!) : null,
          child: user.avatarUrl == null
              ? CommonText(
                  text: user.name[0].toUpperCase(), fontWeight: FontWeight.bold)
              : null,
        ),
        title: CommonText(text: user.name, fontSize: 16.sp),
        subtitle: CommonText(text: user.email, fontSize: 12.sp),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
