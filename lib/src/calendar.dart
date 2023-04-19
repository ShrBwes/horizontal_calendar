/*
 * Copyright (c) 2023 Biwesh Shrestha
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */

import 'package:flutter/material.dart';
import 'package:horizontal_calendar/horizontal_calendar.dart';
import 'package:intl/intl.dart';

typedef OnDateSelected(date);

class HorizontalCalendar extends StatefulWidget {
  HorizontalCalendar({
    super.key,
    required this.date,
    DateTime? initialDate,
    DateTime? lastDate,
    this.textColor,
    this.backgroundColor,
    this.selectedColor,
    this.showMonth = false,
    required this.onDateSelected,
  })  : initialDate = DateUtils.dateOnly(initialDate ?? DateTime.now()),
        lastDate = DateUtils.dateOnly(
            lastDate ?? DateTime.now().add(Duration(days: 90))) {
    assert(
      !this.lastDate.isBefore(this.initialDate),
      'lastDate ${this.lastDate} must be on or after initialDate ${this.initialDate}.',
    );
    assert(
      !this.initialDate.isBefore(this.initialDate),
      'initialDate ${this.initialDate} must be on or after initialDate ${this.initialDate}.',
    );
    assert(
      !this.initialDate.isAfter(this.lastDate),
      'initialDate ${this.initialDate} must be on or before lastDate ${this.lastDate}.',
    );
  }

  /// The initially selected [DateTime] that the picker should display.
  final DateTime date;

  /// The earliest allowable [DateTime] that the user can select.
  final DateTime initialDate;

  /// The latest allowable [DateTime] that the user can select.
  final DateTime lastDate;

  /// The [Color] to represent unselected [DateTime] color
  final Color? textColor;

  /// The [Color] to represent calendar background color
  final Color? backgroundColor;

  /// The [Color] to represent selected [DateTime] color
  final Color? selectedColor;

  /// Condition [boolean] to show the month's name
  final bool showMonth;

  /// Called when the user selects a date in the picker.
  final OnDateSelected onDateSelected;

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<HorizontalCalendar> {
  late DateTime _startDate;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();

    selectedDate = widget.date;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 100;
    _startDate = selectedDate.subtract(Duration(days: 3));

    return Container(
      height: height * (widget.showMonth ? 12 : 10),
      color: widget.backgroundColor ?? Colors.white,
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.all(0.0),
        title: widget.showMonth
            ? Text(
                DateFormat.yMMM(Localizations.localeOf(context).toString())
                    .format(selectedDate),
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: widget.selectedColor ??
                          Theme.of(context).primaryColor,
                    ),
              )
            : Offstage(),
        subtitle: Row(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: 7,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CalendarItems(
                    index: index,
                    startDate: _startDate,
                    initialDate: widget.initialDate,
                    selectedDate: selectedDate,
                    textColor: widget.textColor ?? Colors.black45,
                    selectedColor:
                        widget.selectedColor ?? Theme.of(context).primaryColor,
                    backgroundColor: widget.backgroundColor ?? Colors.white,
                    onDatePressed: () =>
                        onDatePressed(index, widget.initialDate),
                  );
                },
              ),
            ),
            CalendarButton(
              textColor: widget.textColor ?? Colors.black45,
              backgroundColor: widget.backgroundColor ?? Colors.white,
              onCalendarPressed: () async {
                DateTime? date = await selectDate();
                if (date != null) {
                  widget.onDateSelected(date);
                  setState(() => selectedDate = date);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<DateTime?> selectDate() async {
    print('${Localizations.localeOf(context)}');
    return await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.day,
      initialDate: selectedDate,
      firstDate: widget.initialDate,
      lastDate: widget.lastDate,
      locale: Localizations.localeOf(context),
    );
  }

  void onDatePressed(int index, DateTime? initialDate) {
    DateTime date = _startDate.add(Duration(days: index));
    // int diffDays = date.difference(selectedDate).inDays;
    int checkDate = date.difference(widget.initialDate).inDays;
    if (checkDate >= 0) {
      widget.onDateSelected(date);
      setState(() {
        selectedDate = _startDate.add(Duration(days: index));
        _startDate = _startDate.add(Duration(days: index));
      });
    }
  }
}
