import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:horizontal_calendar/horizontal_calendar.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en', '');

  void setLocale(Locale value) {
    print(value);
    setState(() {
      _locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Horizontal Calendar Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('en', ''),
        Locale('fr', ''),
        Locale('es', ''),
        Locale('vi', ''),
        Locale('zh', ''),
      ],
      home: MyHomePage(
        title: 'Horizontal Calendar Demo',
        onLocaleChanged: setLocale,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    this.title,
    required this.onLocaleChanged,
  }) : super(key: key);

  final String? title;
  final ValueChanged<Locale> onLocaleChanged;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
        actions: <Widget>[
          PopupMenuButton<Locale>(
            onSelected: widget.onLocaleChanged,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Locale>>[
              const PopupMenuItem<Locale>(
                value: Locale('en', ''),
                child: Text('English'),
              ),
              const PopupMenuItem<Locale>(
                value: Locale('fr', ''),
                child: Text('French'),
              ),
              const PopupMenuItem<Locale>(
                value: Locale('es', ''),
                child: Text('Spanish'),
              ),
              const PopupMenuItem<Locale>(
                value: Locale('vi', ''),
                child: Text('Vietnamese'),
              ),
              const PopupMenuItem<Locale>(
                value: Locale('zh', ''),
                child: Text('Chinese'),
              ),
            ],
          ),
        ],
      ),
      body: HorizontalCalendar(
        date: DateTime.now(),
        initialDate: DateTime.now(),
        textColor: Colors.black,
        backgroundColor: Colors.white,
        selectedColor: Colors.orange,
        showMonth: true,
        onDateSelected: (date) {
          if (kDebugMode) {
            print(date.toString());
          }
        },
      ),
    );
  }
}
