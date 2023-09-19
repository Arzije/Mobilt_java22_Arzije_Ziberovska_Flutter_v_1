import 'package:flutter/material.dart';
import 'second_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uppgift 4',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
      ),
      home: const MyHomePage(title: 'Min första Flutter app'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _controller.text = prefs.getString('text_key') ?? '';
    });
  }

  _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('text_key', _controller.text);
  }

  _clearData() {
    setState(() {
      _controller.clear();
    });
    _saveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _mainContent(),
        ),
      ),
    );
  }

  List<Widget> _mainContent() {
    return [
      TextFormField(
        controller: _controller,
        decoration: InputDecoration(labelText: 'Skriv något här...'),
        onChanged: (value) {
          _saveData();
        },
      ),
      SizedBox(height: 16),
      Row(
        children: [
          ElevatedButton(
            onPressed: () =>
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SecondPage())),
            child: Text('Navigera till andra sidan'),
          ),
          SizedBox(width: 16),
          TextButton(
            onPressed: _clearData,
            child: Text('Rensa text'),
          ),
        ],
      ),
      SizedBox(height: 16),
    ];
  }
}
