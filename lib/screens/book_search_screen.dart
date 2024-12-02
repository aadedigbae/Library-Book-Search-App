import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../providers/book_search_provider.dart';
import '../widgets/custom_search_bar.dart';
import 'book_details_screen.dart';

class BookSearchScreen extends StatefulWidget {
  final String searchQuery;

  const BookSearchScreen({super.key, required this.searchQuery});

  @override
  _BookSearchScreenState createState() => _BookSearchScreenState();
}

class _BookSearchScreenState extends State<BookSearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchController.text = widget.searchQuery;
      Provider.of<BookSearchProvider>(context, listen: false)
          .searchBooks(widget.searchQuery);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results: "${widget.searchQuery}"'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomSearchBar(
              controller: _searchController,
              onSearch: _performSearch,
            ),
          ),
          Expanded(
            child: Consumer<BookSearchProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (provider.errorMessage.isNotEmpty) {
                  return Center(
                    child: Text(
                      provider.errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (provider.books.isEmpty) {
                  return const Center(
                    child: Text('No books found'),
                  );
                }

                return ListView.builder(
                  itemCount: provider.books.length,
                  itemBuilder: (context, index) {
                    final book = provider.books[index];
                    return _buildBookCard(book);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookCard(dynamic book) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: book.thumbnailUrl.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: book.thumbnailUrl,
                width: 80,
                height: 120,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.book),
              )
            : const Icon(Icons.book, size: 50),
        title: Text(
          book.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          book.authors.join(', '),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookDetailsScreen(book: book),
            ),
          );
        },
      ),
    );
  }

  void _performSearch(String query) {
    if (query.isNotEmpty) {
      Provider.of<BookSearchProvider>(context, listen: false).searchBooks(query);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}