import 'package:flutter/material.dart';

class MemeProvider extends ChangeNotifier {
  String _memeUrl =
      'https://i.cbc.ca/1.6713656.1679693029!/fileImage/httpImage/image.jpg_gen/derivatives/16x9_780/this-is-fine.jpg';
  String _memeText = '24111';
  String get memeUrl => _memeUrl;
  String get memeText => _memeText;

  set memeUrl(String value) {
    if (_memeUrl != value) {
      _memeUrl = value;
      notifyListeners();
    }
  }

  set memeText(String value) {
    if (_memeText != value) {
      _memeText = value;
      notifyListeners();
    }
  }
}
