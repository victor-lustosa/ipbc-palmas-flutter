import 'package:flutter/material.dart';

import '../../../design_system.dart';

class CircleAvatarWidget extends StatelessWidget {
  const CircleAvatarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      height: 32,
      child: ElevatedButtonWidget(
        backgroundColor: AppColors.darkGreen,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(2),
        action: (){},
        child: const CircleAvatar(
          radius: 16,
          backgroundColor: Colors.grey,
          backgroundImage: NetworkImage(
              "https://firebasestorage.googleapis.com/v0/b/ipbc-palmas-9d93d.appspot.com/o/profile.jpeg?alt=media&token=1e1415e3-4137-4a78-ba74-8b408784aeaa"),
        ),
      ),
    );
  }
}

