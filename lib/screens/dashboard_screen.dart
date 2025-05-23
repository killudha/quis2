import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

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
      body: ListView.builder(
        itemCount: 10, // TODO: Replace with dynamic data count
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage('https://via.placeholder.com/150'), // TODO: Replace with student photo
            ),
            title: Text('Student Name $index'), // TODO: Replace with student name
            subtitle: Text('NIM: 12345678'), // TODO: Replace with student NIM
            onTap: () {
              // TODO: Navigate to DetailScreen
            },
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
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: Center(
        child: Text('Detail Screen Placeholder'),
      ),
    );
  }
}

class AddEditScreen extends StatelessWidget {
  const AddEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add / Edit'),
      ),
      body: Center(
        child: Text('Add / Edit Screen Placeholder'),
      ),
    );
  }
}