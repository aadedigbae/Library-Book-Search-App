import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/custom_search_bar.dart';
import '../widgets/gradient_button.dart';
import 'book_search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Library Book Search',
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomSearchBar(
              controller: _searchController,
              onSearch: _performSearch,
            ),
            const SizedBox(height: 20),
            GradientButton(
              text: 'Search Books',
              onPressed: () => _performSearch(_searchController.text),
            ),
          ],
        ),
      ),
    );
  }

  void _performSearch(String query) {
    if (query.isNotEmpty) {
      // Navigate to search results screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookSearchScreen(searchQuery: query),
        ),
      );
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}