import 'package:flutter/material.dart';

class Option {
  final String name;
  final String value;

  Option({required this.name, required this.value});
}

class DropdownInput extends StatefulWidget {
  final String label;
  final String hint;
  final String selectedValue;
  final List<Option> options;

  const DropdownInput({
    super.key,
    required this.label,
    required this.hint,
    required this.selectedValue,
    required this.options,
  });

  @override
  DropdownInputState createState() => DropdownInputState();
}

class DropdownInputState extends State<DropdownInput> {
  late String selectedOptionValue;

  @override
  void initState() {
    super.initState();
    selectedOptionValue = widget.selectedValue;
  }

  void _onOptionSelected(String value) {
    setState(() {
      selectedOptionValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      splashRadius: 20,
      offset: const Offset(0, 43),
      tooltip: widget.hint,
      onSelected: _onOptionSelected,
      initialValue: null,
      child: Container(
        padding: const EdgeInsets.all(11),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.blueGrey,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.filter_alt_rounded,
              color: Colors.blueGrey,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              selectedOptionValue,
              style: const TextStyle(
                color: Colors.purple,
              ),
            ),
          ],
        ),
      ),
      itemBuilder: (context) {
        return widget.options.map((option) {
          return PopupMenuItem(
            onTap: () {},
            value: option.value,
            height: MediaQuery.of(context).size.height * 0.05,
            child: Text(option.name),
          );
        }).toList();
      },
    );
  }
}
