import 'package:accident/Presentation/dashboard/Utils/gyroscope_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GyroscopeWidget extends StatelessWidget {
  const GyroscopeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GyroscopeProvider>(
          create: (_) => GyroscopeProvider()..startMonitoring(),
        ),
      ],
      child: Consumer<GyroscopeProvider>(
        builder: (context, provider, _) => Column(
          children: [
            const Text(
              'Gyroscope Values:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              'X: ${provider.gyroscopeValues[0].toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
            Text(
              'Y: ${provider.gyroscopeValues[1].toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
            Text(
              'Z: ${provider.gyroscopeValues[2].toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
