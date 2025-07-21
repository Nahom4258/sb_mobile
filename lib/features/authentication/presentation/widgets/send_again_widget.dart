import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:async';

import '../../../features.dart';

class SendAgainWidget extends StatefulWidget {
  const SendAgainWidget({
    super.key,
    required this.emailOrPhoneNumber,
  });

  final String emailOrPhoneNumber;

  @override
  _SendAgainWidgetState createState() => _SendAgainWidgetState();
}

class _SendAgainWidgetState extends State<SendAgainWidget> {
  late Timer _timer;
  late Timer _cooldownTimer;
  int _start = 60;
  bool _isButtonEnabled = false;
  int _resendAttempts = 0;
  bool _isCooldownActive = false;
  int _cooldownStart = 600;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    if (_cooldownTimer.isActive) _cooldownTimer.cancel();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _isButtonEnabled = false;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_start > 0) {
          _start--;
        } else {
          _isButtonEnabled = true;
          _timer.cancel();
        }
      });
    });
  }

  void _startCooldownTimer() {
    setState(() {
      _isCooldownActive = true;
    });

    _cooldownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_cooldownStart > 0) {
          _cooldownStart--;
        } else {
          _isCooldownActive = false;
          _resendAttempts = 0;
          _cooldownStart = 600;
          _cooldownTimer.cancel();
        }
      });
    });
  }

  void _resendOtp() {
    if (_resendAttempts < 5) {
      context.read<AuthenticationBloc>().add(
            ResendOtpVerificationEvent(
              emailOrPhoneNumber: widget.emailOrPhoneNumber,
            ),
          );
      setState(() {
        _start = 60;
        _resendAttempts++;
        _startTimer();
      });
    }

    if (_resendAttempts >= 5) {
      _startCooldownTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: _isButtonEnabled && !_isCooldownActive
              ? () {
                  _resendOtp();
                }
              : null,
          child: Text(
            _isCooldownActive
                ? '${AppLocalizations.of(context)!.send_again} (${(_cooldownStart ~/ 60).toString().padLeft(2, '0')}:${(_cooldownStart % 60).toString().padLeft(2, '0')})'
                : _isButtonEnabled
                    ? AppLocalizations.of(context)!.send_again
                    : '${AppLocalizations.of(context)!.send_again} ($_start)',
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: _isButtonEnabled && !_isCooldownActive
                  ? const Color(0xFF18786A)
                  : Colors.grey,
            ),
          ),
        ),
        if (_resendAttempts >= 5 && _isCooldownActive)
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              AppLocalizations.of(context)!.you_have_reached_the_limit,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.red,
              ),
            ),
          ),
      ],
    );
  }
}
