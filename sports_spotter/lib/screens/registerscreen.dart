import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sports_spotter/constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _fName = TextEditingController();
  final _lName = TextEditingController();
  final _email = TextEditingController();
  final _enrollment = TextEditingController();
  final _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: paddingAll24,
        child: Column(
          children: [
            space16,
            space16,
            Image.asset(
              'assets/login_avtar.png',
              height: 200,
            ),
            Text(
              'Create Account',
              style:
                  GoogleFonts.kanit(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            space16,
            TextField(
              controller: _fName,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  hintText: 'First name',
                  prefixIcon: Icon(FontAwesomeIcons.idCard)),
            ),
            space16,
            TextField(
              controller: _lName,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  hintText: 'Last name',
                  prefixIcon: Icon(FontAwesomeIcons.idCard)),
            ),
            space8,
            const Divider(),
            space8,
            TextField(
              controller: _enrollment,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  hintText: 'Enrollment number',
                  prefixIcon: Icon(FontAwesomeIcons.userGraduate)),
            ),
            space16,
            TextField(
              controller: _email,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  hintText: 'Email', prefixIcon: Icon(Icons.email)),
            ),
            space16,
            TextField(
              controller: _password,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(FontAwesomeIcons.lock)),
            ),
            space16,
            ElevatedButton(
                onPressed: () {}, child: const Text('Create Account')),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back to login'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.feedback),
      ),
    );
  }
}
