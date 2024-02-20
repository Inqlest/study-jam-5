import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meme_generator/provider_notifier.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class MemeGeneratorScreen extends StatelessWidget {
  const MemeGeneratorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      border: Border.all(
        color: Colors.white,
        width: 2,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.black,
      body: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: ColoredBox(
            color: Colors.black,
            child: DecoratedBox(
              decoration: decoration,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: DecoratedBox(
                        decoration: decoration,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.network(
                            Provider.of<MemeProvider>(context, listen: false)
                                .memeUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      Provider.of<MemeProvider>(context, listen: false)
                          .memeText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Impact',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => share(context),
                      child: const Text('Поделиться'),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void share(BuildContext context) async {
  Uint8List bytes = (await NetworkAssetBundle(Uri.parse(
              Provider.of<MemeProvider>(context, listen: false).memeUrl))
          .load(Provider.of<MemeProvider>(context, listen: false).memeUrl))
      .buffer
      .asUint8List();
  final result = await ImageGallerySaver.saveImage(bytes);

  if (result['isSuccess']) {
    Share.shareFiles([result['filePath']]);
  } else {}
}
