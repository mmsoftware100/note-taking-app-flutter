import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseURL = "https://notetaking.software100.com.mm/api/v1";
  static String? token;

  static Map<String, String> get headers => {
    'Content-Type': 'application/json',
    if (token != null) 'Authorization': 'Bearer $token',
  };

  static Future<http.Response> login(String email, String password) {
    return http.post(
      Uri.parse('$baseURL/login'),
      headers: {'Content-Type': 'application/json'}, // login doesn't need token
      body: jsonEncode({'email': email, 'password': password}),
    );
  }

  static Future<http.Response> register(String name, String email, String password) {
    return http.post(
      Uri.parse('$baseURL/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': password,
        'role_id': "2"
      }),
    );
  }

  static Future<http.Response> getNotes() {
    return http.get(Uri.parse('$baseURL/notes'), headers: headers);
  }

  static Future<http.Response> createNote(String title, String description, String date) {
    return http.post(
      Uri.parse('$baseURL/notes'),
      headers: headers,
      body: jsonEncode({'title': title, 'description': description, 'date': date}),
    );
  }

  static Future<http.Response> updateNote(int id, String title, String description, String date) {
    return http.put(
      Uri.parse('$baseURL/notes/$id'),
      headers: headers,
      body: jsonEncode({'title': title, 'description': description, 'date': date}),
    );
  }

  static Future<http.Response> deleteNote(int id) {
    return http.delete(Uri.parse('$baseURL/notes/$id'), headers: headers);
  }
}
