import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book_model.dart';

class LibraryApiService {
  static const String baseUrl = 'https://www.loc.gov/books/';

  Future<List<BookModel>> searchBooks(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl?q=$query&fo=json'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        
        print('API Response: $data');

        final List<dynamic> results = data['results'] ?? [];

        return results.map((book) => BookModel.fromJson(book)).toList();
      } else {
        throw Exception('Failed to load books: ${response.body}');
      }
    } catch (e) {
      print('Error searching books: $e');
      rethrow;
    }
  }
}
