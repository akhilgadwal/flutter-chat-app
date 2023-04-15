import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitData);
  final void Function(String useremail, String username, String userpassword,
      bool isLogin, BuildContext context) submitData;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
  var isLogin = true;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  String _useremail = '';

  String _username = '';

  String _userpassword = '';

  // void _trysubmit() {
  //   final isvalid = _formkey.currentState?.validate();
  //   FocusScope.of(context).unfocus();
  //   if (isvalid!) {
  //     _formkey.currentState!.save();
  //     widget.submitData(_useremail, _username, _userpassword, isLogin, context);
  //   }
  // }
  void submitForm() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, save the form data
      _formKey.currentState!.save();

      // Do something with the form data, such as sending it to a server or storing it locally
      // Example: print the form data to the console
      widget.submitData(_useremail, _username, _userpassword, isLogin, context);

      // Reset the form
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  key: const ValueKey('email'),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please enter valid your email';
                    }
                    // Add additional validation here if needed.
                    return null;
                  },
                  onSaved: (value) {
                    _useremail = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                if (!isLogin)
                  TextFormField(
                    key: const ValueKey('name'),
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 4) {
                        return 'Please enter your username user 4 letter';
                      }
                      // Add additional validation here if needed.
                      return null;
                    },
                    onSaved: (value) {
                      _username = value!;
                    },
                  ),
                const SizedBox(height: 16.0),
                TextFormField(
                  key: const ValueKey('password'),
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (value) {
                    if (value!.isEmpty || value.length < 7) {
                      return 'Please enter your password';
                    }
                    // Add additional validation here if needed.
                    return null;
                  },
                  onSaved: (value) {
                    _userpassword = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: submitForm,
                  child: Text(isLogin ? 'Login' : 'SingUp'),
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    child: Text(isLogin
                        ? 'Create new acount'
                        : 'I alreay have an account'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
