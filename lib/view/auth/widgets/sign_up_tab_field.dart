import 'package:aissam_store/services/auth/auth_result.dart';
import 'package:aissam_store/view/auth/widgets/email_field.dart';
import 'package:aissam_store/view/auth/widgets/password_field.dart';
import 'package:aissam_store/view/auth/widgets/phone_number_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignUpTabFields extends StatelessWidget {
  const SignUpTabFields({
    super.key,
    required this.emailC,
    required this.phoneNumberC,
    required this.passwordC,
    this.authResult,
  });

  final TextEditingController emailC, phoneNumberC, passwordC;
  final AuthResult? authResult;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        children: [
          EmailField(
            controller: emailC,
            errorOccure: authResult != null ? authResult!.emailWrong : false,
          ),
          SizedBox(height: 10),
          PhoneNumberField(
            controller: phoneNumberC,
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: PasswordField(
                  controller: passwordC,
                  errorOccure:
                      authResult != null ? authResult!.passwordWrong : false,
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
