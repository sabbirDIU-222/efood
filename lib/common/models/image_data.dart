import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this to access rootBundle

class ImageData {
  final String imagePath;
  final String title;

  ImageData({
    required this.imagePath,
    required this.title,
  });

  /*factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      imagePath: json['imagePath'] ?? '',
      title: json['title'] ?? '',
    );
  }*/
}

/*Future<List<ImageData>> loadImageData() async {
  try {
    String data = await rootBundle.loadString('assets/imagejson/');
    List<dynamic> jsonData = json.decode(data);
    List<ImageData> imageDataList = jsonData.map((item) => ImageData.fromJson(item)).toList();
    return imageDataList;
  } catch (e) {
    print('Error loading data: $e');
    throw Exception('Failed to load image data');
  }
}*/

