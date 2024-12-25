const String baseUrl = 'http://192.168.1.21:8086/api';

final regexemail = RegExp(r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$');
final regexpassword =
    RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]{8,}$');
