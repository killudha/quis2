import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddEditScreen extends StatefulWidget {
  final bool isEdit;
  final Map<String, dynamic>? studentData;

  const AddEditScreen({super.key, this.isEdit = false, this.studentData});

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _hobbyController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.studentData != null) {
      _nameController.text = widget.studentData!['name'] ?? '';
      _nimController.text = widget.studentData!['nim'] ?? '';
      _birthDateController.text = widget.studentData!['birthDate'] ?? '';
      _hobbyController.text = widget.studentData!['hobby'] ?? '';
      _phoneNumberController.text = widget.studentData!['phone'] ?? '';
      _addressController.text = widget.studentData!['address'] ?? '';
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveData() async {
    if (!_formKey.currentState!.validate()) return;

    String? photoUrl;
    if (_imageFile != null) {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('student_photos/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await storageRef.putFile(_imageFile!);
      photoUrl = await storageRef.getDownloadURL();
    }

    final studentData = {
      'name': _nameController.text,
      'nim': _nimController.text,
      'birthDate': _birthDateController.text,
      'hobby': _hobbyController.text,
      'phone': _phoneNumberController.text,
      'address': _addressController.text,
      'photoUrl': photoUrl ?? widget.studentData?['photoUrl'],
    };

    if (widget.isEdit) {
      await FirebaseFirestore.instance
          .collection('students')
          .doc(widget.studentData!['id'])
          .update(studentData);
    } else {
      await FirebaseFirestore.instance.collection('students').add(studentData);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Edit Mahasiswa' : 'Tambah Mahasiswa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _imageFile != null
                      ? FileImage(_imageFile!)
                      : (widget.isEdit && widget.studentData?['photoUrl'] != null
                          ? NetworkImage(widget.studentData!['photoUrl'])
                          : AssetImage('assets/logo.png')) as ImageProvider,
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _nimController,
                decoration: InputDecoration(labelText: 'NIM'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'NIM tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _birthDateController,
                decoration: InputDecoration(labelText: 'Tanggal Lahir'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tanggal Lahir tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _hobbyController,
                decoration: InputDecoration(labelText: 'Hobi'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(labelText: 'Nomor HP'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor HP tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Alamat'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveData,
                child: Text(widget.isEdit ? 'Update' : 'Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}