import 'package:flutter/material.dart';
import 'package:flutter_authentification/services/auth.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    _emailController.text = "zaky@gmail.com";
    _passwordController.text = "password";
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                validator: (value) =>
                    value!.isEmpty ? "enter valide Email" : null,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _passwordController,
                validator: (value) =>
                    value!.isEmpty ? "enter the password" : null,
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                onPressed: () {
                  Map cerdantials = {
                    "email": _emailController.text,
                    "password": _passwordController.text,
                    "device_name": "web"
                  };
                  if (_formkey.currentState!.validate()) {
                    // print(cerdantials);
                    Provider.of<Auth>(context, listen: false)
                        .login(cerdantials);

                    Navigator.pop(context);
                  }
                },
                child: const Text('logIn'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
