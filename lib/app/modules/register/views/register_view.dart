import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

import '../../../data/constans/validation.dart';

import 'package:form_validator/form_validator.dart';

extension CustomValidationBuilder on ValidationBuilder {
  custom() => add((value) {
        if (!EmailValidator.isValidEmail(value)) {
          return 'Enter a valid email address with @smk.belajar.id';
        }
        return null;
      });
  password() => add((value) {
        if (!PasswordValidator.isValidPasswordUpper(password: value)) {
          return 'Password must contain at least 1 uppercase letter';
        }
        if (!PasswordValidator.isValidPasswordSymbol(password: value)) {
          return 'Password must contain at least 1 Sysmbol';
        }
        return null;
      });
  ValidationBuilder confirmPassword(TextEditingController controller) {
    return this
      ..add((value) {
        if (value != controller.text.toString()) {
          return 'Passwords do not match';
        }
        return null;
      });
  }
}

final validatorPassword = ValidationBuilder()
    .minLength(8, 'Password must be at least 8 characters')
    .password()
    .build();
final validator = ValidationBuilder().email().custom().build();

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final HeightBody = MediaQuery.of(context).size.height;
    final WidthBody = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFA6F6FF), Color(0xFFFFFFFF)])),
      height: HeightBody,
      child: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: WidthBody,
            padding:
                EdgeInsets.only(right: 20, left: 20, top: HeightBody * 0.03),
            child: Column(
              children: [
                Image(
                  image: AssetImage("assets/logo.png"),
                  width: WidthBody * 0.4,
                ),
                Text(
                  "REGISTER",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 40),
                ),
                SizedBox(
                  height: HeightBody * 0.06,
                ),
                TextFormField(
                    validator: ValidationBuilder().minLength(5).build(),
                    controller: controller.username,
                    autocorrect: false,
                    autofocus: true,
                    enableInteractiveSelection: false,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      hintText: "@tergarsaputra",
                      filled: true,
                      label: Text("Username"),
                      // border: OutlineInputBorder(),
                      fillColor: Color(0xFFF1F1F1),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 255, 17, 0))),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 255, 17, 0))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue.shade400)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    )),
                SizedBox(
                  height: HeightBody * 0.02,
                ),
                TextFormField(
                    validator: validator,
                    controller: controller.email,
                    autocorrect: false,
                    autofocus: true,
                    enableInteractiveSelection: false,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      hintText: "Tegar@gmail.com",
                      filled: true,
                      label: Text("Email"),
                      // border: OutlineInputBorder(),
                      fillColor: Color(0xFFF1F1F1),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 255, 17, 0))),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 255, 17, 0))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue.shade400)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    )),
                SizedBox(
                  height: HeightBody * 0.02,
                ),
                Obx(
                  () => TextFormField(
                      validator: validatorPassword,
                      controller: controller.password,
                      obscureText: controller.isPasswordHidden.value,
                      obscuringCharacter: '*',
                      autocorrect: false,
                      autofocus: true,
                      enableInteractiveSelection: false,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                          child: Icon(
                            controller.isPasswordHidden.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 20,
                            color: Colors.black,
                          ),
                          onTap: () {
                            controller.isPasswordHidden.value =
                                !controller.isPasswordHidden.value;
                          },
                        ),
                        hintText: "Password",
                        label: Text("Password"),
                        filled: true,
                        // border: OutlineInputBorder(),
                        fillColor: Color(0xFFF1F1F1),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: const Color.fromARGB(255, 255, 17, 0))),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: const Color.fromARGB(255, 255, 17, 0))),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue.shade400)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                      )),
                ),
                SizedBox(
                  height: HeightBody * 0.02,
                ),
                Obx(
                  () => TextFormField(
                      validator: ValidationBuilder()
                          .confirmPassword(controller.password)
                          .build(),
                      obscureText: controller.isPasswordConfirmHidden.value,
                      obscuringCharacter: '*',
                      autocorrect: false,
                      autofocus: true,
                      enableInteractiveSelection: false,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                          child: Icon(
                            controller.isPasswordConfirmHidden.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 20,
                            color: Colors.black,
                          ),
                          onTap: () {
                            controller.isPasswordConfirmHidden.value =
                                !controller.isPasswordConfirmHidden.value;
                          },
                        ),
                        hintText: "Confirm Password",
                        label: Text("Confirm Password"),
                        filled: true,
                        // border: OutlineInputBorder(),
                        fillColor: Color(0xFFF1F1F1),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: const Color.fromARGB(255, 255, 17, 0))),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: const Color.fromARGB(255, 255, 17, 0))),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue.shade400)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                      )),
                ),
                SizedBox(
                  height: HeightBody * 0.06,
                ),
                Obx(
                  () => ElevatedButton(
                      onPressed: () {
                        controller.postRegister();
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                        child: controller.loading.value
                            ? CircularProgressIndicator()
                            : Text(
                                'Register',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20,
                                    color: Colors.black),
                              ),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          backgroundColor: Color(0xFFF1F1F1))),
                ),
                SizedBox(
                  height: HeightBody * 0.06,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
