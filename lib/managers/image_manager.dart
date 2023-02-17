import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ImageManager {
  final LinearGradient _gradientColors = LinearGradient(
    colors: [Colors.yellow.shade600, Colors.red.shade700],
  );

  final Map<String, FaIcon> _authImages = {
    "email": const FaIcon(FontAwesomeIcons.solidEnvelope),
    "password": const FaIcon(FontAwesomeIcons.key),
    "fullname": const FaIcon(FontAwesomeIcons.solidUser),
    "username": const FaIcon(FontAwesomeIcons.userTag, size: 20),
  };

  final _imageSources = [
    "assets/images/table.jpg",
    "assets/images/macaron.jpg",
    "assets/images/olive.jpg",
    "assets/images/japan.jpg",
  ];

  final List<Map<String, String>> _imageTitles = [
    {
      "title": "Dining Table",
      "subtitle": "Looks delicious. It's amazing food. I like it so much"
    },
    {"title": "Macaron", "subtitle": "Pinky pinky"},
    {"title": "Olive", "subtitle": "Helthy food"},
    {"title": "Street of Youth", "subtitle": "Rainy now"},
  ];

  final List<IconData> _imageRates = [
    FontAwesomeIcons.faceSmile,
    FontAwesomeIcons.faceSmile,
    FontAwesomeIcons.faceAngry,
    FontAwesomeIcons.wineBottle,
  ];

  List<String> get imgSources => _imageSources;
  List<Map<String, String>> get imgTitles => _imageTitles;
  List<IconData> get imgFaces => _imageRates;
  Map<String, FaIcon> get icons => _authImages;
  LinearGradient get gradientColors => _gradientColors;
}

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();

  XFile? file = await imagePicker.pickImage(source: source);

  if (file != null) {
    return await file.readAsBytes();
  } else {
    return null;
  }
}

Widget getPNGImage(String fileName) {
  return Image.asset("assets/images/$fileName.png");
}

List<String> imageCategoryList = [
  "bibimbap",
  "burger",
  "chinese",
  "hotfood",
  "hothot",
  "milkshake",
  "rating",
  "rice",
  "udon",
];
