import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  String _currentPassword = '';
  String _password = '';
  // ignore: unused_field
  String _confirmPassword = '';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit password')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  obscureText: true,
                  decoration:
                      const InputDecoration(labelText: 'current password'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Type current password';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _currentPassword = value;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'password'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Input password';
                    } else if (value == _currentPassword) {
                      return 'Same with current password';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _password = value;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  obscureText: true,
                  decoration:
                      const InputDecoration(labelText: 'password check'),
                  validator: (value) {
                    if (value != _password) {
                      return 'Input password are not same';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _confirmPassword = value;
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_isLoading) return;
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isLoading = true;
                      });
                      final user = FirebaseAuth.instance.currentUser!;

                      await user.reauthenticateWithCredential(
                          EmailAuthProvider.credential(
                              email: user.email!, password: _currentPassword));

                      await user.updatePassword(_password);

                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Password changed')));
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
