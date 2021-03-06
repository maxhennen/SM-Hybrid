import 'package:flutter/material.dart';
import 'package:silent_disco/DJScreens/AdminRegisterScreen.dart';
import 'package:silent_disco/DJScreens/DJEventsScreen.dart';
import 'package:silent_disco/main.dart';

import 'FirebaseAuth.dart';

void main() {
  runApp(new DjSignInScreen());
}

class DjSignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Generated App',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2196f3),
        accentColor: const Color(0xFF2196f3),
        canvasColor: const Color(0xFFfafafa),
      ),
      home: new DjSignIn(),
    );
  }
}

class DjSignIn extends StatefulWidget {
  DjSignIn({this.onSignedIn});

  final VoidCallback onSignedIn;

  @override
  _DjSignInScreenState createState() => new _DjSignInScreenState();
}

class _DjSignInScreenState extends State<DjSignIn> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  final _formKey = new GlobalKey<FormState>();
  final BaseAuth auth = new Auth();

  String _email;
  String _password;
  String _errorMessage;
  bool _isIos;

  @override
  void initState() {
    _errorMessage = "";
    super.initState();
  }

  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Widget _showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Email',
            icon: new Icon(
              Icons.mail,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Password',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }

  Widget _showRegisterButton() {
    return new FlatButton(
      child: new Text("register",
          style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdminRegisterScreen()),
      ),
    );
  }

  Widget _showLoginButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.blue,
            child: new Text('Login',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: _validateAndSubmit,
          ),
        ));
  }

  Widget _showBody() {
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              _showEmailInput(),
              _showPasswordInput(),
              _showLoginButton(),
              _showRegisterButton(),
              _showErrorMessage(),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    _isIos = Theme.of(context).platform == TargetPlatform.iOS;
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Flutter login demo'),
          leading: new IconButton(icon: Icon(Icons.arrow_back), 
              onPressed: () =>
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp())
                )    
          ),
        ),
        body: Stack(
          children: <Widget>[
            _showBody(),
          ],
        ));
  }

  void _validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
    });
    if (_validateAndSave()) {
      String userId = "";
      try {
        userId = await this.auth.signIn(_email, _password);
        print('Signed in: $userId');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DjEventsScreen()));
      } catch (e) {
        print('Error: $e');
        setState(() {
          if (_isIos) {
            _errorMessage = e.details;
          } else
            _errorMessage = e.message;
        });
      }
    }
  }

  Widget _showErrorMessage() {
    if (_errorMessage != "" && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }
}
