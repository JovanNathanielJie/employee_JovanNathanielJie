import 'package:firebase_database/firebase_database.dart';

class EmployeeService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref().child('employee list');

  Stream<Map<String, dynamic>> getEmployeeList() {
    return _database.onValue.map((event) {
      final Map<String, dynamic> items = {};
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        Map<dynamic, dynamic> values = snapshot.value as Map <dynamic, dynamic>;
        values.forEach((key, value) {
          items[key].value;
        });
      }
      return items;
    });
  }

  void addEmployee(String nama, String jabatan) {
    _database.push().set({
      'nama' : nama,
      'jabatan' : jabatan,
    });
  }

  Future<void> removeEmployee(String key) async {
    await _database.child(key).remove();
  }
}
