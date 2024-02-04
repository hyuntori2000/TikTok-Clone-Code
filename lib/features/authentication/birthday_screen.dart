import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';
import 'package:tiktok_clone/features/onboarding/interest_screen.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  final TextEditingController _birthdayController =
      TextEditingController(); //controlling textediting(listener).
  DateTime initialDate =
      DateTime.now().subtract(const Duration(days: 365 * 12));
  @override
  void initState() {
    super.initState();
    _setTextFieldDate(initialDate);
  }

  @override
  void dispose() {
    _birthdayController.dispose();
    super.dispose();
  }

  void onNextTap() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const InterestScreen(),
        ),
        (route) => false);
  }

  void _setTextFieldDate(
      DateTime
          date) //method to make range of date data, 여기서 date = recieved data which is initalDate, 다른 함수라는 사실을 까먹으면 안된다.
  {
    final textDate = date.toString().split(" ").first;
    _birthdayController.value = TextEditingValue(text: textDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              "When's your birthday?",
              style: TextStyle(
                  fontSize: Sizes.size24, fontWeight: FontWeight.w700),
            ),
            Gaps.v8,
            const Text(
              "Your birthday won't be shown on public.",
              style: TextStyle(
                fontSize: Sizes.size16,
                color: Colors.black38,
              ),
            ),
            Gaps.v16,
            TextField(
              enabled: false,
              controller: _birthdayController,
              decoration: const InputDecoration(
                hintText: "Birthday",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black38),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black38),
                ),
              ),
              cursorColor: Theme.of(context).primaryColor,
            ),
            Gaps.v16,
            GestureDetector(
              onTap: onNextTap,
              child: const FormButton(
                inactive: "Sign up",
                active: "Next",
                disabled: false,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: Sizes.size96,
        child: CupertinoDatePicker(
          maximumDate: initialDate,
          initialDateTime: initialDate,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: _setTextFieldDate,
        ),
      ),
    );
  }
}
