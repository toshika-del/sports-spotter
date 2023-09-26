import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sports_spotter/constants.dart';
import 'package:sports_spotter/models/event.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final DateTime _lastDate = DateTime.now();
  final DateTime _eventDate = DateTime.now();
  final title = TextEditingController();
  final description = TextEditingController();
  final imageUrl = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'New Event',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        space8,
        TextField(
          onChanged: (value) {
            setState(() {
              _isButtonEnabled = value.isNotEmpty &&
                  description.text.isNotEmpty &&
                  imageUrl.text.isNotEmpty;
            });
          },
          controller: title,
          decoration: const InputDecoration(
              hintText: 'Football event',
              labelText: 'Event title',
              prefixIcon: Icon(FontAwesomeIcons.futbol)),
        ),
        space8,
        TextField(
          onChanged: (value) {
            setState(() {
              _isButtonEnabled = value.isNotEmpty &&
                  title.text.isNotEmpty &&
                  imageUrl.text.isNotEmpty;
            });
          },
          controller: description,
          minLines: 4,
          maxLines: 4,
          decoration: const InputDecoration(hintText: 'Event description'),
        ),
        space16,
        InputDatePickerFormField(
          initialDate: _eventDate,
          fieldLabelText: 'Event date',
          keyboardType: TextInputType.datetime,
          firstDate: DateTime(2023),
          lastDate: DateTime(2030),
        ),
        space16,
        InputDatePickerFormField(
          initialDate: _lastDate,
          keyboardType: TextInputType.datetime,
          fieldLabelText: 'Last date',
          firstDate: DateTime.now(),
          lastDate: DateTime(2030),
        ),
        space16,
        TextField(
            onChanged: (value) {
              setState(() {
                _isButtonEnabled = value.isNotEmpty &&
                    description.text.isNotEmpty &&
                    title.text.isNotEmpty;
              });
            },
            controller: imageUrl,
            decoration: const InputDecoration(
              hintText: 'https://image-url.jpeg',
              labelText: 'Image url',
            )),
        space16,
        FilledButton(
            onPressed: (_isButtonEnabled)
                ? () {
                    if (title.text.trim().isNotEmpty ||
                        description.text.trim().isNotEmpty ||
                        imageUrl.text.trim().isNotEmpty) {
                      EventModel.createEvent(
                              title: title.text.trim(),
                              description: description.text.trim(),
                              imageUrl: imageUrl.text.toString().trim(),
                              lastDate: _lastDate.toString().substring(0, 10),
                              eventDate: _eventDate.toString().substring(0, 10))
                          .then((value) {
                        if (value == 200) {
                          Navigator.pop(context);
                          showSnackbar(context, const Text('Event created'),
                              successColor);
                        } else {
                          Navigator.pop(context);
                          showSnackbar(context,
                              const Text('Some error occured'), errorColor);
                        }
                      });
                    }
                  }
                : null,
            child: const Text('Create Event')),
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
