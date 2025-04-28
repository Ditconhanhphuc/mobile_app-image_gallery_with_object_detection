import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';

class ImageProcessor {
  final ObjectDetector _objectDetector = ObjectDetector(
    options: ObjectDetectorOptions(
      classifyObjects: true,
      multipleObjects: true,
      mode: DetectionMode.single,
    ),
  );

  Future<List<DetectedObject>> detectObjects(ui.Image image) async {
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final bytes = byteData!.buffer.asUint8List();

    final inputImage = InputImage.fromBytes(
      bytes: bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: InputImageRotation.rotation0deg,
        format: InputImageFormat.bgra8888,
        bytesPerRow: image.width * 4,
      ),
    );

    return await _objectDetector.processImage(inputImage);
  }

  void dispose() {
    _objectDetector.close();
  }
}
