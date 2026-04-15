import 'package:flutter/material.dart';
import 'package:employee/services/employee_service.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({Key? key}) : super(key : key);

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _jabatanController = TextEditingController();
  final EmployeeService _employeeService = EmployeeService();

  @override
  void dispose() {
    _namaController.dispose();
    _jabatanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Employee')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _namaController,
              decoration: const InputDecoration(labelText: 'Nama', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16,),
            TextField(
              controller: _jabatanController,
              decoration: const InputDecoration(labelText: 'Jabatan', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16,),
            ElevatedButton(
              onPressed: () {
                final nama = _namaController.text.trim();
                final jabatan = _jabatanController.text.trim();

                if(nama.isNotEmpty && jabatan.isNotEmpty) {
                  _employeeService.addEmployee(nama, jabatan);
                  Navigator.pop(context);
                }
              },
              child: const SizedBox(
                width: double.infinity,
                child: Center(child: Text('Tambah')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
