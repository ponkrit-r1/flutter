import 'dart:async';
import 'package:deemmi/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:deemmi/core/theme/app_colors.dart'; // Replace with actual import path
import 'package:get/get.dart';

class OTPVerificationPage extends StatefulWidget {
  const OTPVerificationPage({Key? key}) : super(key: key);

  @override
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final List<TextEditingController> _otpControllers =
      List.generate(5, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(5, (_) => FocusNode());
  Timer? _timer;
  int _secondsRemaining = 59;
  String? email;
  bool _isOtpIncorrect = false;
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    email = Get.arguments['email']; // Retrieve email from arguments
    _startTimer();

    // Automatically focus on the first input field when the page is loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  void _validateOTP() {
    final enteredOtp = _otpControllers.map((c) => c.text).join();
    setState(() {
      _isOtpIncorrect = (enteredOtp == '11111'); // Mock check for incorrect OTP
      _isButtonEnabled =
          !_isOtpIncorrect && enteredOtp.length == 5; // Enable only if correct
    });
  }

  void _checkOTPComplete() {
    final isAllFieldsFilled =
        _otpControllers.every((controller) => controller.text.isNotEmpty);
    setState(() {
      if (isAllFieldsFilled) {
        _validateOTP(); // Automatically validate OTP when all fields are filled
      } else {
        _isButtonEnabled = false; // Disable button if fields are not all filled
      }
    });
  }

  void _resendOTP() {
    setState(() {
      _secondsRemaining = 59;
      _startTimer();
      _isOtpIncorrect = false;
      _isButtonEnabled = false;
      for (var controller in _otpControllers) {
        controller.clear();
      }
    });

    // Re-focus the first input field after clearing
    _focusNodes[0].requestFocus();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.homeBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'User verification',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'OTP has been sent to\n',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                        height: 1.5,
                      ),
                    ),
                    TextSpan(
                      text: '$email',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        height: 1.5,
                      ),
                    ),
                    const TextSpan(
                      text: ', please fill in\nthe OTP below',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (index) {
                return SizedBox(
                  width: 45,
                  height: 45,
                  child: TextField(
                    controller: _otpControllers[index],
                    focusNode: _focusNodes[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: '_',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 24,
                        height: 1.2,
                      ),
                      contentPadding: const EdgeInsets.only(bottom: 12),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: _isOtpIncorrect
                              ? Colors.red
                              : const Color.fromARGB(255, 200, 198, 198),
                          width: 1.0, // adjust thickness
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: _isOtpIncorrect
                              ? Colors.red
                              : const Color.fromARGB(
                                  255, 200, 198, 198), // Color when focused
                          width: 2.0,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                    ),
                    textAlignVertical: TextAlignVertical.center,
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 4) {
                        FocusScope.of(context).nextFocus();
                      } else if (value.isEmpty && index > 0) {
                        FocusScope.of(context).previousFocus();
                      }
                      _checkOTPComplete();
                    },
                    onSubmitted: (value) {
                      if (value.isEmpty && index > 0) {
                        _otpControllers[index - 1].clear();
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                );
              }),
            ),
            if (_isOtpIncorrect)
              const Padding(
                padding: EdgeInsets.only(left: 16.0, top: 8),
                child: Text(
                  '* OTP is incorrect',
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
            const SizedBox(height: 30),
           ElevatedButton(
              onPressed: _isButtonEnabled
                  ? () {
  
                      _validateOTP(); // Call  OTP validation logic
                      // Show popup dialog if OTP is valid
                      if (!_isOtpIncorrect) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              contentPadding: const EdgeInsets.all(20),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                   SizedBox(
                                    width: 70, // Adjust as needed
                                    height: 70,
                                    child: ClipOval(
                                      child: Image.asset(
                                        'assets/icons/icon_check.png', // Path to your image asset
                                        fit: BoxFit.cover,
                                        width: 70, // Adjust as needed
                                        height: 70, // Adjust as needed
                                      ),
                                    ),
                                  ),
                                 const  SizedBox(height: 20),
                                 const Text(
                                    'Your email has been updated',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                 const SizedBox(height: 20),
                            SizedBox(
                                    width: double
                                        .infinity, // Makes the button take the full width of the popup
                                    child: ElevatedButton(
                                      onPressed: () {
                                        try {
                                          Get.toNamed(Routes.account_setting);
                                        } catch (e) {
                                          print("Navigation error: $e");
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                       backgroundColor:
                                            const Color(0xFF2563EB),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                      ),
                                      child: const Text(
                                        'Close',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            );
                          },
                        );
                      }

                    }
                  : null,
                 
              style: ElevatedButton.styleFrom(
                backgroundColor: _isButtonEnabled ? const Color(0xFF2563EB) : Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'Confirm',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.timer, color: Colors.grey[600]),
                const SizedBox(width: 5),
                Text(
                  '0:${_secondsRemaining.toString().padLeft(2, '0')}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(width: 20),
                TextButton(
                  onPressed: _secondsRemaining == 0 ? _resendOTP : null,
                  child: Text(
                    'Resend OTP',
                    style: TextStyle(
                      color: _secondsRemaining == 0 ? Colors.blue : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
