import 'package:flutter/material.dart';

import '../../configs/app_configs.dart';

class CircleAvatarWidget extends StatelessWidget {
  const CircleAvatarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        //padding: EdgeInsets.all(24),
      ),
      onPressed: () {},
      child: const CircleAvatar(
        radius: 19,
        backgroundColor: AppColors.darkGreen,
        child: CircleAvatar(
          radius: 17,
          backgroundColor: Colors.grey,
          backgroundImage: NetworkImage(
              "https://firebasestorage.googleapis.com/v0/b/ipbc-palmas.appspot.com/o/user_avatar.png?alt=media&token=e4459485-b7ce-4aff-a147-b1c6ac0897b1"),
        ),
      ),
    );
  }
}
