import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:rshb_test/product/models/cachedImage.dart';

Future<CachedImage> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load('$path');
  final data = byteData.buffer.asUint8List();
  final image = await decodeImageFromList(data);
  final cachedImage = CachedImage(
    widthMoreHeight: image.width >= image.height,
    image: Image.memory(data, fit: image.width >= image.height ? BoxFit.fitWidth : BoxFit.cover,),
  );
  return cachedImage;
}

Future<CachedImage> getImageFileFromNetwork(String path) async {
  final response = await http.get(path);
  final fileBytes = response.bodyBytes;
  final image = await decodeImageFromList(fileBytes);
  final cachedImage = CachedImage(
    widthMoreHeight: image.width >= image.height,
    image: Image.memory(fileBytes, fit: image.width >= image.height ? BoxFit.fitWidth : BoxFit.cover,),
  );
  return cachedImage;
}

class ImageLoader  {

  Map<String, CachedImage> cachedImages;

  ImageLoader._privateConstructor();

  static final ImageLoader _instance = ImageLoader._privateConstructor();

  static ImageLoader get instance => _instance;

  static void updateCache(String url, CachedImage element) =>
    _instance.cachedImages[url] = element;
  
}
