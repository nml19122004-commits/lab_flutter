import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registration")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 20),
              // Icon đại diện
              const Icon(Icons.person_add_alt_1, size: 100, color: Colors.blue),
              const SizedBox(height: 30),

              // Username field
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(),
                ),
                validator: (val) =>
                    val!.isEmpty ? "Vui lòng nhập Username" : null,
              ),
              const SizedBox(height: 10),

              // Email field
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val!.isEmpty ? "Vui lòng nhập Email" : null,
              ),
              const SizedBox(height: 10),

              // Password field
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                validator: (val) =>
                    val!.length < 6 ? "Mật khẩu tối thiểu 6 ký tự" : null,
              ),
              const SizedBox(height: 20),

              // Button Sign up
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      builder: (_) => const AlertDialog(
                        title: Text("Thông báo"),
                        content: Text("Đăng ký thành công"),
                      ),
                    );
                  }
                },
                child: const Text("Sign up"),
              ),
              const SizedBox(height: 10),

              // Button Back
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Back"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
