import 'package:currency_converter/components/convert_tab.dart';
import 'package:currency_converter/functions/post_user.dart';
import 'package:currency_converter/models/user_model.dart';
import 'package:currency_converter/views/thankyou_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';

class UserPage extends StatefulWidget {
  final Result? answer;
  UserPage({Key? key, this.answer}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  UserModel? _userModel;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF37517E),
              Color(0xFF253755),
            ],
          )),
          height: 568,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 72),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'Data Submitter',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 21,
                  ),
                  Container(
                    height: 256,
                    width: 328,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade600,
                          spreadRadius: 2,

                          offset: const Offset(0, 5),
                        )
                      ],
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Name'),
                          const SizedBox(
                            height: 6,
                          ),
                          SizedBox(
                            height: 40,
                            width: 296,
                            child: TextFormField(
                                validator: (String? name) {
                                  if (nameController.text.length < 2) {
                                    return 'Must have atleast three characters.';
                                  }
                                },
                                controller: nameController,
                                decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.all(12),
                                    border: OutlineInputBorder())),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text('Email'),
                          SizedBox(
                            height: 6,
                          ),
                          SizedBox(
                            width: 296,
                            height: 40,
                            child: TextFormField(
                                validator: (email) => email != null &&
                                        !EmailValidator.validate(email)
                                    ? 'Please enter valid email'
                                    : null,
                                controller: emailController,
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(bottom: 10, left: 10),
                                    border: OutlineInputBorder())),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF06D6A0),
                              minimumSize: const Size.fromHeight(40),
                            ),
                            onPressed: () async {
                              final isValidForm =
                                  formKey.currentState!.validate();
                              //          if (isValidForm) {
                              String name = nameController.text;
                              String email = emailController.text;
                              if (name.isEmpty || email.isEmpty) {
                                showDialog(
                                    context: context,
                                    builder: (ctx1) {
                                      return AlertDialog(
                                        title: const Text(
                                            'Please provide full details'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(ctx1).pop();
                                              },
                                              child: const Text('Close'))
                                        ],
                                      );
                                    });
                              } else {
                                var answerwidget = widget.answer;
                                UserModel? data = await submitData(
                                    name, email, answerwidget.toString());
                                setState(() {
                                  _userModel = data;
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ThankYouPage()),
                                );
                                //}
                              }
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Submit'),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
