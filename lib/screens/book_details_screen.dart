import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/book_model.dart';
import '../widgets/gradient_button.dart';

class BookDetailsScreen extends StatelessWidget {
  final BookModel book;

  const BookDetailsScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Book Cover
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: book.thumbnailUrl.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: book.thumbnailUrl,
                          width: 200,
                          height: 300,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.book,
                            size: 100,
                          ),
                        )
                      : const Icon(
                          Icons.book,
                          size: 100,
                        ),
                ),
              ),
              const SizedBox(height: 20),

              // Book Title
              Text(
                book.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),

              // Authors
              Text(
                'by ${book.authors.join(', ')}',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Description
              Text(
                'Description',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[400],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                book.description,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),

              // Preview Button
              book.previewLink.isNotEmpty
                  ? GradientButton(
                      text: 'Preview Book',
                      onPressed: () => _launchUrl(context, book.previewLink),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(BuildContext context, String urlString) async {
    try {
      final Uri url = Uri.parse(urlString);
      if (await canLaunchUrl(url)) {
        // Attempt to launch the URL
        await launchUrl(
          url, 
          mode: LaunchMode.externalApplication, // Opens in external browser
        );
      } else {
        // If URL cannot be launched, show an error dialog
        _showUrlErrorDialog(context, urlString);
      }
    } catch (e) {
      // Handle any unexpected errors
      _showUrlErrorDialog(context, urlString);
    }
  }

  void _showUrlErrorDialog(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Unable to Open Link'),
          content: Text(
            'We couldn\'t open the book preview at $url. '
            'The link might be broken or your device doesn\'t support opening this type of link.',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Copy Link'),
              onPressed: () {
                // Implement link copying logic
                // You might want to use a package like clipboard
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
