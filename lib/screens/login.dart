// @dart=2.9
import 'package:feelathomeproject/util/styles.dart';
import 'package:feelathomeproject/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../util/background.dart';
import '../util/widgets.dart';
import '../view_models/base_view_model.dart';
import '../view_models/user_view_model.dart';
import '../widgets/loading_widget.dart';
import 'forgot_password.dart';
import 'home_screen.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = new GlobalKey<FormState>();
  UserViewModel _userViewModel;
  String _username, _password;

  @override
  void initState() {
    super.initState();
    _userViewModel = Provider.of<UserViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    // AuthProvider auth = Provider.of<AuthProvider>(context);
    final forgotLabel = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.only(right: 10.0)),
          child: const Text(
            "Forgot password ?",
            style: TextStyle(
                fontFamily: 'Roboto', color: Colors.white, fontSize: 10),
            textAlign: TextAlign.right,
          ),
          onPressed: () async {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => ForgotPassword()),
                (Route<dynamic> route) => false);
          },
        ),
      ],
    );
    final LoginLabel = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Login",
              style: TextStyle(
                  fontFamily: 'Roboto', color: Colors.white, fontSize: 20)),
        ),
      ],
    );

    final LoginButton = Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.only(left: 50.0, right: 50.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0))),
                overlayColor: MaterialStateProperty.all(GreenHi),
                backgroundColor: MaterialStateProperty.all(GreenHi),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Text("Login",
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.white,
                            fontSize: 20)),
                  ),
                ],
              ),
              onPressed: () async {
                if (formKey.currentState.validate()) {
                  var res = false;
                  res = await _userViewModel.login();
                  if (res) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => HomeScreen(0)),
                        (Route<dynamic> route) => false);
                  }
                }
              },
            ),
          ),
        ],
      ),
    );

    return SafeArea(
      child: Stack(
        children: [
          backgroundDash(),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              toolbarHeight: 100,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => HomeScreen(0)),
                    (Route<dynamic> route) => false),
              ),
              centerTitle: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  child: Container(
                    padding: EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        Form(
                            key: formKey,
                            child: Consumer<UserViewModel>(
                                builder: (context, model, child) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _logoUi(),
                                  const SizedBox(height: 60.0),
                                  const SizedBox(height: 5.0),
                                  LoginLabel,
                                  const SizedBox(height: 10.0),
                                  _usernameField(model),
                                  const SizedBox(height: 20.0),
                                  const SizedBox(height: 5.0),
                                  _passwordField(model),
                                  forgotLabel,
                                  LoginButton,
                                ],
                              );
                            })),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _logoUi() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      child: Image.asset(
                        "assets/images/logo.png",
                        height: 100.0,
                        width: 100.0,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 0.0, right: 0.0, top: 10.0),
                      child: const Text(
                        'Feel At Home',
                        style: TextStyle(
                            fontFamily: 'kistalbld',
                            color: Colors.white,
                            fontSize: 20),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 1.0),
                      child: Text(
                        "Guardian far from home",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'kistalitl',
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 19.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _usernameField(UserViewModel model) {
    return TextFormField(
        autofocus: false,
        //validator: validateEmail,
        onSaved: (value) => _username = value,
        //  controller:
        //     TextEditingController(text: model.userModel?.customer?.name ?? ""),
        onChanged: (value) {
          _userViewModel.userModel.customer.name = value;
        },
        validator: (value) =>
            value.isValidEmail() ? null : "Please enter a valid email address",
        //decoration: buildInputDecoration("Username", Icons.email),
        decoration: buildInputDecoration("Email", Icons.person));
  }

  Widget _passwordField(UserViewModel model) {
    return TextFormField(
        autofocus: false,
        obscureText: true,
        onChanged: (value) {
          _userViewModel.userModel.customer.password = value;
        },
        validator: (value) =>
            value.isEmpty ? "Please enter your password" : null,
        onSaved: (value) => _password = value,
        decoration: buildInputDecoration("Password", Icons.lock));
  }
}
