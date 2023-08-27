import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:testtest/core/constant/app_colors.dart';
import 'package:testtest/data/remote/register.dart';
import 'package:testtest/views/screens/login_and_signup/login_view.dart';

import '../../widgets/costum_textfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  List<String> options = ['Male', 'Female'];
  String? current;
  bool autovalidate = false;
  TextEditingController dateInputController = TextEditingController();
  String? email, name, password, gender, birthdate;
  GlobalKey<FormState> formkey = GlobalKey();
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_conditional_assignment
    if (current == null) {
      current = options[0];
    }
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        body: Form(
          key: formkey,
          child: SafeArea(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Handy!",
                    style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "Welcome to our app",
                    style:
                        TextStyle(color: AppColors.secondryText, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  costumTextField(
                    textInputType: TextInputType.emailAddress,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'This field is requierd';
                      }
                      return null;
                    },
                    icon: const Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    name: 'Email',
                    security: false,
                    onchanged: (p0) {
                      email = p0;
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  costumTextField(
                    textInputType: TextInputType.name,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'This field is requierd';
                      }
                      return null;
                    },
                    icon: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    name: "Name",
                    security: false,
                    onchanged: (value) {
                      name = value;
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  costumTextField(
                    textInputType: TextInputType.name,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'field is required';
                      } else if (value.length < 8) {
                        return 'password should be more than 8 charechters';
                      }
                      return null;
                    },
                    icon: const Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                    name: 'Password',
                    security: true,
                    onchanged: (p0) {
                      password = p0;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Gender:',
                    style: TextStyle(fontSize: 18),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2 - 10,
                        child: ListTile(
                          leading: Radio<String>(
                            value: options[0],
                            groupValue: current,
                            onChanged: (value) {
                              current = value!;
                              setState(() {});
                            },
                          ),
                          title: const Text('Male'),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2 - 10,
                        child: ListTile(
                          leading: Radio<String>(
                            value: options[1],
                            groupValue: current,
                            onChanged: (value) {
                              current = value!;
                              setState(() {});
                            },
                          ),
                          title: const Text('Female'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 35,
                    ),
                    child: TextFormField(
                        readOnly: true,
                        autofocus: false,
                        controller: dateInputController,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              lastDate: DateTime(2050));

                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            setState(() {
                              dateInputController.text = formattedDate;
                            });
                          }
                        },
                        decoration: InputDecoration(
                            icon: const Icon(Icons.calendar_today),
                            hintText: 'Birth Date',
                            enabled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)))),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginView(),
                              ));
                        },
                        child: const Text(
                          " Login!",
                          style: TextStyle(
                              fontSize: 20,
                              color: AppColors.mainColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (formkey.currentState!.validate()) {
                        isloading = true;
                        setState(() {});
                        try {
                          await register(
                              date: dateInputController.text,
                              gender: current!.toLowerCase(),
                              name: name!,
                              state: "superadmin",
                              email: email!,
                              password: password!,
                              url: "https://handyclose.com/api/customer");
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Regesteration complete, please veify your email address!"),
                            ),
                          );
                          Future.delayed(const Duration(seconds: 1));
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginView(),
                            ),
                          );
                        } catch (ex) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(ex.toString()),
                            ),
                          );
                        }
                      }

                      isloading = false;
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60, vertical: 15),
                      decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(40)),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 35, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
