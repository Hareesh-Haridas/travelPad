// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:travel_pad/Screens/edit_trip_screen.dart';
import 'package:travel_pad/db/db_functions/db_functions.dart';
import 'package:travel_pad/Models/trip_plan_model/schedule_model.dart';

class ScheduledTripsScreen extends StatefulWidget {
  final String? selectedDestination;

  final List<String>? selectedContacts;
  final DateTime? selectedStartDate;

  ScheduledTripsScreen(
      {super.key,
      this.selectedDestination,
      this.selectedStartDate,
      this.selectedContacts});

  @override
  State<ScheduledTripsScreen> createState() => _ScheduledTripsScreenState();
}

class _ScheduledTripsScreenState extends State<ScheduledTripsScreen> {
  final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  @override
  void initState() {
    super.initState();
    getAllTrips();
    openHive();
  }

  Future<void> openHive() async {
    final scheduledTripsBox =
        await Hive.openBox<ScheduledTrip>('scheduledTrip');
    final scheduledTrips = scheduledTripsBox.values.toList();
    for (int i = 0; i < scheduledTrips.length; i++) {
      expenseControllers.add(TextEditingController());
    }
  }

  List<TextEditingController> expenseControllers = [];
  void editTripDetails(ScheduledTrip trip, date) async {
    final editedTrip = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditTripScreen(trip: trip),
      ),
    );
    if (editedTrip != null) {
      editTrip(editedTrip, date);
      trip.splitAmount = calculateSplitAmount(
          trip.totalExpenseAmount, trip.selectedcontacts.length);
      await trip.save();
      getAllTrips();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Scheduled Trips',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
          ),
          backgroundColor: Colors.teal.shade700,
          toolbarHeight: 75,
        ),
        body: ValueListenableBuilder(
          valueListenable: scheduledTripListNotifier,
          builder: (context, value, _) {
            return ListView.builder(
              itemCount: value.length,
              itemBuilder: (context, index) {
                final trip = value[index];
                return Card(
                  elevation: 3,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Destination: ${value[index].destination}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                if (trip.selectedcontacts != null &&
                                    trip.selectedcontacts.isNotEmpty)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'companions:',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      for (String contactName
                                          in trip.selectedcontacts)
                                        Text(
                                          contactName,
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                    ],
                                  )
                                else
                                  const Text(
                                    'No companions',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                const SizedBox(height: 8),
                                Text(
                                  'Date: ${dateFormat.format(trip.date)}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  controller: expenseControllers[index],
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      labelText:
                                          'Enter your estimated expense'),
                                  onChanged: (value) {
                                    setState(() {
                                      trip.totalExpenseAmount =
                                          double.parse(value);
                                      trip.splitAmount = calculateSplitAmount(
                                          trip.totalExpenseAmount,
                                          trip.selectedcontacts.length);
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Splitted amount: ${trip.totalExpenseAmount == null ? ' ' : '\u{20B9}${trip.splitAmount?.toStringAsFixed(2)}'}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            editTripDetails(trip, value[index].date);
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.red,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showDeleteConfirmationDialog(trip);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void showDeleteConfirmationDialog(ScheduledTrip trip) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm deletion'),
          content: const Text('Are you sure you want to delete this trip?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                deleteTrip(trip);
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            )
          ],
        );
      },
    );
  }
}

double calculateSplitAmount(double? totalExpense, int numberOfCompanions) {
  if (totalExpense == null) {
    return 0.0;
  }
  return totalExpense / (numberOfCompanions + 1);
}
