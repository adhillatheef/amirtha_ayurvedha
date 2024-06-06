import 'package:flutter/material.dart';

class PaymentOptionsRow extends StatefulWidget {
  final List<String> options;
  final ValueChanged<String>? onChanged;
  final String? selectedOption;

  const PaymentOptionsRow({super.key,
    required this.options,
    this.onChanged,
    this.selectedOption,
  });

  @override
  _PaymentOptionsRowState createState() => _PaymentOptionsRowState();
}

class _PaymentOptionsRowState extends State<PaymentOptionsRow> {
  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.selectedOption;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(widget.options.length, (index) {
        return Row(
          children: [
            Radio<String>(
              value: widget.options[index],
              groupValue: _selectedOption,
              onChanged: (String? value) {
                setState(() {
                  _selectedOption = value;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(value!);
                }
              },
            ),
            Text(widget.options[index]),
          ],
        );
      }),
    );
  }
}
