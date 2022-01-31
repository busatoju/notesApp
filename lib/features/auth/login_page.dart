import 'package:flutter/material.dart';
import 'package:note_app/features/auth/login_viewmodel.dart';
import 'package:note_app/features/auth/widgets/password_viewmodel.dart';
import 'package:note_app/shared/validators/validators.dart';
import 'widgets/custom_button_widget.dart';
import 'widgets/custom_form_field_widget.dart';
import 'widgets/custom_text_button_widget.dart';
import 'widgets/logo_widget.dart';
import 'widgets/password_text_field_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final Validators _validators;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();

    _validators = Validators();
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _viewModel = LoginViewModel(context);
    final _passwordViewModel = PasswordViewModel();

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: size.width,
            height: size.height,
            padding: EdgeInsets.all(size.width * .05),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LogoWidget(size: 40),
                  SizedBox(height: size.height * .1),
                  CustomFormFieldWidget(
                    icon: Icons.mail,
                    controller: _viewModel.emailController,
                    hint: 'E-mail',
                    validator: (email) => _validators.validateEmail(email),
                  ),
                  SizedBox(height: size.height * .05),
                  AnimatedBuilder(
                      animation: _passwordViewModel,
                      builder: (context, child) {
                        return PasswrodTextFieldWidget(
                          showPassword: _passwordViewModel.showPassword,
                          controller: _viewModel.passwordController,
                          isObscure: _passwordViewModel.isObscure,
                          validator: (password) =>
                              _validators.validatePassword(password),
                        );
                      }),
                  SizedBox(height: size.height * .1),
                  CustomButtonWidget(
                    title: 'Acessar',
                    onPressed: () => _viewModel.signIn(_formKey),
                  ),
                  CustomTextButtonWidget(
                    onPressed: _viewModel.navigatorCreateAccount,
                    title: 'Ainda não possui uma conta? Cadastre-se!',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
