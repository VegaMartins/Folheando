import 'dart:convert';
import 'package:folheando/core/constants/api_constants.dart';
import 'package:http/http.dart' as http;
import '../models/book.dart';

class BookRepository {
  final String baseUrl = ApiConstants.baseUrl;

  Future<List<Book>> searchBooks(String query) async {
    try {
      
      final response = await http.get(
        Uri.parse('$baseUrl/search.json?q=${Uri.encodeComponent(query)}&fields=key,title,author_name,cover_i,first_publish_year,publisher,ia,public_scan_b,lending_identifier_s,description&limit=40'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> docs = data['docs'] as List;
        
   
        final List<Book> books = [];
        for (var doc in docs) {
          if (doc['title'] != null && doc['key'] != null) {
      
            try {
              final bookId = doc['key'].toString().replaceAll('/works/', '');
              final detailsResponse = await http.get(
                Uri.parse('$baseUrl/works/$bookId.json'),
              );
              
              if (detailsResponse.statusCode == 200) {
                final detailsData = json.decode(detailsResponse.body);
             
                if (detailsData['description'] != null) {
                  if (detailsData['description'] is String) {
                    doc['description'] = detailsData['description'];
                  } else if (detailsData['description'] is Map) {
                    doc['description'] = detailsData['description']['value'];
                  }
                }
              }
            } catch (e) {
              print('Erro ao buscar detalhes do livro: $e');
            }
            
            books.add(Book.fromJson(doc));
          }
        }
        
        return books;
      } else {
        throw Exception('Falha ao pesquisar livros');
      }
    } catch (e) {
      throw Exception('Falha ao pesquisar livros: $e');
    }
  }

  Future<Book> getBookDetails(String bookId) async {
    try {
    
      bookId = bookId.replaceAll('/works/', '');
      
      
      final response = await http.get(
        Uri.parse('$baseUrl/works/$bookId.json'),
      );

      if (response.statusCode == 200) {
        final bookData = json.decode(response.body);
        
       
        final editionsResponse = await http.get(
          Uri.parse('$baseUrl/works/$bookId/editions.json?limit=1&fields=public_scan_b,ia,lending_identifier_s'),
        );
        
        if (editionsResponse.statusCode == 200) {
          final editionsData = json.decode(editionsResponse.body);
          final editions = editionsData['entries'] as List;
          if (editions.isNotEmpty) {
          
            bookData.addAll({
              'public_scan_b': editions[0]['public_scan_b'],
              'ia': editions[0]['ia'],
              'lending_identifier_s': editions[0]['lending_identifier_s'],
            });
          }
        }

        return Book.fromJson(bookData);
      } else {
        throw Exception('Falha ao obter detalhes do livro');
      }
    } catch (e) {
      throw Exception('Falha ao obter detalhes do livro: $e');
    }
  }
}