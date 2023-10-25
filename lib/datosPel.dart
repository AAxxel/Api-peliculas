import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  final apiKey = '42ef8b2ad4f015f69478a92bdeb79169'; 
  final apiUrl = 'https://api.themoviedb.org/3';

  
  final movieIds = [550, 680, 155];

  for (var movieId in movieIds) {
    fetchMovieDetails(apiUrl, apiKey, movieId).then((movie) {
      print('Título: ${movie['title']}');
      print('Descripción: ${movie['overview']}');
      print('Fecha de lanzamiento: ${movie['release_date']}');
      print('---');
    }).catchError((error) {
      print('Error: $error');
    });
  }
}

Future<Map<String, dynamic>> fetchMovieDetails(
    String apiUrl, String apiKey, int movieId) async {
  final response = await http.get(
    Uri.parse('$apiUrl/movie/$movieId?api_key=$apiKey'),
  );

  if (response.statusCode == 200) {
    final decodedData = json.decode(response.body);
    return decodedData;
  } else {
    throw 'Error al obtener los datos';
  }
}