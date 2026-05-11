import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String role = "User";
  bool agree = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form Registrasi")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              /// Nama
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Nama",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nama wajib diisi";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              /// Email
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email wajib diisi";
                  }
                  if (!value.contains("@")) {
                    return "Format email tidak valid";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              /// Password
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return "Password minimal 6 karakter";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              /// Confirm Password
              TextFormField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Konfirmasi Password",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value != passwordController.text) {
                    return "Password tidak sama";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              /// Dropdown Role
              DropdownButtonFormField<String>(
                value: role,
                items: const [
                  DropdownMenuItem(value: "User", child: Text("User")),
                  DropdownMenuItem(value: "Admin", child: Text("Admin")),
                ],
                onChanged: (value) {
                  setState(() {
                    role = value!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: "Role",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              /// Checkbox
              CheckboxListTile(
                value: agree,
                onChanged: (value) {
                  setState(() {
                    agree = value!;
                  });
                },
                title: const Text("Saya setuju dengan syarat & ketentuan"),
              ),
              const SizedBox(height: 20),

              /// Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate() && agree) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Registrasi Berhasil")),
                    );
                    // Navigate back after successful registration
                    Future.delayed(const Duration(seconds: 1), () {
                      Navigator.of(context).pop();
                    });
                  } else if (!agree) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Harap setujui syarat & ketentuan"),
                      ),
                    );
                  }
                },
                child: const Text("Daftar"),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Sudah punya akun? Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
