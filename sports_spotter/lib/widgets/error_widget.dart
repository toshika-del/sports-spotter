import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final Function() refresh;
  const ErrorMessage({super.key, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Image(
          image: AssetImage('assets/error_image.png'),
          height: 200,
        ),
        const Text(
          'Some error occured',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        TextButton(
            onPressed: refresh,
            child: const Text(
              'Refresh',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}
