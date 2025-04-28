import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/pixabay_image.dart';
import 'services/pixabay_service.dart';
import 'image_processor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pixabay Image Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SearchScreen(),
    );
  }
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  List<PixabayImage> _images = [];
  bool _isLoading = false;

  final PixabayService _pixabayService = PixabayService();
  final ImageProcessor _imageProcessor = ImageProcessor();

  // Hàm tìm kiếm hình ảnh từ Pixabay
  Future<void> _searchImages(String query) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final images = await _pixabayService.fetchImages(query);
      setState(() {
        _images = images;
      });
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _processImage(ui.Image image) async {
    final detectedObjects = await _imageProcessor.detectObjects(image);
    print('Detected Objects: ${detectedObjects.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const ui.Color.fromARGB(255, 27, 140, 128),  
        title: Text(
          'Pixabay Image Search',
          style: TextStyle(color: Colors.white), 
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Search for objects (e.g. cat, dog)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 18),
            ElevatedButton(
              onPressed: () {
                _searchImages(_controller.text);
              },
              child: Text('Search', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: _images.length,
                      itemBuilder: (context, index) {
                        final image = _images[index];
                        return GestureDetector(
                          onTap: () async {
                            // Tải ảnh và chuyển đổi thành ui.Image
                            final imageUrl = image.imageUrl;
                            final response = await http.get(Uri.parse(imageUrl));
                            final bytes = response.bodyBytes;
                            final imageToProcess = await decodeImageFromList(bytes);

                            // Xử lý ảnh khi người dùng chọn
                            await _processImage(imageToProcess);
                          },
                          child: Image.network(image.imageUrl),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
