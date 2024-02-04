import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/features/authentication/birthday_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _passwordController =
      TextEditingController(); //controlling textediting(listener).
  String _password = "";

  bool _obscureText = true;
  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
//when user put text in the input box Controller accept the data and place on the console immidiat
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  bool _isPasswordValid() {
    return _password.isNotEmpty && _password.length > 8;
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSubmit() {
    if (!_isPasswordValid()) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BirthdayScreen(),
      ),
    );
  }

  void _onClearTap() {
    _passwordController.clear();
  }

  void _onEyeTap() {
    if (_obscureText == true) {
      setState(() {
        _obscureText = false;
      });
    } else {
      setState(() {
        _obscureText = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Sign Up",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v40,
              const Text(
                "Password",
                style: TextStyle(
                    fontSize: Sizes.size24, fontWeight: FontWeight.w700),
              ),
              Gaps.v16,
              TextField(
                obscureText: _obscureText,
                onEditingComplete: _onSubmit,
                controller: _passwordController,
                decoration: InputDecoration(
                  suffix: Row(mainAxisSize: MainAxisSize.min, children: [
                    GestureDetector(
                      onTap: _onClearTap,
                      child: FaIcon(
                        FontAwesomeIcons.solidCircleXmark,
                        color: Colors.grey.shade400,
                        size: Sizes.size20,
                      ),
                    ),
                    Gaps.h5,
                    GestureDetector(
                      onTap: _onEyeTap,
                      child: FaIcon(
                        _obscureText
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash,
                        color: Colors.grey.shade400,
                        size: Sizes.size20,
                      ),
                    )
                  ]),
                  hintText: "Make it strong!",
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black38),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black38),
                  ),
                ),
                cursorColor: Theme.of(context).primaryColor,
              ),
              Gaps.v10,
              const Text('Yor password must have:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Gaps.v10,
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.circleCheck,
                    size: Sizes.size16,
                    color: _isPasswordValid()
                        ? Colors.green
                        : Colors.grey.shade400,
                  ),
                  Gaps.h5,
                  const Text("8 to 20 characters")
                ],
              ),
              Gaps.v16,
              GestureDetector(
                  onTap: _onSubmit,
                  child: FormButton(
                      inactive: "Sign up",
                      active: "Next",
                      disabled: _password.isEmpty || !_isPasswordValid()))
            ],
          ),
        ),
      ),
    );
  }
}
