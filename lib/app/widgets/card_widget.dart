import 'package:flutter/material.dart';
import 'package:todo/core/ui/colors.dart';

class CardWidget extends StatelessWidget {
  final String? title;
  final String? description;

  const CardWidget({
    Key? key,
    this.title,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 32,
      ),
      margin: const EdgeInsets.only(
        bottom: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? 'No title added',
            style: TextStyle(
              color: appTitleColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            description ?? 'No description added',
            style: TextStyle(
              color: appBodyColor,
              fontSize: 16,
              height: 1.5,
            ),
          )
        ],
      ),
    );
  }
}
