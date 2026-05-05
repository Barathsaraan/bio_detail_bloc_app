import 'package:biodetail/bloc/user_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user_bloc.dart';

class AddDetailPage extends StatefulWidget {
  const AddDetailPage({super.key});

  @override
  State<AddDetailPage> createState() => _AddDetailPageState();
}

class _AddDetailPageState extends State<AddDetailPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _imageController = TextEditingController();
  final _dobController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _imageController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  void _onSave(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // Send AddUserEvent to the BLoC
      context.read<UserBloc>().add(
        AddUserEvent(
          name: _nameController.text.trim(),
          image: _imageController.text.trim().isEmpty
              ? 'https://upload.wikimedia.org/wikipedia/commons/4/4e/Dot_red_logo.png?utm_source=commons.wikimedia.org&utm_campaign=index&utm_content=original'
              : _imageController.text.trim(),
          dob: _dobController.text.trim(),
        ),
      );
      _nameController.clear();
      _imageController.clear();
      _dobController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User saved'),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pop(context);
    }
  }

  // Date picker
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1995),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _dobController.text =
          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a name'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _imageController,
                decoration: const InputDecoration(
                  labelText: 'Image URL (optional)',
                  prefixIcon: Icon(Icons.image),
                  border: OutlineInputBorder(),
                  hintText: 'https://...',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dobController,
                readOnly: true,
                onTap: _pickDate,
                decoration: const InputDecoration(
                  labelText: 'Date of Birth',
                  prefixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                  hintText: 'YYYY-MM-DD',
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please select a date'
                    : null,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => _onSave(context),
                  child: const Text(
                    'Save',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
