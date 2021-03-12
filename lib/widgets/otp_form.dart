// import 'package:flutter/material.dart';
// import 'package:base32/base32.dart';

// import '../storage/database.dart';
// import '../storage/password_model.dart';

// class OTPForm extends StatefulWidget {
//   final formKey;
//   final PasswordModel model;

//   OTPForm({Key key, this.formKey, this.model}) : super(key: key);

//   @override
//   _OTPFormState createState() => _OTPFormState();
// }

// class _OTPFormState extends State<OTPForm> {
//   var _showAdvancedFields = false;

//   @override
//   Widget build(BuildContext context) {
//     final advancedFields = [
//       _margin(
//         child: DropdownButtonFormField(
//           decoration: _borderDecoration(
//             labelText: 'Algorithm',
//           ),
//           items: [
//             const DropdownMenuItem(
//               child: Text('SHA1'),
//               value: Algorithm.SHA1,
//             ),
//             const DropdownMenuItem(
//               child: Text('SHA256'),
//               value: Algorithm.SHA256,
//             ),
//             const DropdownMenuItem(
//               child: Text('SHA512'),
//               value: Algorithm.SHA512,
//             ),
//           ],
//           value: widget.model.algorithm,
//           onChanged: (value) {
//             setState(() {
//               widget.model.algorithm = value;
//             });
//           },
//         ),
//       ),
//       _margin(
//         child: TextFormField(
//           decoration: _borderDecoration(
//             labelText: 'Length',
//           ),
//           initialValue: widget.model.length.toString(),
//           onChanged: (value) {
//             setState(() {
//               try {
//                 widget.model.length = int.parse(value);
//               } catch (e) {
//                 widget.model.length = 6;
//               }
//             });
//           },
//           validator: (value) {
//             final intValue = int.tryParse(value);

//             if (intValue == null) {
//               return 'Length should be a number';
//             }

//             if (intValue < 6) {
//               return "Length can't be less than 6";
//             }

//             if (intValue > 12) {
//               return "Length can't be more than 12";
//             }

//             return null;
//           },
//         ),
//       ),
//       _margin(
//         child: SwitchListTile(
//           title: const Text('Time-based'),
//           value: widget.model.timeBased,
//           onChanged: (value) {
//             setState(() {
//               widget.model.timeBased = value;
//             });
//           },
//         ),
//       ),
//       widget.model.timeBased
//           ? _margin(
//               child: TextFormField(
//                 key: const ValueKey('periodField'),
//                 decoration: _borderDecoration(
//                   labelText: 'Period',
//                 ),
//                 initialValue: widget.model.period.toString(),
//                 onChanged: (value) {
//                   setState(() {
//                     try {
//                       widget.model.period = int.parse(value);
//                     } catch (e) {
//                       widget.model.period = 30;
//                     }
//                   });
//                 },
//                 validator: (value) {
//                   final intValue = int.tryParse(value);

//                   if (intValue == null) {
//                     return 'Period should be a number';
//                   }

//                   if (intValue < 30) {
//                     return "Period can't be less than 30";
//                   }

//                   if (intValue > 300) {
//                     return "Period can't be more than 300";
//                   }

//                   return null;
//                 },
//               ),
//             )
//           : _margin(
//               child: TextFormField(
//                 key: const ValueKey('counterField'),
//                 decoration: _borderDecoration(
//                   labelText: 'Counter',
//                 ),
//                 initialValue: widget.model.counter.toString(),
//                 onChanged: (value) {
//                   setState(() {
//                     try {
//                       widget.model.counter = int.parse(value);
//                     } catch (e) {
//                       widget.model.counter = 0;
//                     }
//                   });
//                 },
//                 validator: (value) {
//                   final intValue = int.tryParse(value);

//                   if (intValue == null) {
//                     return 'Counter should be a number';
//                   }

//                   if (intValue < 0) {
//                     return "Counter can't be less than 0";
//                   }

//                   return null;
//                 },
//               ),
//             ),
//     ];

//     return Container(
//       child: Form(
//         key: widget.formKey,
//         autovalidateMode: AutovalidateMode.disabled,
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(15),
//           child: Column(
//             children: [
//               _margin(
//                 margin: const EdgeInsets.only(
//                   top: 5,
//                   bottom: 10,
//                 ),
//                 child: TextFormField(
//                   initialValue: widget.model.service,
//                   textCapitalization: TextCapitalization.words,
//                   decoration: _borderDecoration(
//                     labelText: 'Service',
//                     hintText: 'eg. Google',
//                     helperText: 'Optional',
//                     prefixIcon: Icon(Icons.bubble_chart,
//                         color: Theme.of(context)
//                             .inputDecorationTheme
//                             .labelStyle
//                             .color),
//                   ),
//                   onChanged: (value) {
//                     setState(() {
//                       widget.model.service = value;
//                     });
//                   },
//                 ),
//               ),
//               _margin(
//                 child: TextFormField(
//                   initialValue: widget.model.account,
//                   decoration: _borderDecoration(
//                     labelText: 'Account',
//                     hintText: 'robot@example.org',
//                     prefixIcon: Icon(Icons.person,
//                         color: Theme.of(context)
//                             .inputDecorationTheme
//                             .labelStyle
//                             .color),
//                   ),
//                   onChanged: (value) {
//                     setState(() {
//                       widget.model.account = value;
//                     });
//                   },
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return 'An account name is required';
//                     }

//                     return null;
//                   },
//                 ),
//               ),
//               _margin(
//                 child: TextFormField(
//                   initialValue: widget.model.secret,
//                   keyboardType: TextInputType.visiblePassword,
//                   decoration: _borderDecoration(
//                     labelText: 'Secret',
//                     prefixIcon: Icon(Icons.vpn_key,
//                         color: Theme.of(context)
//                             .inputDecorationTheme
//                             .labelStyle
//                             .color),
//                   ),
//                   onChanged: (value) {
//                     setState(() {
//                       widget.model.secret = value;
//                     });
//                   },
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return 'A secret is required';
//                     }

//                     try {
//                       base32.decodeAsHexString(value);
//                     } on FormatException {
//                       return 'This secret is not valid Base32';
//                     }

//                     return null;
//                   },
//                 ),
//               ),
//               _margin(
//                 margin: const EdgeInsets.only(
//                   top: 5,
//                   bottom: 10,
//                 ),
//                 child: ListTile(
//                   title: const Text('Advanced'),
//                   trailing: Icon(
//                     _showAdvancedFields ? Icons.expand_more : Icons.expand_less,
//                     color: Theme.of(context).textTheme.bodyText1.color,
//                   ),
//                   onTap: () {
//                     setState(() {
//                       _showAdvancedFields = !_showAdvancedFields;
//                     });
//                   },
//                 ),
//               ),
//               if (_showAdvancedFields) ...advancedFields,
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   InputDecoration _borderDecoration(
//       {String labelText, String hintText, String helperText, Icon prefixIcon}) {
//     return InputDecoration(
//       labelText: labelText,
//       hintText: hintText,
//       helperText: helperText,
//       prefixIcon: prefixIcon,
//     );
//   }

//   Widget _margin(
//       {EdgeInsets margin = const EdgeInsets.symmetric(
//         vertical: 10,
//       ),
//       Widget child}) {
//     return Container(
//       margin: margin,
//       child: child,
//     );
//   }
// }
