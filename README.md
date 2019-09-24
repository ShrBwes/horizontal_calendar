# Horizontal Calendar
A flutter plugin to show horizontal view of calendar with date picker
 
![calendar image](screenshot.jpg)

## Installation
In the dependencies: section of your pubspec.yaml, add the following line:

```yaml
horizontal_calendar:0.0.1
```

## Usage

```dart
import 'package:horizontal_calendar/horizontal_calendar.dart';

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
```

## Example

```
View the Flutter app in the example directory in the repository.
```