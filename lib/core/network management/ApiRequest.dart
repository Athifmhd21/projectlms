// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
 
// import 'networkResponseModel.dart';
 
// /// Enum to define HTTP methods in a type-safe way
// enum RequestMethod { get, post, patch, delete }
 
// /// Provider class for API Client with ChangeNotifier
// class ApiClient extends ChangeNotifier {
//   String _consumerToken = '';
//   bool _isLoading = false;
 
//   bool get isLoading => _isLoading;
 
//   /// Loads token from shared preferences if not already loaded.
//   Future<void> _loadToken() async {
//     if (_consumerToken.isEmpty) {
//       final prefs = await SharedPreferences.getInstance();
//       _consumerToken = prefs.getString('consumer_token') ?? '';
//     }
//   }
 
//   /// Sets loading state and notifies listeners
//   void _setLoading(bool value) {
//     _isLoading = value;
//     notifyListeners();
//   }
 
//   /// Core method for making network calls.
//   Future<NetworkResponse> request({
//     required String url,
//     required RequestMethod method,
//     Map<String, String>? headers,
//     Map<String, String>? queryParameters,
//     dynamic body,
//     bool isMultipart = false,
//     Map<String, String>? multipartFields,
//     BuildContext? context,
//   }) async {
//     await _loadToken();
//     _setLoading(true);
 
//     Uri uri = Uri.parse(url).replace(
//       queryParameters: {...Uri.parse(url).queryParameters, ...?queryParameters},
//     );
 
//     final requestHeaders = {
//       ...?headers,
//       if (_consumerToken.isNotEmpty) "Authorization": _consumerToken,
//     };
 
//     try {
//       http.Response response;
 
//       if (isMultipart && multipartFields != null) {
//         final req = http.MultipartRequest('POST', uri)
//           ..headers.addAll(requestHeaders)
//           ..fields.addAll(multipartFields);
 
//         final streamedRes = await req.send();
//         response = await http.Response.fromStream(streamedRes);
//       } else {
//         switch (method) {
//           case RequestMethod.get:
//             response = await http.get(uri, headers: requestHeaders);
//             break;
//           case RequestMethod.post:
//             response = await http.post(
//               uri,
//               headers: requestHeaders,
//               body: jsonEncode(body),
//             );
//             break;
//           case RequestMethod.patch:
//             response = await http.patch(
//               uri,
//               headers: requestHeaders,
//               body: jsonEncode(body),
//             );
//             break;
//           case RequestMethod.delete:
//             final req = http.Request("DELETE", uri)
//               ..headers.addAll(requestHeaders)
//               ..bodyFields = Map<String, String>.from(body ?? {});
//             final streamedRes = await req.send();
//             response = await http.Response.fromStream(streamedRes);
//             break;
//         }
//       }
 
//       dynamic data;
//       try {
//         data = json.decode(response.body);
//       } catch (e) {
//         data = response.body;
//       }
 
//       return NetworkResponse(
//         success: response.statusCode == 200,
//         data: data,
//         statusCode: response.statusCode,
//         headers: response.headers,
//       );
//     } catch (e) {
//       return NetworkResponse(
//         success: false,
//         data: 'Exception: $e',
//         statusCode: 0,
//       );
//     } finally {
//       _setLoading(false);
//     }
//   }
 
//   /// Clears token and session info, and redirects to login screen.
//   Future<void> clearSession(BuildContext context) async {
//     _consumerToken = '';
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.clear();
//     Navigator.pushReplacementNamed(context, '/login');
//   }
// }