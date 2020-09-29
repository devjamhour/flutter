import 'package:flutter/material.dart';
import 'package:linkatech_ff/app/sign_in/email_sign_in_form_bloc_based.dart';
import 'package:linkatech_ff/app/sign_in/email_sign_in_form_stateful.dart';
import 'package:linkatech_ff/services/auth.dart';

class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acessar'),
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: EmailSignInFormBlocBased.create(context),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
