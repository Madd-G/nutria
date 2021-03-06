import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/main_button.dart';
import '../components/text_input_decoration.dart';
import '../controllers/controllers.dart';

class SignUpScreenSecond extends StatelessWidget {
  const SignUpScreenSecond({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Controllers c = Get.put<Controllers>(Controllers());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                  ),
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    Get.offNamed('sign_up_screen_first');
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Sign Up".tr,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 40,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Please fill information to create an\naccount and sign up to continue"
                      .tr,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 45,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: textInputDecoration.copyWith(
                    hintText: 'Email',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Obx(
                  () => TextField(
                    keyboardType: TextInputType.text,
                    obscureText: c.isHidden.value ? true : false,
                    decoration: textInputDecoration.copyWith(
                      suffixIconColor: Theme.of(context).colorScheme.primary,
                      hintText: 'Password',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () => c.toggleVisibility(),
                        child: Icon(c.isHidden.value == true
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Obx(
                  () => TextField(
                    keyboardType: TextInputType.text,
                    obscureText: c.isHidden.value ? true : false,
                    decoration: textInputDecoration.copyWith(
                      suffixIconColor: Theme.of(context).colorScheme.primary,
                      hintText: 'Confirm Password'.tr,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () => c.toggleVisibility(),
                        child: Icon(c.isHidden.value == true
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                MainButton(
                    title: 'Sign Up'.tr,
                    onPressed: () {
                      Get.toNamed('/upload_profile_photo_screen');
                    }),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? '.tr,
                      style: const TextStyle(fontSize: 17),
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed('/login_screen'),
                      child: Text(
                        'Login'.tr,
                        style: TextStyle(
                            fontSize: 17,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
