import 'package:accident/Presentation/Profile/Model/health_details_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomUserFitnessDetails extends StatefulWidget {
  const CustomUserFitnessDetails({Key? key}) : super(key: key);

  @override
  State<CustomUserFitnessDetails> createState() =>
      _CustomUserFitnessDetailsState();
}

class _CustomUserFitnessDetailsState extends State<CustomUserFitnessDetails> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HealthDetailsModel>(
      builder: (context, healthDetailsModel, child) {
        return Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Fitness Details",
                  style: TextStyle(
                      fontSize: 28,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
            ),
            Row(
              children: [
                const Icon(
                  Icons.height,
                  size: 30,
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${healthDetailsModel.height} ${healthDetailsModel.heightUnit}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10), // Adjust the vertical gap
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.fitness_center,
                      size: 30,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${healthDetailsModel.weight} ${healthDetailsModel.weightUnit}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 70),
              ],
            ),
            const SizedBox(height: 10), // Adjust the vertical gap
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.medical_services_sharp,
                      size: 30,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${healthDetailsModel.medicalCondition}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 70),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.emoji_events,
                      size: 30,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${healthDetailsModel.fitnessGoal}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 70),
              ],
            ),
            const SizedBox(height: 10), // Adjust the vertical gap
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.trending_up,
                      size: 30,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${healthDetailsModel.activityLevel}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 70),
              ],
            ),
            const SizedBox(height: 10), // Adjust the vertical gap
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.local_dining,
                      size: 30,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${healthDetailsModel.nutritionCondition}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 70),
              ],
            ),
            const SizedBox(height: 10), // Adjust the vertical gap
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.self_improvement,
                      size: 30,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${healthDetailsModel.fitnessExperience}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 70),
              ],
            ),
            const SizedBox(height: 10), // Adjust the vertical gap
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.park,
                      size: 30,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${healthDetailsModel.workoutLocation}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 70),
              ],
            ),
            const SizedBox(height: 10), // Adjust the vertical gap
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.directions_run, size: 30, color: Colors.black),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: (healthDetailsModel.fitnessInterest ?? [])
                      .map((interest) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        '$interest,',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
