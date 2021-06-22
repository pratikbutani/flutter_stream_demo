import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  // Declaring Stream Controller
  StreamController<int> _controller = new StreamController();

  // Optional to use for now
  late Stream _stream; // We are using here just for an example of listen.

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // It is commented because used to create example of listen...
    // we will use controller of stream directly in Stream Builder.

    // _stream = _controller.stream;
    // _stream.listen((event) {
    //   print(event);
    // });

    // adding default value of _counter in controller so we can avoid to display null.
    _controller.add(_counter);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //Closing Stream
    _controller.close();
  }

  void _incrementCounter() {
    _counter++; // Operation
    _controller.add(
        _counter); // Adding new value to controller that will be listen by stream at StreamBuilder.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            // Added StreamBuilder to get stream and build widget based on that stream.
            StreamBuilder(
              stream: _controller.stream,
              // If we are declaring stream object then we can directly pass it here.
              builder: (BuildContext context, snapshot) {
                return new Text(
                  snapshot.data.toString(),
                  // Here we will get data from snapshot.
                  style: Theme.of(context).textTheme.display1,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
