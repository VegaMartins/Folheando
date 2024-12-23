class Book {
  final String id;
  final String title;
  final String? author;
  final String? coverUrl;
  String? description;  
  final List<String>? subjects;
  final int? firstPublishYear;
  final String? publisher;
  final bool? publicDomain;
  final String? iaIdentifier; 
  final List<String>? downloadLinks;
  bool isFavorite;
  String? userReview;
  double? userRating;

  Book({
    required this.id,
    required this.title,
    this.author,
    this.coverUrl,
    this.description,
    this.subjects,
    this.firstPublishYear,
    this.publisher,
    this.publicDomain,
    this.iaIdentifier,
    this.downloadLinks,
    this.isFavorite = false,
    this.userReview,
    this.userRating,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    List<String>? downloadLinks;
    bool isPublicDomain = false;
    String? iaId = json['ia']?[0];
    
   
    String? description;
    if (json['description'] != null) {
      if (json['description'] is String) {
        description = json['description'];
      } else if (json['description'] is Map) {
        description = json['description']['value'];
      }
    }

    if (iaId != null) {
      downloadLinks = [
        'https://archive.org/details/$iaId',
        if (json['public_scan_b'] == true || json['lending_identifier_s'] != null)
          'https://archive.org/download/$iaId',
      ];
      isPublicDomain = json['public_scan_b'] == true;
    }

    return Book(
      id: json['key'].toString(),
      title: json['title'],
      author: json['author_name']?[0],
      coverUrl: json['cover_i'] != null 
        ? 'https://covers.openlibrary.org/b/id/${json['cover_i']}-L.jpg'
        : null,
      description: description,
      subjects: (json['subject'] as List<dynamic>?)?.cast<String>(),
      firstPublishYear: json['first_publish_year'],
      publisher: json['publisher']?[0],
      publicDomain: isPublicDomain,
      iaIdentifier: iaId,
      downloadLinks: downloadLinks,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'coverUrl': coverUrl,
      'description': description,
      'subjects': subjects,
      'firstPublishYear': firstPublishYear,
      'publisher': publisher,
      'publicDomain': publicDomain,
      'iaIdentifier': iaIdentifier,
      'downloadLinks': downloadLinks,
      'isFavorite': isFavorite,
      'userReview': userReview,
      'userRating': userRating,
    };
  }

  
}