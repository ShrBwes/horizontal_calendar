# Horizontal Calendar
 A flutter plugin to show horizontal view of calendar with date picker
 
![calendar image](screenshot.jpg)

## Installation
In the dependencies: section of your pubspec.yaml, add the following line:

<div class="highlight highlight-source-yaml"><pre>  <span class="pl-ent">pin_code_view</span>: <span class="pl-s">0.0.1</span></pre></div>
## Usage

<div class="highlight highlight-source-yaml"><pre>  <span class="pl-ent">

import 'package:horizontal_calendar/horizontal_calendar.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Horizontal Calendar Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Horizontal Calendar Demo'),
    );
  }
}

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: HorizontalCalendar(
        date: DateTime.now(),
        textColor: Colors.black45,
        backgroundColor: Colors.white,
        selectedColor: Colors.blue,
        onDateSelected: (date) => print(
          date.toString(),
        ),
      ),
    );
  }
}
</span></pre></div>
