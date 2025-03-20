import 'package:image_picker/image_picker.dart';
import 'dart:io';

mixin ImageMixin {
  Future<File?> getGalleryImage() async {
    final int maxSizeInBytes = 4 * 1024 * 1024; // 4MB em bytes
    File? imageFile;
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      int fileSize = await imageFile.length();

      if (fileSize > maxSizeInBytes) {
        throw Exception("A imagem deve ter no máximo 4MB.");
      }
    }
    return imageFile;
  }
}