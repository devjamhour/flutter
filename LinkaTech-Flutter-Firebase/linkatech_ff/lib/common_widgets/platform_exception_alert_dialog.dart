import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:linkatech_ff/common_widgets/platform_alert_dialog.dart';

class PlatformExceptionAlertDialog extends PlatformAlertDialog {
  PlatformExceptionAlertDialog({
    @required String title,
    @required PlatformException exception,
  }) : super(
          title: title,
          content: _message(exception),
          defaultActionText: 'OK',
        );

  static String _message(PlatformException exception) {
    print(exception);
    if (exception.message == 'FIRFirestoreErrorDomain') {
      if (exception.code == 'PERMISSION_DENIED') {
        return 'Falha de permissão';
      }
    }
    return _errors[exception.code] ?? exception.message;
  }

  static Map<String, String> _errors = {
    // ERROR_WEAK_PASSWORD
    // ERROR_INVALID_CREDENTIAL
    // ERROR_EMAIL_ALREADY_IN_USE
    // ERROR_INVALID_EMAIL
    'ERROR_WRONG_PASSWORD': 'Senha inválida',
    // ERROR_USER_NOT_FOUND
    // ERROR_USER_DISABLED
    // ERROR_TOO_MANY_REQUESTS
    // ERROR_OPERATION_NOT_ALLOWED
    // 'PERMISSION_DENIED'
  };
}
