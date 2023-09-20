import 'package:flutter/material.dart';
import 'package:sports_spotter/api/feedback.dart';
import 'package:sports_spotter/constants.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    final title = TextEditingController();
    final description = TextEditingController();
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Feedback",
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
      body: SingleChildScrollView(
        padding: paddingAll24,
        child: Column(
          children: [
            Image.asset(
              'assets/feedback.png',
              height: 160,
            ),
            space16,
            TextField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  hintText: 'Email address', prefixIcon: Icon(Icons.email)),
            ),
            space16,
            TextField(
              controller: title,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  hintText: 'Title', prefixIcon: Icon(Icons.feedback)),
            ),
            space16,
            TextField(
              minLines: 6,
              maxLines: 6,
              controller: description,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: 'Description',
              ),
            ),
            space16,
            ElevatedButton(
                onPressed: () {
                  if (email.text.trim().isNotEmpty ||
                      title.text.trim().isNotEmpty ||
                      description.text.trim().isNotEmpty) {
                    FeedbackApi.postFeedback(title.text.trim(),
                            description.text.trim(), email.text.trim())
                        .then((value) {
                      if (value == 200) {
                        Navigator.pop(context);
                        showSnackbar(context, const Text('Feedback sent'));
                      }
                    });
                  } else {
                    showSnackbar(context, const Text('Fields cannot be empty'));
                  }
                },
                child: const Text(
                  'Send Feedback',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
