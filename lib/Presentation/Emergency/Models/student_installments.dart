import 'dart:convert';

List<StudentInstallments> studentInstallmentsFromJson(String str) =>
    List<StudentInstallments>.from(
        json.decode(str).map((x) => StudentInstallments.fromJson(x)));

String studentInstallmentsToJson(List<StudentInstallments> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentInstallments {
  final int installmentsId;
  final String registrationNumber;
  final String firstName;
  final String lastName;
  final String duePayment;
  final String installment;
  final DateTime date;
  final String installment1Due;
  final DateTime installment1Date;
  final String installment1Status;
  final String installment2Due;
  final DateTime installment2Date;
  final String installment2Status;
  final String installment3Due;
  final String installment3Date;
  final String installment3Status;
  final String totalPay;
  final String remainingPayment;
  final String installmentsStatus;
  final dynamic receivedBy;
  final dynamic payment;
  final dynamic paymentDate;
  final dynamic paymentMethod;
  final dynamic transactionId;
  final dynamic invoiceId;
  final dynamic paymentStatus;

  StudentInstallments({
    required this.installmentsId,
    required this.registrationNumber,
    required this.firstName,
    required this.lastName,
    required this.duePayment,
    required this.installment,
    required this.date,
    required this.installment1Due,
    required this.installment1Date,
    required this.installment1Status,
    required this.installment2Due,
    required this.installment2Date,
    required this.installment2Status,
    required this.installment3Due,
    required this.installment3Date,
    required this.installment3Status,
    required this.totalPay,
    required this.remainingPayment,
    required this.installmentsStatus,
    required this.receivedBy,
    required this.payment,
    required this.paymentDate,
    required this.paymentMethod,
    required this.transactionId,
    required this.invoiceId,
    required this.paymentStatus,
  });

  factory StudentInstallments.fromJson(Map<String, dynamic> json) =>
      StudentInstallments(
        installmentsId: json["installmentsId"],
        registrationNumber: json["Registration_Number"],
        firstName: json["First_Name"],
        lastName: json["Last_Name"],
        duePayment: json["Due_Payment"],
        installment: json["Installment"],
        date: DateTime.parse(json["Date"]),
        installment1Due: json["Installment1_Due"],
        installment1Date: DateTime.parse(json["Installment1_Date"]),
        installment1Status: json["Installment1_Status"],
        installment2Due: json["Installment2_Due"],
        installment2Date: DateTime.parse(json["Installment2_Date"]),
        installment2Status: json["Installment2_Status"],
        installment3Due: json["Installment3_Due"],
        installment3Date: json["Installment3_Date"],
        installment3Status: json["Installment3_Status"],
        totalPay: json["Total_Pay"],
        remainingPayment: json["Remaining_Payment"],
        installmentsStatus: json["installmentsStatus"],
        receivedBy: json["Received_by"],
        payment: json["Payment"],
        paymentDate: json["Payment_Date"],
        paymentMethod: json["Payment_Method"],
        transactionId: json["Transaction_Id"],
        invoiceId: json["Invoice_Id"],
        paymentStatus: json["paymentStatus"],
      );

  Map<String, dynamic> toJson() => {
        "installmentsId": installmentsId,
        "Registration_Number": registrationNumber,
        "First_Name": firstName,
        "Last_Name": lastName,
        "Due_Payment": duePayment,
        "Installment": installment,
        "Date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "Installment1_Due": installment1Due,
        "Installment1_Date":
            "${installment1Date.year.toString().padLeft(4, '0')}-${installment1Date.month.toString().padLeft(2, '0')}-${installment1Date.day.toString().padLeft(2, '0')}",
        "Installment1_Status": installment1Status,
        "Installment2_Due": installment2Due,
        "Installment2_Date":
            "${installment2Date.year.toString().padLeft(4, '0')}-${installment2Date.month.toString().padLeft(2, '0')}-${installment2Date.day.toString().padLeft(2, '0')}",
        "Installment2_Status": installment2Status,
        "Installment3_Due": installment3Due,
        "Installment3_Date": installment3Date,
        "Installment3_Status": installment3Status,
        "Total_Pay": totalPay,
        "Remaining_Payment": remainingPayment,
        "installmentsStatus": installmentsStatus,
        "Received_by": receivedBy,
        "Payment": payment,
        "Payment_Date": paymentDate,
        "Payment_Method": paymentMethod,
        "Transaction_Id": transactionId,
        "Invoice_Id": invoiceId,
        "paymentStatus": paymentStatus,
      };
}
