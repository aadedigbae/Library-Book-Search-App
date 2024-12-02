class BookModel {
  final String title;
  final List<String> authors;
  final String description;
  final String thumbnailUrl;
  final String previewLink;

  BookModel({
    required this.title,
    required this.authors,
    this.description = 'No description available',
    this.thumbnailUrl = '',
    this.previewLink = '',
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      title: _parseTitle(json),
      authors: _parseAuthors(json),
      description: _parseDescription(json),
      thumbnailUrl: _parseThumbnail(json),
      previewLink: _parsePreviewLink(json),
    );
  }

  static String _parseTitle(Map<String, dynamic> json) {
    try {
      if (json['title'] is String) return json['title'];
      if (json['title'] is List) return json['title'].first ?? 'Unknown Title';
      return 'Unknown Title';
    } catch (e) {
      return 'Unknown Title';
    }
  }

  static List<String> _parseAuthors(Map<String, dynamic> json) {
    try {
      if (json['creators'] is List) {
        return json['creators']
            .map<String>((creator) => 
              creator is Map 
                ? (creator['name'] ?? 'Unknown Author') 
                : creator.toString()
            )
            .toList();
      }
      if (json['author'] is List) {
        return List<String>.from(json['author']);
      }
      if (json['author'] is String) {
        return [json['author']];
      }
      return ['Unknown Author'];
    } catch (e) {
      return ['Unknown Author'];
    }
  }

  static String _parseDescription(Map<String, dynamic> json) {
    try {
      if (json['description'] is String) return json['description'];
      if (json['description'] is List) {
        return json['description'].first ?? 'No description available';
      }
      return 'No description available';
    } catch (e) {
      return 'No description available';
    }
  }

  static String _parseThumbnail(Map<String, dynamic> json) {
    try {
      return '';
    } catch (e) {
      return '';
    }
  }

  static String _parsePreviewLink(Map<dynamic, dynamic> json) {
    try {
      if (json['url'] is String) return json['url'];
      return '';
    } catch (e) {
      return '';
    }
  }
}