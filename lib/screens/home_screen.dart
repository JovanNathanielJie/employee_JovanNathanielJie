import 'package:flutter/material.dart';
import 'package:employee/services/employee_service.dart';
import 'add_employee_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final EmployeeService _employeeService = EmployeeService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('List Employee')),
      body: StreamBuilder<Map<String, dynamic>>(
        stream: _employeeService.getEmployeeList(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            Map<String, dynamic> items = snapshot.data!;
            if(items.isEmpty) {
              return const Center(child: Text('Tidak ada karyawan'));
            }
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final key = items.keys.elementAt(index);
                final data = items[key];
                return ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(data['nama'] ?? 'Tidak ada'),
                  subtitle: Text(data['jabatan'] ?? 'Tidak ada'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _employeeService.removeEmployee(key),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEmployeeScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
