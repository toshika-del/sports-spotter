import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
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
                onPressed: () {},
                child: const Text(
                  'Login',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            TextButton(onPressed: () {}, child: const Text('Forgot Password?'))
          ],
        ),
      ),
    );
  }
}
