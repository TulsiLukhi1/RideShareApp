import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rideshare/Auth/signupscreen.dart';
import 'package:rideshare/MainScreen/main_screen.dart';
import '../Utills/utills.dart';
import '../Widgets/mybutton.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  final _auth = FirebaseAuth.instance;

  void login() {
    setState(() {
      isLoading = true;
    });
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
      setState(() {
        isLoading = false;
      });

      Utills().toastSuccessMessage("Login is successful!");

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => MainScreen()));
    }).catchError((error) {
      Utills().toastFaiureMessage(error.message);
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            child: Column(children: [
              const SizedBox(
                height: 0,
              ),
              const Image(
                height: 250,
                image: AssetImage("assets/images/signUp.jpg"),
              ),
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.fromLTRB(26, 10, 0.0, 0.0),
                    child: Text(
                      "Hello There 😃",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.indigo,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                width: 320.0,
                height: 350.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, 15.0),
                        blurRadius: 15.0),
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, -10.0),
                        blurRadius: 10.0)
                  ],
                ),
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter email";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                          labelText: 'EMAIL',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          prefixIcon: Icon(Icons.alternate_email),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter password";
                        } else {
                          return null;
                        }
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                          labelText: 'PASSWORD ',
                          prefixIcon: Icon(Icons.lock),
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                    ),
                    const SizedBox(height: 40.0),
                    MyElevatedButton(
                      width: 250,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          login();
                        }
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, letterSpacing: 1),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpPage()));
                            },
                            child: const Text("Create"))
                      ],
                    )
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
