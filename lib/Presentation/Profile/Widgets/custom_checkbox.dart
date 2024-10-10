import 'package:flutter/material.dart';

class CustomCheckBoxes extends StatefulWidget {
  final List<String> fields;
  final String title;
  final Color? textColor;
  final Color? checkboxColor;
  final void Function(List<String>)? onChanged;

  const CustomCheckBoxes({
    Key? key,
    required this.fields,
    required this.title,
    this.textColor,
    this.checkboxColor,
    required this.onChanged,
  }) : super(key: key);

  @override
  CustomCheckBoxesState createState() => CustomCheckBoxesState();
}

class CustomCheckBoxesState extends State<CustomCheckBoxes> {
  late List<bool> fieldChecked;

  @override
  void initState() {
    super.initState();
    // Initialize all checkboxes as unchecked
    fieldChecked = List<bool>.filled(widget.fields.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.title,
            style: TextStyle(
              color: widget.textColor ?? const Color.fromARGB(255, 248, 223, 0),
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
          ),
          // Generate CheckboxListTile widgets for each field
          ...List.generate(
            widget.fields.length,
            (index) => CheckboxListTile(
              title: Text(
                widget.fields[index],
                style: TextStyle(color: widget.textColor ?? Colors.white),
              ),
              value: fieldChecked[index],
              onChanged: (value) {
                setState(() {
                  fieldChecked[index] = value!;
                  // Pass selected fields back to the onChanged callback
                  List<String> selectedFields = [];
                  for (int i = 0; i < fieldChecked.length; i++) {
                    if (fieldChecked[i]) {
                      selectedFields.add(widget.fields[i]);
                    }
                  }
                  if (widget.onChanged != null) {
                    widget.onChanged!(selectedFields);
                  }
                });
              },
              activeColor: widget.checkboxColor,
            ),
          ),
        ],
      ),
    );
  }
}
