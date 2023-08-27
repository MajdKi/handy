import 'package:flutter/material.dart';
import 'package:testtest/core/constant/app_colors.dart';
import 'package:testtest/views/screens/home.dart';
import 'package:testtest/views/screens/login_and_signup/signup_view.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/remote/login.dart';
import '../../widgets/costum_textfield.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String? email, password;

  GlobalKey<FormState> formkey = GlobalKey();
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: formkey,
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    "Hello Again!",
                    style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "Welcome back you've been missed",
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
                    height: 15,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "New to Handy?  ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUp(),
                              ));
                        },
                        child: const Text(
                          " Register Now!",
                          style: TextStyle(
                              fontSize: 20,
                              color: AppColors.mainColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      try {
                        isloading = true;
                        setState(() {});
                        launchUrl(Uri.parse(
                            "https://handy-7x8p.onrender.com/#/login"));
                        isloading = false;
                        // ignore: empty_catches
                      } catch (e) {}
                    },
                    child: const Text(
                      "Forgot password?",
                      style: TextStyle(
                          fontSize: 20,
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 120,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (formkey.currentState!.validate()) {
                        isloading = true;
                        setState(() {});
                        try {
                          bool x = await login(
                              email: email!,
                              password: password!,
                              url: "https://handyclose.com/api/Auth/login");
                          if (x == true) {
                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeView(),
                              ),
                            );
                          }
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
                        "Login",
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
