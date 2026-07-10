import 'package:flutter/material.dart';

class ShowMoreText extends StatefulWidget {
  final String text;
  final int maxLength;

  const ShowMoreText({super.key, required this.text, required this.maxLength});

  @override
  // ignore: library_private_types_in_public_api
  _ShowMoreTextState createState() => _ShowMoreTextState();
}

class _ShowMoreTextState extends State<ShowMoreText> {
  bool _showMore = false;

  @override
  Widget build(BuildContext context) {
    String displayText = _showMore
        ? widget.text
        : (widget.text.length > widget.maxLength
            ? "${widget.text.substring(0, widget.maxLength)}..."
            : widget.text);

    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          displayText,
          style: const TextStyle(color: Colors.black),
          textAlign: TextAlign.start,
        ),
        if (widget.text.length > widget.maxLength)
          TextButton(
            onPressed: () {
              setState(() {
                _showMore = !_showMore;
              });
            },
            child: Text(
              _showMore ? 'Show Less' : 'Show More',
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
      ],
    ));
  }
}
