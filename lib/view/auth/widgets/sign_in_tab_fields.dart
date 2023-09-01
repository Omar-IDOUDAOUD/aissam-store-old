import 'package:aissam_store/services/auth/auth_result.dart';
import 'package:aissam_store/view/auth/widgets/email_field.dart';
import 'package:aissam_store/view/auth/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignInTabFields extends StatelessWidget {
  const SignInTabFields({
    super.key,
    required this.emailC,
    required this.passwordC,
    this.authResult,
  });

  final TextEditingController emailC, passwordC;
  final AuthResult? authResult;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        children: [
          EmailField(
            controller: emailC,
            errorMessage: authResult != null ? authResult!.emailWrongMsg : null,
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: PasswordField(
                  controller: passwordC,
                  errorMessage:
                      authResult != null ? authResult!.passwordWrongMsg : null,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              _getFingerprintPasswordButton(),
            ],
          )
        ],
      ),
    );
  }

  Widget _getFingerprintPasswordButton() {
    return SizedBox.square(
      dimension: 56,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: SvgPicture.asset(
          'assets/icons/fingerprint-icon.svg',
          width: 20,
          height: 20,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
