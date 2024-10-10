import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:accident/Presentation/Accident_Detection/services/accident_firebase_details.dart';
import 'package:accident/Presentation/dashboard/components/seconadary_components/icon_widget.dart';

class AccidentListWidget extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const AccidentListWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('accidents').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Accident> accidents = snapshot.data!.docs
            .map((doc) => Accident.fromFirestore(doc))
            .toList();

        return GestureDetector(
          onTap: () => {},
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 245, 199, 130)),
            child: ListView.builder(
              itemCount: accidents.length,
              itemBuilder: (context, index) {
                Accident accident = accidents[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.date_range,
                                  size: 20,
                                  color: Color.fromARGB(255, 219, 65, 247),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    accident.date,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      color: Color.fromARGB(255, 94, 94, 94),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    accident.time,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      color: Color.fromARGB(255, 94, 94, 94),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                _showDeleteConfirmationDialog(
                                    context, accident);
                              },
                              child: const Icon(
                                Icons.delete,
                                size: 25,
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          children: [
                            const IconWidget(
                              icon: Icons.location_history,
                              color: Color.fromARGB(255, 255, 230, 0),
                              size: 20,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  accident.location,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, Accident accident) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text("Are you sure you want to delete this accident?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text("Delete"),
              onPressed: () async {
                try {
                  await Accident.deleteAccident(accident.id);
                  // ignore: use_build_context_synchronously
                  Navigator.of(dialogContext).pop(); // Close the dialog
                } catch (e) {
                  // Handle error if needed
                  // ignore: avoid_print
                  print('Error deleting accident: $e');
                }
              },
            ),
          ],
        );
      },
    );
  }
}
