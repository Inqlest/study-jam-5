import 'package:flutter/material.dart';
import 'package:meme_generator/screen/meme_generator_screen.dart';
import 'package:meme_generator/provider_notifier.dart';
import 'package:provider/provider.dart';
import 'package:meme_generator/pick_image.dart';

class MemeCreateScreen extends StatefulWidget {
  const MemeCreateScreen({Key? key}) : super(key: key);

  @override
  _MemeCreateScreenState createState() => _MemeCreateScreenState();
}

class _MemeCreateScreenState extends State<MemeCreateScreen> {
  final ImagePickerService _imagePickerService = ImagePickerService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Подпись мема"),
          TextField(
            onSubmitted: (text) {
              Provider.of<MemeProvider>(context, listen: false).memeText = text;
            },
          ),
          const Text("Ссылка на картинку или выберите из галереи"),
          TextField(
            onSubmitted: (text) {
              Provider.of<MemeProvider>(context, listen: false).memeUrl = text;
            },
          ),
          InkWell(
            onTap: () {
              _imagePickerService.pickImage(context);
            },
            child: SizedBox(
              width: 200,
              height: 50,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Center(
                  child: Text("Выбрать из галереи"),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MemeGeneratorScreen()));
            },
            child: SizedBox(
              width: 125,
              height: 50,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Center(
                  child: Text("Создать мем"),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
