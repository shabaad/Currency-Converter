import 'dart:typed_data';

import 'package:currency_converter/functions/fetchrates.dart';
import 'package:currency_converter/views/user_view.dart';
import 'package:flutter/material.dart';

class Result {
  static String answer = '';
}

class ConvertTab extends StatefulWidget {
  final rates;

  const ConvertTab({
    Key? key,
    required this.rates,
  }) : super(key: key);

  @override
  State<ConvertTab> createState() => _ConvertTabState();
}

class _ConvertTabState extends State<ConvertTab> {
  TextEditingController amountController = TextEditingController();
  var items = [
    'USD',
    'INR',
    'EUR',
  ];
  String dropdownValue1 = 'INR';
  String dropdownValue2 = 'USD';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text(
          'Currency Converter',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 256,
          width: 328,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade600,
                spreadRadius: 1,
                blurRadius: 10,
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
                const Text('Amount'),
                const SizedBox(
                  height: 6,
                ),
                SizedBox(
                  height: 40,
                  width: 296,
                  child: TextFormField(
                      onChanged: (String typedValue) {
                        setState(() {
                          if (typedValue.isNotEmpty) {
                            Result.answer = convertCurrency(
                                widget.rates,
                                amountController.text,
                                dropdownValue1,
                                dropdownValue2);
                          } else {
                            amountController.clear();
                          }
                        });
                      },
                      key: ValueKey('amount'),
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 10, left: 10),
                          suffixIcon: Container(
                            width: 96,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(color: Color(0xFF314870)),
                            child: DropdownButton(
                              isExpanded: true,
                              dropdownColor: Color(0xFF314870),
                              style: TextStyle(color: Colors.white),
                              underline: SizedBox(),
                              value: dropdownValue1,
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                              ),
                              items:
                                  items.map<DropdownMenuItem<String>>((value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue1 = newValue!;
                                  Result.answer = convertCurrency(
                                      widget.rates,
                                      amountController.text,
                                      dropdownValue1,
                                      dropdownValue2);
                                });
                              },
                            ),
                          ),
                          border: OutlineInputBorder())),
                ),
                SizedBox(
                  height: 25,
                ),
                Text('Convert to'),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 200,
                      color: Color(0xFFEEF1F1),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, top: 12),
                        child: amountController.text.isEmpty
                            ? const Text('')
                            : Text(Result.answer),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 96,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Color(0xFF314870)),
                      child: DropdownButton(
                        isExpanded: true,
                        dropdownColor: Color(0xFF314870),
                        style: TextStyle(color: Colors.white),
                        underline: SizedBox(),
                        // Initial Value
                        value: dropdownValue2,

                        // Down Arrow Icon
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),

                        // Array list of items
                        items: items.map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue2 = newValue!;
                            Result.answer = convertCurrency(
                                widget.rates,
                                amountController.text,
                                dropdownValue1,
                                dropdownValue2);
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF06D6A0),
                    minimumSize: const Size.fromHeight(40), // NEW
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserPage()),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text('Next'),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        // <-- Icon
                        Icons.arrow_right_alt_outlined,
                        size: 24.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
