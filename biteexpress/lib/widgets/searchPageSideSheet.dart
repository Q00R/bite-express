import 'package:flutter/material.dart';

class FilterSheetContent extends StatefulWidget {
  final RangeValues currentRangeValues;
  final RangeValues currentRatingValues;
  final void Function(RangeValues) onPriceRangeChanged;
  final void Function(RangeValues) onRatingRangeChanged;

  const FilterSheetContent({
    Key? key,
    required this.currentRangeValues,
    required this.currentRatingValues,
    required this.onPriceRangeChanged,
    required this.onRatingRangeChanged,
  }) : super(key: key);

  @override
  _FilterSheetContentState createState() => _FilterSheetContentState();
}

class _FilterSheetContentState extends State<FilterSheetContent> {
  late RangeValues _currentRangeValues;
  late RangeValues _currentRatingValues;

  @override
  void initState() {
    super.initState();
    _currentRangeValues = widget.currentRangeValues;
    _currentRatingValues = widget.currentRatingValues;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Filters',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Price Range: ${_currentRangeValues.start.round()} to ${_currentRangeValues.end.round()}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                  RangeSlider(
                    values: _currentRangeValues,
                    min: 0,
                    max: 1000,
                    onChanged: (RangeValues values) {
                      setState(() {
                        _currentRangeValues = values;
                        widget.onPriceRangeChanged(values);
                      });
                    },
                    labels: RangeLabels(
                      _currentRangeValues.start.round().toString(),
                      _currentRangeValues.end.round().toString(),
                    ),
                    divisions: 500,
                    activeColor: const Color.fromARGB(255, 255, 106, 0),
                    inactiveColor: Colors.grey,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Rating Range: ${_currentRatingValues.start.round()} to ${_currentRatingValues.end.round()}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                  RangeSlider(
                    values: _currentRatingValues,
                    min: 1,
                    max: 5,
                    onChanged: (RangeValues values) {
                      setState(() {
                        _currentRatingValues = values;
                        widget.onRatingRangeChanged(values);
                      });
                    },
                    labels: RangeLabels(
                      _currentRatingValues.start.round().toString(),
                      _currentRatingValues.end.round().toString(),
                    ),
                    divisions: 4,
                    activeColor: const Color.fromARGB(255, 255, 106, 0),
                    inactiveColor: Colors.grey,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
