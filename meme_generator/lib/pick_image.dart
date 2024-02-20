import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:meme_generator/provider_notifier.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(BuildContext context) async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
      status = await Permission.storage.status;
    }

    if (status.isGranted) {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        Provider.of<MemeProvider>(context, listen: false).memeUrl = image.path;
      }
    } else {
      showGalleryAccessDialog(context);
    }
  }
}

void showGalleryAccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Не удалось получить доступ к галерее'),
      content: const Text(
          'Вы можете предоставить разрешение в настройках приложения.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
