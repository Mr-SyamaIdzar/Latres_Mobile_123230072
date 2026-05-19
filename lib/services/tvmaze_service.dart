import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/tv_show_model.dart';

class TvMazeService {
  static const String _baseUrl = 'https://api.tvmaze.com';

  /// Fetch list of shows from TVMaze
  Future<List<TvShow>> fetchShows() async {
    final response = await http.get(Uri.parse('$_baseUrl/shows'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => TvShow.fromJson(item)).toList();
    } else {
      throw Exception('Gagal mengambil data shows: ${response.statusCode}');
    }
  }

  /// Fetch detail of a single show by id
  Future<TvShow> fetchShowDetail(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/shows/$id'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return TvShow.fromJson(data);
    } else {
      throw Exception('Gagal mengambil detail show: ${response.statusCode}');
    }
  }

  /// Search shows by query
  Future<List<TvShow>> searchShows(String query) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/search/shows?q=$query'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data
          .map((item) => TvShow.fromJson(item['show'] as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Gagal mencari show: ${response.statusCode}');
    }
  }
}
