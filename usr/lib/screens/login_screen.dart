import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _codeController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() => _isLoading = true);
    final success = await context.read<AuthProvider>().loginWithInvitation(_codeController.text);
    setState(() => _isLoading = false);
    if (success) {
      final user = context.read<AuthProvider>().currentUser;
      if (user!.isAdmin) {
        Navigator.pushReplacementNamed(context, '/admin');
      } else {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid invitation code')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.pinkAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.lock, size: 64, color: Colors.purple),
                    const SizedBox(height: 20),
                    Text(
                      'Welcome to Women Leaders Community',
                      style: Theme.of(context).textTheme.headlineLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Enter your invitation code to join',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: _codeController,
                      decoration: const InputDecoration(
                        labelText: 'Invitation Code',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: _login,
                            child: const Text('Join Community'),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
