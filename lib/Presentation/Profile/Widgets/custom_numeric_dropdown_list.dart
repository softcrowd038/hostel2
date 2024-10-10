import 'package:flutter/material.dart';

class CustomNumericDropDownList extends StatefulWidget {
  final List<String> units;
  final String label, hint;
  final TextEditingController numController;
  final String? selectedUnit;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String?)? onChangedMeasureUnit;

  const CustomNumericDropDownList(
      {Key? key,
      required this.units,
      required this.hint,
      required this.label,
      required this.numController,
      required this.selectedUnit,
      required this.validator,
      required this.onChanged,
      required this.onChangedMeasureUnit})
      : super(key: key);

  @override
  State<CustomNumericDropDownList> createState() =>
      _CustomNumericDropDownListState();
}

class _CustomNumericDropDownListState extends State<CustomNumericDropDownList> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
              controller: widget.numController,
              keyboardType: TextInputType.text,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: widget.label,
                labelStyle:
                    const TextStyle(color: Color.fromARGB(255, 248, 211, 2)),
                hintText: widget.hint,
                hintStyle: const TextStyle(color: Colors.grey),
              ),
              validator: widget.validator, // Apply the validator here
              onChanged: widget.onChanged),
        ),
        const SizedBox(width: 10),
        DropdownButton<String>(
          value: widget.selectedUnit,
          dropdownColor: Colors.black,
          style: const TextStyle(color: Colors.white),
          onChanged: widget.onChangedMeasureUnit,
          items: widget.units.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}
