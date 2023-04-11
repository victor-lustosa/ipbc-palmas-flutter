import 'package:flutter/material.dart';
import '../../../shared/configs/app_configs.dart';

class AlbumCoverWidget extends StatelessWidget {
  const AlbumCoverWidget({Key? key, required this.albumCover, required this.width, required this.height}) : super(key: key);
 final String albumCover;
 final double width;
 final double height;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        child: albumCover.contains("assets")
            ? SizedBox(
          width: width,
          height: height,
          child: Image.asset(albumCover))
            : Image.network(
          fit: BoxFit.cover,
          frameBuilder: (BuildContext context, Widget child,
              int? frame, bool wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded) {
              return child;
            }
            return Container(
              color: AppColors.lightGrey,
              width: width,
              height: height,
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Container(
              color: AppColors.lightGrey,
              width: width,
              height: height,
            );
          },
          albumCover,
        ),
      ),
    );
  }
}
