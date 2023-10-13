import 'package:flutter/material.dart';
import 'package:travel_pad/Models/trip_plan_model/dream_destination_model.dart';

import 'package:travel_pad/db/db_functions/dream_db.dart';

class DreamDestinationScreen extends StatefulWidget {
  const DreamDestinationScreen({super.key});

  @override
  State<DreamDestinationScreen> createState() => _DreamDestinationScreenState();
}

class _DreamDestinationScreenState extends State<DreamDestinationScreen> {
  bool isAddSavingsEnabled = true;
  final String dreamDbName = 'dreamDestination';
  String selectedItem = 'Manali';
  bool destinationExists = false;
  Set<String> selectedDestinations = <String>{};
  String newDestinationName = '';
  String newExpenseAmount = '';
  double savingsAmount = 0.0;
  double expenseAmount = 0;
  @override
  void initState() {
    super.initState();
    getAllDream();
  }

  @override
  Widget build(BuildContext context) {
    getAllDream();
    // setState(() {
    //   expenseAmount = getExpenseForDestination(selectedItem);
    // });
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Dream destinations',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
          ),
          backgroundColor: Colors.teal.shade700,
          toolbarHeight: 75,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Add your dream destination',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            newDestinationName = value;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'New destination',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            newExpenseAmount = value;
                          });
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Total expense',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal.shade700),
                        onPressed: () {
                          addNewDestination();
                        },
                        child: const Icon(Icons.add))
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ValueListenableBuilder(
                valueListenable: DreamDestinationNotifier,
                builder: (context, value, _) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (BuildContext context, int index) {
                        final dream = value[index];
                        final percentage =
                            (dream.savings / dream.expense) * 100;
                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      ' ${value[index].place}',
                                      style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        // deleteDream(value[index]);
                                        // selectedDestinations
                                        //     .remove(value[index].place);
                                        showDeleteConfirmationDialog(
                                            value[index]);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: 200,
                                  child: LinearProgressIndicator(
                                    value: (value[index].savings /
                                            value[index].expense)
                                        .toDouble(),
                                  ),
                                ),
                                Text(
                                  '${percentage.clamp(0, 100).toStringAsFixed(0)}%',
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Total added savings: \u{20B9}${value[index].savings}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total expense: \u{20B9}${value[index].expense}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showEditExpenseDialog(
                                            index, value[index]);
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.teal.shade700),
                                  onPressed: () {
                                    showAddExpenseDialog(index, value[index]);
                                  },
                                  child: const Text(
                                    'Add savings',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showAddExpenseDialog(int index, DreamDestination dreams) {
    double updatedSavingsAmount = 0.0;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add savings amount'),
          content: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                updatedSavingsAmount = double.tryParse(value) ?? 0;
              });
            },
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  final dream = DreamDestination(
                      place: dreams.place,
                      savings: dreams.savings + updatedSavingsAmount,
                      expense: dreams.expense.toInt());
                  updateDream(index, dream);
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Done',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ))
          ],
        );
      },
    );
  }

  bool isDestinationExists(String destination) {
    final lowercaseDestination = destination;
    return selectedDestinations.contains(lowercaseDestination);
  }

  void showDestinationExistsAlert(String destination) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Destination exists.'),
          content: const Text('You have already selected this destination.'),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'))
          ],
        );
      },
    );
  }

  void showDeleteConfirmationDialog(DreamDestination destination) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm deletion'),
          content:
              Text('Are you sure you want to delete ${destination.place}?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
                onPressed: () {
                  deleteDream(destination);
                  selectedDestinations.remove(destination.place);
                  Navigator.of(context).pop();
                },
                child: const Text('Delete'))
          ],
        );
      },
    );
  }

  void showEditExpenseDialog(int index, DreamDestination destination) {
    double updatedExpenseAmount = destination.expense.toDouble();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Edit expense'),
            content: TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  updatedExpenseAmount = double.tryParse(value) ?? 0;
                });
              },
              controller: TextEditingController(
                  text: updatedExpenseAmount.toStringAsFixed(2)),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  final updatedDream = DreamDestination(
                    place: destination.place,
                    savings: destination.savings,
                    expense: updatedExpenseAmount.toInt(),
                  );
                  updateDream(index, updatedDream);
                  Navigator.of(context).pop();
                },
                child: const Text('Save'),
              )
            ],
          );
        });
  }

  void addNewDestination() {
    if (newDestinationName.isNotEmpty && newExpenseAmount.isNotEmpty) {
      final newDestination = newDestinationName.trim();
      final expense = double.tryParse(newExpenseAmount) ?? 0.0;

      if (!isDestinationExists(newDestination)) {
        final dream = DreamDestination(
          place: newDestination,
          savings: 0.0,
          expense: expense.toInt(),
        );
        addDream(dream);
        setState(() {
          newDestinationName = '';
          newExpenseAmount = '';
        });
      } else {
        showDestinationExistsAlert(newDestination);
      }
    }
  }
}
