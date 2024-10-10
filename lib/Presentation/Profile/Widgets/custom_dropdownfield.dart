import 'package:flutter/material.dart';

class CustomDropDownList extends StatefulWidget {
  final List<String> items;
  final String label, hint;
  final String? selectedValue;
  final int maxMenuItems;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;

  const CustomDropDownList(
      {Key? key,
      required this.items,
      required this.hint,
      required this.label,
      required this.selectedValue,
      this.maxMenuItems = 5,
      required this.onChanged, // Default maximum number of items
      required this.validator})
      : super(key: key);

  @override
  State<CustomDropDownList> createState() => _CustomDropDownListState();
}

class _CustomDropDownListState extends State<CustomDropDownList> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: const TextStyle(color: Colors.white),
        hintText: widget.hint,
        hintStyle: const TextStyle(color: Colors.grey),
      ),
      dropdownColor: Colors.black,
      style: const TextStyle(
        color: Colors.white,
      ),
      value: widget.selectedValue,
      onChanged: widget.onChanged,
      items: widget.items
          .take(widget.maxMenuItems) // Take only the maximum number of items
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      validator: widget.validator,
    );
  }
}
