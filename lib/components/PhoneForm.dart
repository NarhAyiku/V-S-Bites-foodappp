// import 'package:flutter/material.dart';
// import 'package:foodappp/Navigation.dart/Bottomnavigation.dart';
// import 'package:foodappp/pages/Phone_service.dart';
// import 'package:foodappp/pages/Successfulpage.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'successful.dart';


// class PhoneForm extends StatefulWidget {
//   @override
//   _PhoneFormState createState() => _PhoneFormState();
// }

// class _PhoneFormState extends State<PhoneForm> {
//   final _phoneController = TextEditingController();
//   String _statusMessage = "";

//   Future<void> _submitPhone() async {
//     final phone = _phoneController.text.trim();
//     try {
//       await sendPhoneNumber(phone);
//       // setState(() {
//       //   _statusMessage = "Code sent to $phone";
//       // });
//       SnackBar(
//             content: Text('Code sent to $phone'),
//             backgroundColor: const Color.fromARGB(255, 114, 244, 54),
//             closeIconColor: const Color.fromARGB(255, 255, 255, 255),
//           );
//       _showVerificationDialog(phone); // Show dialog after code sent
//     } catch (e) {
//       setState(() {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('$e'),
//             backgroundColor: Colors.red,
//             closeIconColor: const Color.fromARGB(255, 255, 255, 255),
//           ),
//         );
//         // _statusMessage = e.toString();
//       });
//     }
//   }

//   void _showVerificationDialog(String phone) {
//     final TextEditingController _dialogCodeController = TextEditingController();

//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Center(child:Text('Enter Verification Code'),),
//           content: TextField(
//             controller: _dialogCodeController,
//             keyboardType: TextInputType.number,
//             decoration: InputDecoration(
//               hintText: '4-digit code',
//               border: OutlineInputBorder(),
//             ),
//           ),
//             actions: [
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.orange,
//               foregroundColor: Colors.white,
//               minimumSize: Size(
//                 MediaQuery.of(context).size.width - 40,
//                 50), // Full width minus padding
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 20, vertical: 10),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(30),
//               ),
//               ),
//               child: Text('Verify', style: TextStyle(
//                   fontSize: 18,
//                 color: const Color.fromARGB(255, 255, 255, 255),
//                 fontWeight: FontWeight.bold,
//                 ),),
//               onPressed: () async {
//               final code = _dialogCodeController.text.trim();
//               try {
//                 final isValid = await verifyCode(phone, code);
//                 if (isValid) {
//                 SharedPreferences prefs = await SharedPreferences.getInstance();
//                 await prefs.setBool('isLoggedIn', true);
//                 Navigator.of(context).pop(); 
                
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (_) => Successfullogin()),
//                 );
//                 }
//               } catch (e) {
//                 Navigator.of(context).pop(); // Close dialog
//                 setState(() {
//                 _statusMessage = e.toString();
//                 });
//               }
//               },
//             ),
//             Center(
//               child: TextButton(
//               child: Text(
//                 'Cancel',
//                 style: TextStyle(
//                   fontSize: 16,
//                 color: const Color.fromARGB(255, 0, 0, 0),
//                 fontWeight: FontWeight.bold,
//                 ),
//               ),
//               onPressed: () => Navigator.of(context).pop(),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Text('Phone Verification', style: TextStyle(
//           color: Colors.black,
//           fontWeight: FontWeight.bold,
//         ),),),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Text('Enter your number', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//             SizedBox(height: 5),
//             Text('We will send you a verification code.'),
//             SizedBox(height: 16),
//             PrimaryContainer(
//       radius: 10,
//       child: Row(
//         children: [
//           const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 8.0),
//             child: Row(
//               children: [
//                 Text(
//                   '+233',
//                   style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
//                 ),
//                 Icon(
//                   Icons.arrow_drop_down,
//                   color: Color.fromARGB(255, 0, 0, 0),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             width: 1,
//             height: 40,
//             color: Colors.black,
//           ),
//           Expanded(
//             child: TextFormField(
//               controller: _phoneController,
//               keyboardType: TextInputType.phone,
//               style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
//               decoration: const InputDecoration(
//                 contentPadding:
//                     EdgeInsets.symmetric(vertical: 10, horizontal: 8),
//                 border: InputBorder.none,
//                 hintText: 'Enter your number ',
//                 filled: false,
//                 hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),

//             Spacer(),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _submitPhone,
//                style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.orange,
//                                   minimumSize: Size(
//                                       MediaQuery.of(context).size.width - 40,
//                                       50), // Full width minus padding
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 30, vertical: 20),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(30),
//                                   ),
//                                 ),
//               child: Text('Send Code',
//                 style: const TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 16),),
//             ),
//             SizedBox(height: 24),
//             Text(_statusMessage),
//           ],
//         ),
//       ),
//     );
//   }
// }




// class PrimaryContainer extends StatelessWidget {
//   final Widget child;
//   final double? radius;
//   final Color? color;
//   const PrimaryContainer({
//     super.key,
//     this.radius,
//     this.color,
//     required this.child,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(radius ?? 30),
//         border: Border.all(
//           color: color ?? Colors.grey,
//           width: 1.0,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: color ?? const Color.fromARGB(255, 255, 255, 255),
//           ),
          
//           // const BoxShadow(
//           //   offset: Offset(2, 2),
//           //   blurRadius: 4,
//           //   spreadRadius: 0,
//           //   color: Colors.black,
//           // ),
//         ],
//       ),
//       child: child,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:foodappp/Navigation.dart/Bottomnavigation.dart';
import 'package:foodappp/pages/Phone_service.dart';
import 'package:foodappp/pages/Successfulpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // For JSON decoding
import 'package:http/http.dart' as http; // Make sure to add http dependency in pubspec.yaml

import 'successful.dart';


// Define a simple Country model
class Country {
  final String name;
  final String dialCode;
  final String code; // e.g., US, GH

  Country({required this.name, required this.dialCode, required this.code});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'] as String,
      dialCode: json['dial_code'] as String,
      code: json['code'] as String,
    );
  }
}

// Hypothetical service to fetch country data
class CountryService {
  // You might replace this with an actual API call or a package that provides this data
  // For demonstration, let's use a public API that provides country codes.
  // Example: restcountries.com or specifically a list of phone codes.
  // A simple way to get a list of country codes with dial codes:
  // https://restcountries.com/v3.1/all?fields=name,cca2,idd
  // Note: The structure of the 'idd' object in restcountries.com might require careful parsing.
  // For simplicity, I'll use a hardcoded list or assume a simpler API response structure.
  // Let's use a simpler structure that's common for country code APIs.
  // A good source for phone codes could be a JSON file or a dedicated API.
  // For this example, I'm providing a structure that we'd expect from an API like:
  // [{ "name": "United States", "dial_code": "+1", "code": "US" }, ...]

  Future<List<Country>> fetchCountries() async {
    // This is a placeholder. In a real app, you'd make an HTTP request.
    // Example using a free public API for country codes (might need adjustment based on actual API structure):
    // const url = 'https://restcountries.com/v3.1/all?fields=name,idd,cca2';
    // final response = await http.get(Uri.parse(url));

    // if (response.statusCode == 200) {
    //   List<dynamic> data = json.decode(response.body);
    //   return data.map((json) {
    //     // Parsing logic for restcountries.com 'idd' field might be complex
    //     // as it has 'root' and 'suffixes'. For a simple dial code,
    //     // you'd typically look for a dedicated field or format it.
    //     String dialCode = '';
    //     if (json['idd'] != null && json['idd']['root'] != null) {
    //       dialCode = json['idd']['root'];
    //       if (json['idd']['suffixes'] != null && json['idd']['suffixes'].isNotEmpty) {
    //         dialCode += json['idd']['suffixes'][0]; // Take first suffix, e.g., +12
    //       }
    //     }
    //     return Country(
    //       name: json['name']['common'] as String,
    //       dialCode: dialCode.isNotEmpty ? dialCode : 'N/A', // Handle cases where dial code might be missing
    //       code: json['cca2'] as String,
    //     );
    //   }).where((country) => country.dialCode != 'N/A').toList(); // Filter out invalid
    // } else {
    //   throw Exception('Failed to load countries');
    // }

    // For this demonstration, let's use a hardcoded list to simulate dynamic fetch
    // without requiring an actual API key or complex parsing for an example.
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    return [
      Country(name: 'Ghana', dialCode: '+233', code: 'GH'),
      Country(name: 'United States', dialCode: '+1', code: 'US'),
      Country(name: 'United Kingdom', dialCode: '+44', code: 'GB'),
      Country(name: 'Canada', dialCode: '+1', code: 'CA'),
      Country(name: 'Nigeria', dialCode: '+234', code: 'NG'),
      Country(name: 'Australia', dialCode: '+61', code: 'AU'),
      // Add more countries as needed
    ];
  }
}


class PhoneForm extends StatefulWidget {
  @override
  _PhoneFormState createState() => _PhoneFormState();
}

class _PhoneFormState extends State<PhoneForm> {
  final _phoneController = TextEditingController();
  String _statusMessage = "";
  List<Country> _countries = [];
  Country? _selectedCountry;
  bool _isLoadingCountries = true;

  @override
  void initState() {
    super.initState();
  }


  // Future<void> _fetchCountries() async {
  //   try {
  //     _countries = await CountryService().fetchCountries();
  //     if (_countries.isNotEmpty) {
  //       // Set a default selected country, e.g., Ghana or the first one
  //       _selectedCountry = _countries.firstWhere(
  //         (country) => country.code == 'GH', // Try to find Ghana
  //         orElse: () => _countries.first,    // Otherwise, default to the first
  //       );
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Failed to load countries: $e'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //     _statusMessage = "Error loading countries: $e";
  //   } finally {
  //     setState(() {
  //       _isLoadingCountries = false;
  //     });
  //   }
  // }

  Future<void> _submitPhone() async {
    // if (_selectedCountry == null) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text('Please select a country code.'),
    //       backgroundColor: Colors.orange,
    //     ),
    //   );
    //   return;
    // }
    // print('Selected country: ${_selectedCountry!.name}, Dial code: ${_selectedCountry!.dialCode}');

    // Combine the selected country code and the entered phone number
    // final fullPhoneNumber = "${_selectedCountry!.dialCode}${_phoneController.text.trim()}";
    // final fullPhoneNumber = _phoneController.text.trim();

    try {
      await sendPhoneNumber(_phoneController.text); // Use the combined number
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('phoneNumber', _phoneController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Code sent to $_phoneController.text'),
          backgroundColor: const Color.fromARGB(255, 114, 244, 54),
          closeIconColor: const Color.fromARGB(255, 255, 255, 255),
        ),
      );
      _showVerificationDialog(_phoneController.text); // Show dialog after code sent
    } catch (e) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$e'),
            backgroundColor: Colors.red,
            closeIconColor: const Color.fromARGB(255, 255, 255, 255),
          ),
        );
      });
    }
  }

  void _showVerificationDialog(String phone) {
    final TextEditingController _dialogCodeController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child:Text('Enter Verification Code'),),
          content: TextField(
            controller: _dialogCodeController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '4-digit code',
              border: OutlineInputBorder(),
            ),
          ),
            actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              minimumSize: Size(
                MediaQuery.of(context).size.width - 40,
                50), // Full width minus padding
              padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              ),
              child: Text('Verify', style: TextStyle(
                  fontSize: 18,
                color: const Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.bold,
                ),),
              onPressed: () async {
              final code = _dialogCodeController.text.trim();
              try {
                final isValid = await verifyCode(phone, code);
                if (isValid) {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isLoggedIn', true);
                Navigator.of(context).pop();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => Successfullogin()),
                );
                }
              } catch (e) {
                Navigator.of(context).pop(); // Close dialog
                setState(() {
                _statusMessage = e.toString();
                print('_statusMessage');
                print(_statusMessage);
                });
              }
              },
            ),
            Center(
              child: TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 16,
                color: const Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Phone Verification', style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Enter your number', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text('We will send you a verification code.'),
            SizedBox(height: 16),
            PrimaryContainer(
              radius: 10,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: _isLoadingCountries
                        ? CircularProgressIndicator() // Show loading indicator
                        : DropdownButtonHideUnderline( // Hides the default underline
                            child: DropdownButton<Country>(
                              value: _selectedCountry,
                              onChanged: (Country? newValue) {
                                setState(() {
                                  _selectedCountry = newValue;
                                });
                              },
                              items: _countries.map<DropdownMenuItem<Country>>((Country country) {
                                return DropdownMenuItem<Country>(
                                  value: country,
                                  child: Text(
                                    '${country.dialCode}', // Display only the dial code
                                    style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                );
                              }).toList(),
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.black,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                        border: InputBorder.none,
                        hintText: 'Enter your number ',
                        filled: false,
                        hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Spacer(),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitPhone,
               style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  minimumSize: Size(
                                      MediaQuery.of(context).size.width - 40,
                                      50), // Full width minus padding
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
              child: Text('Send Code',
                style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),),
            ),
            SizedBox(height: 24),
            Text(_statusMessage),
          ],
        ),
      ),
    );
  }
}




class PrimaryContainer extends StatelessWidget {
  final Widget child;
  final double? radius;
  final Color? color;
  const PrimaryContainer({
    super.key,
    this.radius,
    this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 30),
        border: Border.all(
          color: color ?? Colors.grey,
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: color ?? const Color.fromARGB(255, 255, 255, 255),
          ),
          // const BoxShadow(
          //   offset: Offset(2, 2),
          //   blurRadius: 4,
          //   spreadRadius: 0,
          //   color: Colors.black,
          // ),
        ],
      ),
      child: child,
    );
  }
}