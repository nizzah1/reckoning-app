import 'package:flutter/material.dart';
import 'package:flutterApp/blocs/blocs.dart';
import 'package:flutterApp/pages/pages.dart';
import 'package:flutterApp/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:numeric_keyboard/numeric_keyboard.dart';

class OtpPage extends StatefulWidget {
  static const routeName = '/OtpPage';

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {

  String text = '';

  void _onKeyboardTap(String value) {
    setState(() {
      text = text + value;
    });
  }

  Widget otpNumberWidget(int position) {
    try {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))
        ),
        child: Center(child: Text(text[position], style: TextStyle(color: Colors.black),)),
      );
    } catch (e) {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateAuthenticated) {
          Navigator.of(context)
              .pushNamed(HomePage.routeName);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: MyColors.primaryColorLight.withAlpha(20),
                ),
                child: Icon(Icons.arrow_back_ios, color: MyColors.primaryColor, size: 16,),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            elevation: 0,
            backgroundColor: Colors.white,
            brightness: Brightness.light,
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                                margin: const EdgeInsets.symmetric(horizontal: 20),
                                child: Text('Enter 6 digits verification code sent to your number', style: TextStyle(color: Colors.black, fontSize: 26, fontWeight: FontWeight.w500))
                            ),
                            Container(
                              constraints: const BoxConstraints(
                                  maxWidth: 500
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  otpNumberWidget(0),
                                  otpNumberWidget(1),
                                  otpNumberWidget(2),
                                  otpNumberWidget(3),
                                  otpNumberWidget(4),
                                  otpNumberWidget(5),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        constraints: const BoxConstraints(
                            maxWidth: 500
                        ),
                        child: RaisedButton(
                          onPressed: () {
                            BlocProvider.of<AuthBloc>(context).add(AuthEventValidatePhoneNumber(smsCode: text));
                          },
                          color: MyColors.primaryColor,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(14))
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Confirm', style: TextStyle(color: Colors.white),),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                                    color: MyColors.primaryColorLight,
                                  ),
                                  child: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16,),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      NumericKeyboard(
                        onKeyboardTap: _onKeyboardTap,
                        textColor: MyColors.primaryColorLight,
                        rightIcon: Icon(
                          Icons.backspace,
                          color: MyColors.primaryColorLight,
                        ),
                        rightButtonFn: () {
                          setState(() {
                            text = text.substring(0, text.length - 1);
                          });
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}