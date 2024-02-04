import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';
import 'package:tiktok_clone/features/onboarding/interest_screen.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({super.key});

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> formData = {};

  void _onSubmitTap() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        // that will trigger onSaved callback function. it means it will save the input when user hit the button.
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const InterestScreen(),
            ), (route) {
          return false;
        });
      } //because validate return true when it is true it means there is no error.
    }
  } // This is trigger. u

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Log in",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Gaps.v28,
                TextFormField(
                    decoration: const InputDecoration(
                        hintText: "Email",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black38),
                        )),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Please write you email";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      if (newValue != null) {
                        formData['email'] = newValue;
                      }
                    }),
                Gaps.v16,
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Password",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black38),
                    ),
                  ),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Please write you password";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      formData['password'] = newValue;
                    }
                  },
                ),
                Gaps.v28,
                GestureDetector(
                  onTap: _onSubmitTap,
                  child: const FormButton(
                    disabled: false,
                    inactive: "Welcome back",
                    active: "Log in",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
