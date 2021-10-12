import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/login/login_view_model.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/dumb_widgets/login_text_editors.dart';
import 'package:stacked/stacked.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (BuildContext context, LoginViewModel viewModel, Widget _) {
        return Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            color: Theme.of(context).buttonColor,
            child: SingleChildScrollView(
              child: Form(
                key: viewModel.formKey,
                child: Column(children: [
                  SizedBox(
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset("assets/images/cap.png"),
                      Image.asset("assets/images/layer_tata.png")
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          new BoxShadow(blurRadius: 1.0, color: appbarcolor)
                        ],
                        border: Border.all(width: 2.5, color: appbarcolor),
                        shape: BoxShape.rectangle,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10.0,
                            ),
                            Image.asset("assets/images/hitachi_font.png"),
                            Image.asset("assets/images/font_login.png"),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: LoginTextField(
                                controller: viewModel.usernameController,
                                validator: (email) {
                                  if (email.isEmpty ||
                                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(email)) {
                                    return "Enter a Email ID";
                                  }
                                  return null;
                                },
                                hint: 'Email ID',
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: LoginTextField(
                                obsecure: true,
                                controller: viewModel.passwordController,
                                validator: (pass) {
                                  if (pass.isEmpty) {
                                    return "Enter a Password";
                                  }
                                  return null;
                                },
                                hint: 'Password',
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InsiteRichText(
                              content: 'Forgot Password ?',
                              textColor: maptextcolor,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            viewModel.loading
                                ? Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        boxShadow: [
                                          new BoxShadow(
                                              blurRadius: 1.0, color: tango)
                                        ],
                                        border: Border.all(
                                            width: 2.5, color: tango),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: InsiteProgressBar(),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: InsiteButton(
                                      title: 'SIGN IN',
                                      onTap: () {
                                        var username =
                                            viewModel.usernameController.text;
                                        var password =
                                            viewModel.passwordController.text;
                                        viewModel.getLoginData(
                                            username, password);
                                        viewModel.submit();
                                      },
                                      //width: MediaQuery.of(context).size.width*0.350,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      textColor: appbarcolor,
                                    ),
                                  )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        "assets/images/crane_small_login.png",
                        width: 123,
                        height: 70,
                      ),
                      Image.asset(
                        "assets/images/jcp_login.png",
                        width: 143,
                        height: 70,
                      ),
                      Image.asset(
                        "assets/images/crane_large_login.png",
                        width: 123,
                        height: 60,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        "assets/images/tractor_login.png",
                        width: 123,
                        height: 70,
                      ),
                      Image.asset(
                        "assets/images/lorry_login.png",
                        width: 143,
                        height: 70,
                      ),
                      Image.asset(
                        "assets/images/lorry_large_login.png",
                        width: 123,
                        height: 60,
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}
