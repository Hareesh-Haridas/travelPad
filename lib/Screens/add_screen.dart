import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:travel_pad/Models/trip_plan_model/schedule_model.dart';
import 'package:travel_pad/Screens/a.dart';
import 'package:travel_pad/Screens/scheduled_trips_screen.dart';
import 'package:travel_pad/db/db_functions/db_functions.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

ValueNotifier<List<ScheduledTrip>> scheduledtrips =
    ValueNotifier(<ScheduledTrip>[]);

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

List<Contact> contacts = [];
getIds(List<String> listofcontactsId) {
  List<Contact> result = [];
  contacts.map((element) {
    if (listofcontactsId.contains(element.identifier)) {
      result.add(element);
    }
  });
  return result;
}

class _AddScreenState extends State<AddScreen> {
  final DateFormat dateFormat = DateFormat('dd-MM-yyyy');

  final Set<DateTime> _selectedDates = {};

  final String _selectedItem = 'Manali';

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  List<DateTime> selectedDates = [];

  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  TextEditingController destinationController = TextEditingController();
  a() async {
    contacts = await ContactHelper.getContacts();
  }

  @override
  void initState() {
    a();
    super.initState();
  }

  Contact contact = Contact();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Plan your trip',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
        ),
        backgroundColor: Colors.teal.shade700,
        toolbarHeight: 75,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Form(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 8),
                      child: TextField(
                        controller: destinationController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter your destination',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        List<Contact> contacts =
                            await ContactHelper.getContacts();
                        await showDialog(
                          context: context,
                          builder: (context) =>
                              ContactSelectionDialog(contacts: contacts),
                        );
                      },
                      child: const Text('Add companion from contacts'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Selected contacts',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      // itemCount: selectedContactIds.length,
                      itemCount: selectedContacts.length,
                      itemBuilder: (BuildContext context, int index) {
                        final contact = selectedContacts[index];
                        return ListTile(
                          title:
                              //  Text(selectedContacts[index].displayName ?? ''),
                              Text(contact.displayName ?? ''),
                        );
                      },
                    ),
                    const Text(
                      'Schedule your trip',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TableCalendar(
                      focusedDay: _focusedDay,
                      calendarFormat: _calendarFormat,
                      onFormatChanged: ((format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      }),
                      firstDay: DateTime.utc(2023, 1, 1),
                      lastDay: DateTime.utc(2023, 12, 31),
                      onPageChanged: ((focusedDay) {
                        _focusedDay = focusedDay;
                      }),
                      selectedDayPredicate: ((day) {
                        return _selectedDates.contains(day);
                      }),
                      rowHeight: 40,
                      onDaySelected: ((selectedDay, focusedDay) {
                        setState(() {
                          if (selectedStartDate == null ||
                              selectedDay.isBefore(selectedStartDate!)) {
                            selectedStartDate = selectedDay;
                            selectedEndDate = null;
                          } else if (selectedEndDate == null ||
                              selectedDay.isAfter(selectedEndDate!)) {
                            selectedEndDate = selectedDay;
                          }
                        });
                      }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Start Date: ${selectedStartDate != null ? dateFormat.format(selectedStartDate!) : 'None'}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      'End Date: ${selectedEndDate != null ? dateFormat.format(selectedEndDate!) : 'None'}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (selectedStartDate != null &&
                                _selectedItem.isNotEmpty) {
                              final newTrip = ScheduledTrip(
                                destination: destinationController.text,
                                date: _focusedDay,
                                selectedcontacts: selectedContacts
                                    .map((Contact) => Contact.displayName ?? '')
                                    .toList(),
                              );

                              addTrip(newTrip);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ScheduledTripsScreen(
                                    selectedDestination:
                                        destinationController.text,
                                    selectedContacts: selectedContacts
                                        .map((Contact) =>
                                            Contact.displayName ?? '')
                                        .toList(),
                                    selectedStartDate: selectedStartDate,
                                  ),
                                ),
                              );
                              setState(
                                () {
                                  scheduledtrips.value.add(newTrip);
                                },
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Error'),
                                    content: const Text(
                                        'Please select a destination and a start date.'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: const Text('Schedule selected dates'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContactHelper {
  static Future<List<Contact>> getContacts() async {
    if (await Permission.contacts.request().isGranted) {
      return await ContactsService.getContacts();
    } else {
      return [];
    }
  }
}
