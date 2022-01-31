import 'package:flutter/material.dart';
import 'package:note_app/features/auth/widgets/password_viewmodel.dart';
import 'package:note_app/shared/validators/validators.dart';
import 'create_account_viewmodel.dart';
import 'widgets/custom_button_widget.dart';
import 'widgets/custom_form_field_widget.dart';
import 'widgets/custom_text_button_widget.dart';
import 'widgets/logo_widget.dart';
import 'widgets/password_text_field_widget.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
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
    final _passwordViewModel = PasswordViewModel();
    final _viewModel = CreateAccountViewModel(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: size.width,
            height: size.height,
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey, //_viewModel.createAccountKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LogoWidget(size: 40),
                  SizedBox(height: size.height * .05),
                  CustomFormFieldWidget(
                    icon: Icons.person,
                    controller: _viewModel.nameController,
                    hint: 'Nome',
                    validator: (name) => _validators.validateName(name),
                  ),
                  SizedBox(height: size.height * .05),
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
                  SizedBox(height: size.height * .12),
                  CustomButtonWidget(
                    title: 'Criar conta',
                    onPressed: () => _viewModel.createAccount(_formKey),
                  ),
                  CustomTextButtonWidget(
                    onPressed: () {
                      _viewModel.navigatorPop();
                    },
                    title: 'Já possui uma conta? Acesse já!',
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
