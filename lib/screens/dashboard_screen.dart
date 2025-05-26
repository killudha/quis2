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
          // Filter student by email
          final students = snapshot.data!.docs
              .where((doc) => (doc['email'] ?? '') == userEmail)
              .toList();
          if (students.isEmpty) {
            return Center(child: Text('No student data for this user.'));
          }
          final student = students.first;
          return ListView(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    student['photoUrl'] ?? 'https://via.placeholder.com/150',
                  ),
                ),
                title: Text(student['name'] ?? '-'),
                subtitle: Text('NIM: ${student['nim'] ?? '-'}'),
              ),
              ListTile(
                title: Text('Address'),
                subtitle: Text(student['address'] ?? '-'),
              ),
              ListTile(
                title: Text('Birth Date'),
                subtitle: Text(student['birthDate'] ?? '-'),
              ),
              ListTile(
                title: Text('Hobby'),
                subtitle: Text(student['hobby'] ?? '-'),
              ),
              ListTile(
                title: Text('Phone'),
                subtitle: Text(student['phone'] ?? '-'),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to AddScreen
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail')),
      body: Center(child: Text('Detail Screen Placeholder')),
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
