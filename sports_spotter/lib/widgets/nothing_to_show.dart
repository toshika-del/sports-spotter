import 'package:flutter/material.dart';

class NothingToShow extends StatelessWidget {
  final Function() refresh;
  const NothingToShow({super.key, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Image(
          image: AssetImage('assets/empty_image.png'),
          height: 200,
        ),
        const Text(
          'There is nothing to show',
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
