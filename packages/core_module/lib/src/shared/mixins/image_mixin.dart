import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../core_module.dart';

mixin ImageMixin {
  Future<Either<File?,void >> getGalleryImage(BuildContext context) async {
    final int maxSizeInBytes = 1 * 1024 * 1024; // 4MB em bytes
    File? imageFile;
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      int fileSize = await imageFile.length();

      if (fileSize > maxSizeInBytes) {
        if (context.mounted) {
          showCustomMessageDialog(
            type: DialogType.error,
            context: context,
            title: 'Erro',
            duration: const Duration(milliseconds: 2000),
            message:
            'A imagem deve ter no máximo 4MB.',
          );
        }

        return Right(null);
      }
    }
    return Left(imageFile);
  }
}