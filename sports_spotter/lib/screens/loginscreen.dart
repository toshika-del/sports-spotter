import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sports_spotter/api/auth.dart';
import 'package:sports_spotter/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool hidePassword = true;
  TextEditingController enrollment = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: paddingAll24,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            space16,
            space16,
            const Image(
              image: AssetImage('assets/login_avtar.png'),
              height: 240,
            ),
            Text(
              'Login to $title',
              style:
                  GoogleFonts.kanit(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            space16,
            TextField(
              controller: enrollment,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  hintText: 'Enrollment number',
                  prefixIcon: Icon(FontAwesomeIcons.userGraduate)),
            ),
            space16,
            TextField(
              controller: password,
              obscureText: hidePassword,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: const Icon(FontAwesomeIcons.lock),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                      icon: Icon(hidePassword
                          ? FontAwesomeIcons.solidEye
                          : FontAwesomeIcons.solidEyeSlash))),
            ),
            space16,
            ElevatedButton(
                onPressed: () {
                  if (enrollment.text.trim().isNotEmpty ||
                      password.text.trim().isNotEmpty) {
                    Auth.login(enrollment.text.trim(), password.text.trim())
                        .then((value) {
                      final statusCode = value['status_code'];
                      if (statusCode == 403) {
                        showSnackbar(context, const Text('Invalid password'),
                            errorColor);
                      } else if (statusCode == 404) {
                        showSnackbar(
                            context, const Text('User not found'), errorColor);
                      } else if (statusCode == 200) {
                        showSnackbar(
                            context,
                            Text('Logged in as ${enrollment.text}'),
                            successColor);
                      }
                    });
                  } else {
                    showSnackbar(
                        context,
                        const Text(
                            'Enter a valid enrollment number and password'),
                        errorColor);
                  }
                },
                child: const Text(
                  'Login',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            space8,
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register/');
                },
                child: const Text('Don\'t have an account? Create one')),
            TextButton(onPressed: () {}, child: const Text('Forgot Password?'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/feedback/');
        },
        child: const Icon(Icons.feedback),
      ),
    );
  }
}
