import 'package:firebase_exam_demo/assets/colors/colors.dart';
import 'package:firebase_exam_demo/assets/constants/route_names/route_names.dart';
import 'package:firebase_exam_demo/assets/icons/icons.dart';
import 'package:firebase_exam_demo/features/user/presentation/bloc/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoginDataValid = false;
  final mailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();

  final mailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  final textFieldContentStyle = const TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  final formKey = GlobalKey<FormState>();

  bool isVisible = true;

  @override
  void initState() {
    mailTextEditingController.addListener(() {
      if (formKey.currentState!.validate()) {
        if (!isLoginDataValid) {
          setState(() {
            isLoginDataValid = true;
          });
        }
      } else {
        if (isLoginDataValid) {
          setState(() {
            isLoginDataValid = false;
          });
        }
      }
    });

    passwordTextEditingController.addListener(() {
      if (formKey.currentState!.validate()) {
        if (!isLoginDataValid) {
          setState(() {
            isLoginDataValid = true;
          });
        }
      } else {
        if (isLoginDataValid) {
          setState(() {
            isLoginDataValid = false;
          });
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    mailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    mailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String obscureIcon = AppIcons.invisible;
    return SafeArea(
      child: Scaffold(
        backgroundColor: scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 100),
              Image.asset(
                AppIcons.productiveLogo,
              ),
              const SizedBox(height: 50),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: textFieldBackgroundColor),
                      child: TextFormField(
                        style: textFieldContentStyle,
                        cursorColor: cursorColor,
                        focusNode: mailFocusNode,
                        controller: mailTextEditingController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        onEditingComplete: () {
                          passwordFocusNode.requestFocus();
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Iltimos, mail kiriting!';
                          } else if (!RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Iltimos, yaroqli mail manzilini kiriting';
                          }

                          return null;
                        },
                      ),
                      // TextFormField(
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Iltimos, parolingizni kiriting!';
                      //     } else if (value.length < 7) {
                      //       return 'Parol eng kamida 8ta belgidan tashkil topgan bo\'lishi kerak';
                      //     }

                      //     return null;
                      //   },
                      //   controller: emailController,
                      //   decoration: const InputDecoration(
                      //     border: InputBorder.none,
                      //     hintText: "Email",
                      //     hintStyle: TextStyle(color: Colors.grey),
                      //   ),
                      //   style: const TextStyle(color: Colors.white),
                      // ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: textFieldBackgroundColor),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              cursorColor: cursorColor,
                              focusNode: passwordFocusNode,
                              controller: passwordTextEditingController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Iltimos, parolingizni kiriting!';
                                } else if (value.length < 7) {
                                  return 'Parol eng kamida 8ta belgidan tashkil topgan bo\'lishi kerak';
                                }

                                return null;
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              obscureText: isVisible,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                  if (isVisible == true) {
                                    obscureIcon = AppIcons.invisible;
                                  } else {
                                    obscureIcon = AppIcons.visible;
                                  }
                                });
                              },
                              icon: SvgPicture.asset(obscureIcon))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forgot password?",
                      style: TextStyle(color: Color.fromARGB(255, 8, 95, 167)),
                    )),
              ),
              LoginButton(
                isAllowed: !isLoginDataValid,
                onPressed: () {
                  context
                      .read<AuthenticationBloc>()
                      .add(AuthenticationLoginRequestedEvent(
                        email: mailTextEditingController.text.trim(),
                        password: passwordTextEditingController.text.trim(),
                        onSuccess: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRouteNames.profileScreen,
                            (_) => false,
                          );
                        },
                        onFailure: (message) {
                          print(message);
                        },
                      ));
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Image.asset(AppIcons.orImage),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AccountLoginButton(icon: AppIcons.facebookIcon),
                    AccountLoginButton(icon: AppIcons.googleIcon),
                    AccountLoginButton(icon: AppIcons.appleIcon),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Sign up?",
                        style:
                            TextStyle(color: Color.fromARGB(255, 8, 95, 167)),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration decoration({
    required String hintText,
    Widget? suffixIcon,
  }) =>
      InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 13.5),
        hintStyle: TextStyle(
          // color: hintTextColor.withOpacity(.6),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        // fillColor: textFieldBackgroundColor2,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 1,
            // color: textFieldBorderColor.withOpacity(.1),
            style: BorderStyle.solid,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 1,
            // color: textFieldBorderColor.withOpacity(.1),
            style: BorderStyle.solid,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 1,
            // color: textFieldBorderColor.withOpacity(.1),
            style: BorderStyle.solid,
          ),
        ),
      );
}

class LoginButton extends StatelessWidget {
  final Function() onPressed;
  final bool isAllowed;
  const LoginButton({
    super.key,
    required this.onPressed,
    required this.isAllowed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => onPressed(),
        child: Ink(
          height: 60,
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: isAllowed ? cursorColor : notAllowed,
              borderRadius: BorderRadius.circular(10)),
          child: const Center(
            child: Text(
              'Login',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}

class AccountLoginButton extends StatelessWidget {
  final String icon;

  const AccountLoginButton({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      child: Ink(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(39, 44, 56, 1),
            borderRadius: BorderRadius.circular(10)),
        child: Center(child: SvgPicture.asset(icon)),
      ),
    );
    ;
  }
}
