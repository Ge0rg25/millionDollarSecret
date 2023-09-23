import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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
        child: SizedBox(
          width: 370,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Распространите этот пароль от админки компов в аудитории яндекс лицея!",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              InkWell(
                onTap: () async {
                  await Clipboard.setData(
                      const ClipboardData(text: "programmist67"));
                  Fluttertoast.showToast(
                      msg: "Скопировано в буфер обмена",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP_LEFT,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 20.0);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Text("Пароль: programmist67",
                      style: TextStyle(fontSize: 23, color: Colors.white)),
                ),
              ),
              const Padding(padding: EdgeInsets.all(30)),
              Text(
                'Пока вы это распростроняете, меня избили уже:',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                '$_counter раз',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
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
