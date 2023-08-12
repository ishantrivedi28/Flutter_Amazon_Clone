import 'package:amazon_clone/common/custom_elevatedButton.dart';
import 'package:amazon_clone/common/custom_textformfield.dart';
import 'package:amazon_clone/features/auth/services/auth_service.dart';
import 'package:amazon_clone/global_variables.dart';
import 'package:flutter/material.dart';

enum Auth { signin, signup }

class AuthScreen extends StatefulWidget {
  AuthScreen({super.key});
  static const String routeName = '/auth-screen';
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Auth? _groupVal = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  AuthService authService = AuthService();

  void signUpUser() {
    authService.signUp(
        context: context,
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text);
  }

  void signInUser() {
    authService.signin(
        email: emailController.text,
        password: passwordController.text,
        context: context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                Container(
                  color: _groupVal == Auth.signup
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundColor,
                  child: ListTile(
                    leading: Radio(
                        activeColor: GlobalVariables.secondaryColor,
                        value: Auth.signup,
                        groupValue: _groupVal,
                        onChanged: (Auth? value) {
                          setState(() {
                            _groupVal = value;
                          });
                        }),
                    title: Text("Create Account"),
                  ),
                ),
                if (_groupVal == Auth.signup)
                  Form(
                    key: _signUpFormKey,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      color: GlobalVariables.backgroundColor,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: nameController,
                            hintText: "Name",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              controller: emailController, hintText: 'Email'),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              controller: passwordController,
                              hintText: 'Password'),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                              onPressed: () {
                                if (_signUpFormKey.currentState!.validate()) {
                                  signUpUser();
                                }
                              },
                              text: "Sign Up")
                        ],
                      ),
                    ),
                  ),
                Container(
                  color: _groupVal == Auth.signin
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundColor,
                  child: ListTile(
                    leading: Radio(
                        activeColor: GlobalVariables.secondaryColor,
                        value: Auth.signin,
                        groupValue: _groupVal,
                        onChanged: (Auth? value) {
                          setState(() {
                            _groupVal = value;
                          });
                        }),
                    title: Text("Sign-In"),
                  ),
                ),
                if (_groupVal == Auth.signin)
                  Form(
                    key: _signInFormKey,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      color: GlobalVariables.backgroundColor,
                      child: Column(
                        children: [
                          CustomTextField(
                              controller: emailController, hintText: 'Email'),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              controller: passwordController,
                              hintText: 'Password'),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                              onPressed: () {
                                if (_signInFormKey.currentState!.validate()) {
                                  signInUser();
                                }
                              },
                              text: "Sign In")
                        ],
                      ),
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
