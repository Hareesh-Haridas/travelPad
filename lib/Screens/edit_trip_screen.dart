import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import 'package:travel_pad/Models/trip_plan_model/schedule_model.dart';
// import 'package:travel_pad/db/db_functions/db_functions.dart';

class EditTripScreen extends StatefulWidget {
  // const EditTripScreen({super.key});
  final ScheduledTrip trip;
  EditTripScreen({required this.trip});
  @override
  State<EditTripScreen> createState() => _EditTripScreenState();
}

class _EditTripScreenState extends State<EditTripScreen> {
  late String editedDestination;
  late List<String> editedContacts;
  late DateTime editedStartDate;
  TextEditingController dateController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  TextEditingController companionsController = TextEditingController();
  @override
  void initState() {
    super.initState();
    editedDestination = widget.trip.destination;
    editedContacts = List.from(widget.trip.selectedcontacts);
    editedStartDate = widget.trip.date;
    dateController.text = formatDate(editedStartDate);
    destinationController.text = editedDestination;
    companionsController.text = editedContacts.join(', ');
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: editedStartDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != editedStartDate) {
      setState(() {
        editedStartDate = picked;
        dateController.text = formatDate(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit trip details'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Destination'),
                onChanged: (value) {
                  setState(
                    () {
                      editedDestination = value;
                    },
                  );
                },
                controller: destinationController,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Companion'),
                onChanged: (value) {
                  setState(() {
                    editedContacts = value.split(',');
                  });
                },
                controller: companionsController,
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: IgnorePointer(
                  child: TextField(
                    controller: dateController,
                    decoration: const InputDecoration(
                        labelText: 'Date',
                        suffixIcon: Icon(Icons.calendar_today)),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  try {
                    final editedTrip = ScheduledTrip(
                        destination: editedDestination,
                        date: editedStartDate,
                        selectedcontacts: editedContacts);

                    Navigator.of(context).pop(editedTrip);
                  } catch (e) {
                    print('error when saving :$e');
                  }
                },
                child: const Text('Save'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

String formatDate(DateTime date) {
  final year = date.year;
  final month = date.month.toString().padLeft(2, '0');
  final day = date.day.toString().padLeft(2, '0');
  return '$year-$month-$day';
}
