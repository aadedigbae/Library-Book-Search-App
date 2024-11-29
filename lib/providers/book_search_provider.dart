import 'package:flutter/foundation.dart';
import '../models/book_model.dart';
import '../services/library_api_service.dart';

class BookSearchProvider with ChangeNotifier {
  final LibraryApiService _apiService = LibraryApiService();
  
  List<BookModel> _books = [];
  List<BookModel> get books => _books;
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> searchBooks(String query) async {
    if (query.isEmpty) return;
    
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _books = await _apiService.searchBooks(query);
      _isLoading = false;
    } catch (e) {
      _errorMessage = 'Failed to search books: ${e.toString()}';
      _books = [];
      _isLoading = false;
    }
    
    notifyListeners();
  }

  void clearSearch() {
    _books = [];
    _errorMessage = '';
    notifyListeners();
  }
}