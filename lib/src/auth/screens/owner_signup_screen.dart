import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fit_raho/components/my_text_field.dart';
import 'package:fit_raho/model/user_model.dart';
import 'package:fit_raho/src/auth/widgets/user_image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class TrainerSignUpScreen extends ConsumerStatefulWidget {
  const TrainerSignUpScreen({super.key});

  static const routeName = '/trainer-signup';
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TrainerSignUpScreenState();
}

class _TrainerSignUpScreenState extends ConsumerState<TrainerSignUpScreen> {
  final _key = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _genderController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _emailController = TextEditingController();
  final _experienceController = TextEditingController();
  final _dateOfJoiningController = TextEditingController();
  final _endOfContractController = TextEditingController();
  final _workingHoursController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  File? _selectedImage;

  bool signInRequired = false;
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    _genderController.dispose();
    _dateOfBirthController.dispose();
    _emailController.dispose();
    _experienceController.dispose();
    _dateOfJoiningController.dispose();
    _endOfContractController.dispose();
    _workingHoursController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_key.currentState!.validate()) {
      try {
        // Create user in Firebase Authentication
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text);
        String userId = userCredential.user!.uid;

        // Upload profile picture to Firebase Storage
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('trainer_images')
            .child('$userId.jpg');
        await storageRef.putFile(_selectedImage!);
        final imageUrl = await storageRef.getDownloadURL();

        // Create new User object
        Users newUser = Users(
          id: userId,
          name: _nameController.text,
          email: _emailController.text,
          passwordHash:
              _passwordController.text, // Assuming you're hashing the password
          role: 'owner',
          createdAt: Timestamp.now(),
          profilePictureUrl: imageUrl,
          contactNumber: _phoneNumberController.text,
          dateOfBirth: Timestamp.fromDate(DateFormat('dd/MM/yyyy')
              .parse(_dateOfBirthController.text)
              .toLocal()), // Convert date string to Timestamp
          emergencyContact: {}, // Assuming emergency contact is not required
          membershipStatus: '',
          address: '', // Assuming membership status is not required
        );

        // Store user data in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .set(newUser.toMap());

        // Navigate to the next screen or show a success message
        // ...
      } catch (e) {
        // Handle errors appropriately
        print("Error during signup: $e");
        // Show an error message to the user
        // ...
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: screenHeight * 0.025,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
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
              Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.025,
                ),
                child: Text(
                  'Sign-up as Trainer',
                  style: TextStyle(
                    height: screenHeight * 0.001,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.75),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: Card(
                  child: Form(
                    key: _key,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          UserImagePicker(
                            onPickImage: (pickedImage) {
                              _selectedImage = pickedImage;
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          MyTextField(
                            controller: _nameController,
                            hintText: 'Name',
                            obscureText: false,
                            keyboardType: TextInputType.name,
                            prefixIcon: const Icon(Icons.man_4_outlined),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Name can\'t be empty';
                              } else if (RegExp(r'[0-9]').hasMatch(val)) {
                                return 'Name can\'t contain numbers';
                              } else if (RegExp(r'[!@#<>?":_`~;[\]\|=+)(*&^%$]')
                                  .hasMatch(val)) {
                                return 'Name can\'t contain special characters';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          MyTextField(
                            controller: _phoneNumberController,
                            hintText: 'Mobile',
                            obscureText: false,
                            keyboardType: TextInputType.phone,
                            prefixIcon:
                                const Icon(Icons.phone_android_outlined),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Mobile number can\'t be empty';
                              } else if (!RegExp(r'^[0-9]{10}$')
                                  .hasMatch(val)) {
                                return 'Enter a valid mobile number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  borderRadius: BorderRadius.circular(20),
                                  value: _genderController.text.isEmpty
                                      ? null
                                      : _genderController.text,
                                  decoration: InputDecoration(
                                    hintText: 'Gender',
                                    hintStyle:
                                        TextStyle(color: Colors.grey[500]),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    prefixIcon:
                                        const Icon(Icons.person_outline),
                                  ),
                                  items: const [
                                    DropdownMenuItem<String>(
                                      value: 'Male',
                                      child: Text('Male'),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'Female',
                                      child: Text('Female'),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'Others',
                                      child: Text('Others'),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    _genderController.text = value!;
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now(),
                                    ).then((selectedDate) {
                                      if (selectedDate != null) {
                                        final formattedDate =
                                            DateFormat('dd/MM/yyyy')
                                                .format(selectedDate);
                                        _dateOfBirthController.text =
                                            formattedDate;
                                      }
                                    });
                                  },
                                  child: AbsorbPointer(
                                    child: MyTextField(
                                      controller: _dateOfBirthController,
                                      hintText: 'Date of Birth',
                                      keyboardType: TextInputType.none,
                                      obscureText: false,
                                      prefixIcon: const Icon(
                                          Icons.calendar_month_outlined),
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return 'Date of birth can\'t be empty';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          MyTextField(
                              controller: _emailController,
                              hintText: 'Email',
                              obscureText: false,
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: const Icon(Icons.email_outlined),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Email can\'t be empty';
                                } else if (!RegExp(
                                        r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$')
                                    .hasMatch(val)) {
                                  return 'Enter a valid email';
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 7,
                          ),
                          MyTextField(
                            controller: _experienceController,
                            hintText: 'Experience (years)',
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            prefixIcon: const Icon(Icons.work_outline),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Experience can\'t be empty';
                              } else if (!RegExp(r'^[0-9]+$').hasMatch(val)) {
                                return 'Enter a valid number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          GestureDetector(
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              ).then((selectedDate) {
                                if (selectedDate != null) {
                                  final formattedDate = DateFormat('dd/MM/yyyy')
                                      .format(selectedDate);
                                  _dateOfJoiningController.text = formattedDate;
                                }
                              });
                            },
                            child: AbsorbPointer(
                              child: MyTextField(
                                controller: _dateOfJoiningController,
                                hintText: 'Date of Joining',
                                keyboardType: TextInputType.none,
                                obscureText: false,
                                prefixIcon:
                                    const Icon(Icons.calendar_today_outlined),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Date of joining can\'t be empty';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          GestureDetector(
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              ).then((selectedDate) {
                                if (selectedDate != null) {
                                  final formattedDate = DateFormat('dd/MM/yyyy')
                                      .format(selectedDate);
                                  _endOfContractController.text = formattedDate;
                                }
                              });
                            },
                            child: AbsorbPointer(
                              child: MyTextField(
                                controller: _endOfContractController,
                                hintText: 'End of Contract',
                                keyboardType: TextInputType.none,
                                obscureText: false,
                                prefixIcon:
                                    const Icon(Icons.calendar_today_outlined),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'End of contract can\'t be empty';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          MyTextField(
                            controller: _workingHoursController,
                            hintText: 'Working Hours',
                            obscureText: false,
                            keyboardType: TextInputType.text,
                            prefixIcon: const Icon(Icons.access_time_outlined),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Working hours can\'t be empty';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          MyTextField(
                            controller: _passwordController,
                            hintText: 'Password',
                            obscureText: obscurePassword,
                            keyboardType: TextInputType.visiblePassword,
                            prefixIcon: const Icon(Icons.lock_outline),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Password can\'t be empty';
                              } else if (val.length < 8) {
                                return 'Password must be at least 8 characters long';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          MyTextField(
                            controller: _confirmPasswordController,
                            hintText: 'Confirm Password',
                            obscureText: obscurePassword,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword,
                            prefixIcon: const Icon(Icons.password_outlined),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscurePassword = !obscurePassword;
                                  if (obscurePassword) {
                                    iconPassword = CupertinoIcons.eye_fill;
                                  } else {
                                    iconPassword =
                                        CupertinoIcons.eye_slash_fill;
                                  }
                                });
                              },
                              icon: Icon(iconPassword),
                            ),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Confirm password can\'t be empty';
                              } else if (val != _passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                    shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    _submit();
                                  },
                                  child: const Text(
                                    'Sign up',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            'Already have an account?',
                            style: TextStyle(
                              height: 0.5,
                              fontSize: 20,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Login Instead',
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
    ));
  }
}
