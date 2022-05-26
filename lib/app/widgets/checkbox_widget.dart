import 'package:flutter/material.dart';
import 'package:todo/core/ui/colors.dart';

class CheckboxWidget extends StatefulWidget {
  final String? title;
  final bool finished;
  final Function(bool value) handleUpdate;

  const CheckboxWidget({
    Key? key,
    required this.finished,
    this.title,
    required this.handleUpdate,
  }) : super(key: key);

  @override
  State<CheckboxWidget> createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: [
          Checkbox(
            activeColor: appAccentColor,
            value: widget.finished,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            onChanged: (value) {
              widget.handleUpdate(value ?? false);
            },
          ),
          const SizedBox(
            width: 6,
          ),
          Expanded(
            child: Text(
              widget.title ?? 'No title added',
              style: TextStyle(
                color: widget.finished ? appTitleColor : appBodyColor,
                fontSize: 16,
                fontWeight: widget.finished ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
