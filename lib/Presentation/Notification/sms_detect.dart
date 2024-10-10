// import 'package:flutter/material.dart';
// import 'package:sms_v2/sms.dart';

// class SendSmsPage extends StatelessWidget {
//   final TextEditingController _phoneNumberController = TextEditingController();
//   final TextEditingController _messageController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Send SMS'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: <Widget>[
//             TextField(
//               controller: _phoneNumberController,
//               decoration: InputDecoration(labelText: 'Phone Number'),
//               keyboardType: TextInputType.phone,
//             ),
//             TextField(
//               controller: _messageController,
//               decoration: InputDecoration(labelText: 'Message'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 _sendSMS(_phoneNumberController.text, _messageController.text);
//               },
//               child: Text('Send SMS'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _sendSMS(String phoneNumber, String message) async {
//     try {
//       SmsSender sender = new SmsSender();
//       SmsMessage smsMessage =
//           new SmsMessage(address: phoneNumber, body: message, id: 1);
//       await sender.sendSms(smsMessage);
//       print('SMS sent successfully to $phoneNumber');
//     } catch (e) {
//       print('Error sending SMS: $e');
//       // Handle error as needed
//     }
//   }
// }
