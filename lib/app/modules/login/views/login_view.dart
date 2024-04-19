import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/constans/validation.dart';

import 'package:form_validator/form_validator.dart';

import '../controllers/login_controller.dart';

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

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final HeightBody = MediaQuery.of(context).size.height;
    final WidthBody = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFA6F6FF),
                  Color(0xFFFFFFFF)
                ]
            )
        ),
        height: HeightBody,
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              width: WidthBody,
              padding: EdgeInsets.symmetric(horizontal: 25,vertical: HeightBody * 0.05),
              child: Column(
                children: [
                  Image(image: const AssetImage("assets/logo.png"), width: WidthBody * 0.4,),
                  const Text("LOGIN", style: TextStyle(fontWeight: FontWeight.w900,fontSize: 40),),
                  SizedBox(
                    height: HeightBody * 0.06,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.2),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: Offset(0, 4), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextFormField(
                      validator: validator,
                      controller: controller.email,
                        autocorrect: false,
                        autofocus: true,
                        enableInteractiveSelection: false,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          hintText: "Tegar@gmail.com",
                          filled: true,
                          label: const Text("Email"),
                          // border: OutlineInputBorder(),
                          fillColor: const Color(0xFFF1F1F1),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue.shade400)),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                        )),
                  ),
                  SizedBox(
                    height: HeightBody * 0.06,
                  ),
                  Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: Offset(0, 4), // changes position of shadow
                          ),
                        ],
                      ),
                    child: Obx(()=>TextFormField(
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
                            onTap: (){
                              controller.isPasswordHidden.value =! controller.isPasswordHidden.value;
                            },
                          ),
                          hintText: "Password",
                          label: const Text("Password"),
                          filled: true,
                          // border: OutlineInputBorder(),
                          fillColor: const Color(0xFFF1F1F1),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue.shade400)),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                        )),
                  )
                  ),
                  SizedBox(
                    height: HeightBody * 0.06,
                  ),
                  Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: Offset(0, 4), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Obx(()=>TextFormField(
                        validator: ValidationBuilder().confirmPassword(controller.password).build(),
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
                              onTap: (){
                                controller.isPasswordConfirmHidden.value =! controller.isPasswordConfirmHidden.value;
                              },
                            ),
                            hintText: "Confirm Password",
                            label: Text("Confirm Password"),
                            filled: true,
                            // border: OutlineInputBorder(),
                            fillColor: Color(0xFFF1F1F1),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue.shade400)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                          )),
                      )
                  ),
                  SizedBox(
                    height: HeightBody * 0.06,
                  ),
                 Obx(() =>  ElevatedButton(
                      onPressed: () {
                        controller.login();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                        child: controller.loading.value?CircularProgressIndicator():Text(
                          'Login',
                          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20,color: Colors.black),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(shape: StadiumBorder(), backgroundColor: Color(0xFFF1F1F1))))
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
