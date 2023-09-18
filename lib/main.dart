import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secret Data',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'FFC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  static const counterKey = "counter";

  @override
  void initState() {
    _initCounter();
    super.initState();
  }

  Future _initCounter() async {
    _counter = await _getCounter();
    setState(() {});
  }

  void _incrementCounter() async {
    setState(() {
      _counter++;
    });
    _setCounter();
  }

  void _clearCounter() async {
    setState(() {
      _counter = 0;
    });
    _destroyCounter();
  }

  Future _destroyCounter() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(counterKey);
  }

  Future _setCounter() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.setInt(counterKey, _counter);
  }

  Future<int> _getCounter() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getInt(counterKey) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
                "Распространите этот пароль от \nадминки компов в аудитории яндекс лицея! "),
            const Text("Пароль: programmist67 \n"),
            const Text(
              'Пока вы это распростроняете, меня убили уже:',
            ),
            Text(
              '$_counter раз',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _clearCounter,
            tooltip: "Clear",
            child: const Icon(Icons.clear),
          ),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
