import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:fish_redux/fish_redux.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:rshb_test/home/action.dart';
import 'package:rshb_test/product/models/cachedImage.dart';

final String url = '/Users/paulik/Projects/flutterApps/rshb_test';

Future<CachedImage> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load('$path');
  print('$url/$path');
  final file = File('$url/$path');
  await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  final image = await decodeImageFromList(file.readAsBytesSync());
  print('${image.height}, ${image.width}');
  final cachedImage = CachedImage(
    widthMoreHeight: image.width >= image.height,
    image: Image.file(file, fit: image.width >= image.height ? BoxFit.fitWidth : BoxFit.fitHeight,)
  );
  return cachedImage;
}

Future<CachedImage> getImageFileFromNetwork(String path) async {
  final response = await http.get(path);
  final fileBytes = response.bodyBytes;
  final image = await decodeImageFromList(fileBytes);
  print('${image.height}, ${image.width}');
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
