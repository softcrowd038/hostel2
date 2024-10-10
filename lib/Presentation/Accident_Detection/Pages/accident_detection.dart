// import 'package:accident/Presentation/Accident_Detection/services/accident_detection_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class AccidentDetectionPage extends StatelessWidget {
//   const AccidentDetectionPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => AccidentDetectionProvider(),
//       child: Consumer<AccidentDetectionProvider>(
//         builder: (context, provider, child) {
//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   provider.isMonitoring
//                       ? 'Monitoring Active'
//                       : 'Monitoring Inactive',
//                   style: TextStyle(
//                     fontSize: 24,
//                     color: provider.isMonitoring ? Colors.green : Colors.red,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: provider.isMonitoring
//                       ? provider.stopMonitoring
//                       : provider.startMonitoring,
//                   child: Text(provider.isMonitoring
//                       ? 'Stop Monitoring'
//                       : 'Start Monitoring'),
//                 ),
//                 const SizedBox(height: 20),
//                 if (provider.isMonitoring)
//                   Column(
//                     children: [
//                       const Text(
//                         'Accelerometer Values:',
//                         style: TextStyle(fontSize: 18, color: Colors.white),
//                       ),
//                       Text(
//                         'X: ${provider.accelerometerValues[0].toStringAsFixed(2)}',
//                         style:
//                             const TextStyle(fontSize: 18, color: Colors.white),
//                       ),
//                       Text(
//                         'Y: ${provider.accelerometerValues[1].toStringAsFixed(2)}',
//                         style:
//                             const TextStyle(fontSize: 18, color: Colors.white),
//                       ),
//                       Text(
//                         'Z: ${provider.accelerometerValues[2].toStringAsFixed(2)}',
//                         style:
//                             const TextStyle(fontSize: 18, color: Colors.white),
//                       ),
//                     ],
//                   ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
