import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardScreen extends StatelessWidget {
  final String userEmail;
  const DashboardScreen({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search functionality
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              // TODO: Implement filter functionality
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'Filter by Hobby',
                  child: Text('Filter by Hobby'),
                ),
                PopupMenuItem(
                  value: 'Sort by Name',
                  child: Text('Sort by Name'),
                ),
              ];
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('students').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No students found.'));
          }

          final students = snapshot.data!.docs;

          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    student['photoUrl'] ?? 'https://via.placeholder.com/150',
                  ),
                ),
                title: Text(student['name'] ?? '-'),
                subtitle: Text('NIM: ${student['nim'] ?? '-'}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(
                        photoUrl: student['photoUrl'] ?? '',
                        name: student['name'] ?? '',
                        nim: student['nim'] ?? '',
                        birthDate: student['birthDate'] ?? '',
                        hobby: student['hobby'] ?? '',
                        phoneNumber: student['phone'] ?? '',
                        address: student['address'] ?? '',
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String photoUrl;
  final String name;
  final String nim;
  final String birthDate;
  final String hobby;
  final String phoneNumber;
  final String address;

  const DetailScreen({
    super.key,
    required this.photoUrl,
    required this.name,
    required this.nim,
    required this.birthDate,
    required this.hobby,
    required this.phoneNumber,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(photoUrl),
            ),
            SizedBox(height: 16),
            Text('Name: $name', style: TextStyle(fontSize: 18)),
            Text('NIM: $nim'),
            Text('Birth Date: $birthDate'),
            Text('Hobby: $hobby'),
            Text('Phone: $phoneNumber'),
            Text('Address: $address'),
          ],
        ),
      ),
    );
  }
}

class AddEditScreen extends StatelessWidget {
  const AddEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add / Edit')),
      body: Center(child: Text('Add / Edit Screen Placeholder')),
    );
  }
}
