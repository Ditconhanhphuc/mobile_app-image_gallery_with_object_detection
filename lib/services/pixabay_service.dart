import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pixabay_image.dart';

class PixabayService {
  final String apiKey = '49980196-4e68034c37c8b4974f0237c63'; // Đổi thành API KEY của bạn!

  Future<List<PixabayImage>> fetchImages(String query) async {
    final response = await http.get(Uri.parse(
        'https://pixabay.com/api/?key=$apiKey&q=$query&image_type=photo'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List hits = data['hits'];

      return hits.map((e) => PixabayImage.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load images');
    }
  }
}
