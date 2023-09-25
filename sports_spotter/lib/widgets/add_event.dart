import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sports_spotter/constants.dart';

class AddEvent extends StatelessWidget {
  const AddEvent({super.key});

  @override
  Widget build(BuildContext context) {
    final title = TextEditingController();
    return Column(
      children: [
        const Text(
          'New Event',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        space8,
        TextField(
          controller: title,
          decoration: const InputDecoration(
              hintText: 'Football event',
              labelText: 'Event title',
              prefixIcon: Icon(FontAwesomeIcons.futbol)),
        ),
        space8,
        TextField(
          controller: title,
          minLines: 4,
          maxLines: 4,
          decoration: const InputDecoration(hintText: 'Event description'),
        ),
        space16,
        InputDatePickerFormField(
          fieldLabelText: 'Event date',
          keyboardType: TextInputType.datetime,
          firstDate: DateTime(2023),
          lastDate: DateTime(2030),
        ),
        space16,
        InputDatePickerFormField(
          keyboardType: TextInputType.datetime,
          fieldLabelText: 'Last date',
          firstDate: DateTime.now(),
          lastDate: DateTime(2030),
        ),
        space16,
        FilledButton(onPressed: () {}, child: const Text('Create Event')),
        space8,
        FilledButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(errorColor)),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
