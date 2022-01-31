import 'package:flutter/material.dart';
import 'package:note_app/features/splash/splash_viewmodel.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final SplashViewModel _viewModel;
  @override
  void didChangeDependencies() {
    _viewModel = SplashViewModel(context);
    _viewModel.navigator();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.white30,
        ),
      ),
    );
  }
}
