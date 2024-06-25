// core
import 'package:fit_raho/provider/user_data_provider.dart';
import 'package:flutter/material.dart';

// firebase
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'client_signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/login';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();

  final _enteredEmailController = TextEditingController();
  final _enteredpasswordContoller = TextEditingController();
  final _passwordFocusNode = FocusNode();

  bool signInRequired = false;
  final InputBorder? border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
  );

  @override
  void dispose() {
    _enteredEmailController.dispose();
    _enteredpasswordContoller.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final shortestSide = MediaQuery.of(context).size.shortestSide < 600;
    final font20 = screenHeight * 0.07;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Consumer(
        builder: (context, ref, child) {
          final userState = ref.watch(usersProvider.notifier);
          return SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Container(
                        height: screenHeight * 0.15,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/logo.png'),
                              fit: BoxFit.fitWidth),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: screenHeight * 0.025,
                          top: screenHeight * 0.025,
                        ),
                        child: Text(
                          'Sign-In',
                          style: TextStyle(
                            height: screenHeight * 0.001,
                            fontSize: font20 * 0.7,
                            fontWeight: FontWeight.bold,
                            // fontFamily: 'IBMPlexMono',
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.75),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: shortestSide
                          ? const EdgeInsets.all(25)
                          : EdgeInsets.symmetric(horizontal: screenWidth / 5),
                      child: Card(
                        child: Form(
                          key: _form,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  controller: _enteredEmailController,
                                  decoration: InputDecoration(
                                    labelText: 'Email Address',
                                    border: border,
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  keyboardType: TextInputType.emailAddress,
                                  autocorrect: false,
                                  textCapitalization: TextCapitalization.none,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (value) {
                                    FocusScope.of(context)
                                        .requestFocus(_passwordFocusNode);
                                  },
                                  validator: (value) {
                                    if (value == null ||
                                        value.trim().isEmpty ||
                                        !value.contains('@')) {
                                      // this validation should pass the silicon id test
                                      return 'Please enter a valid email address.';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 7),
                                TextFormField(
                                  controller: _enteredpasswordContoller,
                                  decoration: InputDecoration(
                                      labelText: 'Password', border: border),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  obscureText: true,
                                  keyboardType: TextInputType.visiblePassword,
                                  focusNode: _passwordFocusNode,
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Enter password';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: !signInRequired
                                          ? ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .secondary),
                                                shape: MaterialStatePropertyAll(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                ),
                                              ),
                                              onPressed: () async {
                                                userState.signIn(
                                                  _enteredEmailController.text,
                                                  _enteredpasswordContoller
                                                      .text,
                                                );
                                              },
                                              child: Text(
                                                'Sign in',
                                                style: TextStyle(
                                                    fontSize: font20 * 0.3,
                                                    color: Colors.white),
                                              ),
                                            )
                                          : const CircularProgressIndicator(),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                //Dont have account text
                                if (!signInRequired)
                                  const Text(
                                    'Don\'t have an account?',
                                    style: TextStyle(
                                      height: 0.5,
                                      fontSize: 20,
                                    ),
                                  ),
                                if (!signInRequired)
                                  TextButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Register as'),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    // Handle Member option
                                                    Navigator.of(context)
                                                        .popAndPushNamed(
                                                      ClientSignUpScreen
                                                          .routeName,
                                                    );
                                                  },
                                                  child: const Text('Member'),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    // Handle Trainer option
                                                    // Navigator.of(context)
                                                    //     .popAndPushNamed(
                                                    //   // TrainerSignUpScreen
                                                    //       // .routeName,
                                                    // );
                                                  },
                                                  child: const Text('Trainer'),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    // Handle Trainer option
                                                    // Navigator.of(context)
                                                    //     .popAndPushNamed(
                                                    //   OwnerSignUpScreen
                                                    //       .routeName,
                                                    // );
                                                  },
                                                  child: const Text('Owner'),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: const Text(
                                      'Create account',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
