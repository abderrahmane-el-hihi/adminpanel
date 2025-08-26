import 'package:flutter/material.dart';

class AvatarGroup extends StatelessWidget {
  final List<String> avatarUrls;
  final double size;
  final double overlap;

  const AvatarGroup({
    super.key,
    required this.avatarUrls,
    this.size = 24,
    this.overlap = 8,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: avatarUrls.length * size - (avatarUrls.length - 1) * overlap,
      height: size,
      child: Stack(
        children: [
          for (int i = 0; i < avatarUrls.length; i++)
            Positioned(
              left: i * (size - overlap),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
                child: CircleAvatar(
                  radius: size / 2 - 1.5,
                  backgroundImage: NetworkImage(avatarUrls[i]),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
