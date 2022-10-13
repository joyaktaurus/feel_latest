// @dart=2.9
import 'package:feelathomeproject/Screens/login.dart';
import 'package:feelathomeproject/util/styles.dart';
import 'package:feelathomeproject/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../util/background.dart';
import '../util/widgets.dart';
import '../view_models/base_view_model.dart';
import '../view_models/user_view_model.dart';
import '../widgets/loading_widget.dart';
import 'home_screen.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formKey = new GlobalKey<FormState>();
  UserViewModel _userViewModel;
  String _email;

  @override
  void initState() {
    super.initState();
    _userViewModel = Provider.of<UserViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    // AuthProvider auth = Provider.of<AuthProvider>(context);

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Authenticating ... Please wait")
      ],
    );

    final forgotLabel = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        TextButton(
          style:  TextButton.styleFrom(
          padding: EdgeInsets.only(right: 10.0)),
          child: Text(
            "Fogot password ?",
            style: TextStyle(
                fontFamily: 'Roboto', color: Colors.white, fontSize: 10),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
    final LoginLabel = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Fogot Password",
              style: TextStyle(
                  fontFamily: 'Roboto', color: Colors.white, fontSize: 15)),
        ),
      ],
    );

    final LoginButton = Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.only(left: 50.0, right: 50.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0))),
                overlayColor: MaterialStateProperty.all(GreenHi),
                backgroundColor: MaterialStateProperty.all(GreenHi),
              ),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Text("Submit",
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.white,
                            fontSize: 20)),
                  ),
                ],
              ),
              onPressed: () async {
                if (formKey.currentState.validate()) {
                  print("formkey");
                  var res = false;
                  res = await _userViewModel.forgot(_email);
                  if (res) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => Login()),
                            (Route<dynamic> route) => false);
                  }
                }
              },
            ),
          ),
        ],
      ),
    );

    /*  var doLogin = () {
      final form = formKey.currentState;

      if (form.validate()) {
        form.save();

        final Future<Map<String, dynamic>> successfulMessage =
            auth.login(_username, _password);

        successfulMessage.then((response) {
          if (response['status']) {
            User user = response['user'];
            Provider.of<UserProvider>(context, listen: false).setUser(user);
            Navigator.pushReplacementNamed(context, '/dashboard');
          } else {
            Flushbar(
              title: "Failed Login",
              message: response['message']['message'].toString(),
              duration: Duration(seconds: 3),
            ).show(context);
          }
        });
      } else {
        print("form is invalid");
      }
    };*/

    return SafeArea(
      child: Stack(
        children: [
          backgroundDash(),
          Scaffold(
            backgroundColor: Colors.transparent,
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
                                return  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 50.0),
                                        _logoUi(),
                                        SizedBox(height: 60.0),
                                        SizedBox(height: 5.0),
                                        LoginLabel,
                                        SizedBox(height: 10.0),
                                        _usernameField(model),
                                        SizedBox(height: 20.0),
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
    onPressed() {}
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
                    Padding(
                      padding: const EdgeInsets.only(top: 1.0),
                      child: const Text(
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
        onSaved: (value) => _email = value,
      //  controller:
       //     TextEditingController(text: model.userModel?.customer?.name ?? ""),
        onChanged: (value) {
          _email = value;
        },
        validator: (value) => value.isValidEmail() ? null : "Please enter a valid email address",
        //decoration: buildInputDecoration("Username", Icons.email),
        decoration: buildInputDecoration("Email", Icons.mail_outline));
  }
}
