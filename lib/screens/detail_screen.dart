import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String photoUrl;
  final String name;
  final String nim;
  final String birthDate;
  final String hobby;
  final String phoneNumber;
  final String address;

  const DetailScreen({super.key, 
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
      appBar: AppBar(
        title: Text('Detail Mahasiswa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(photoUrl),
              ),
            ),
            SizedBox(height: 16),
            Text('Nama: $name', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('NIM: $nim', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Tanggal Lahir: $birthDate', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Hobi: $hobby', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Nomor HP: $phoneNumber', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Alamat: $address', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}