import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _fetchDogImage();
  }

  _fetchDogImage() async {
    final response = await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));
    if (response.statusCode == 200) {
      setState(() {
        _imageUrl = jsonDecode(response.body)['message'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Andra Sidan')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              if (_imageUrl != null)
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.6,  // tar upp högst 60% av skärmens höjd
                  ),
                  child: Image.network(_imageUrl!, fit: BoxFit.contain),
                ),
              SizedBox(height: 16),
              Text('Välkommen till den andra sidan!'),
            ElevatedButton(
              onPressed: _fetchDogImage,
              child: Text('Hämta en annan bild'),
            ),
          ],
        ),
      ),
    ),
    );
  }
}
