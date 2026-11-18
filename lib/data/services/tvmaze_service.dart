import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/constants.dart';
import '../models/show.dart';

/// Fetch & parse data API dipisah dari UI.
class TvMazeService {
  /// GET https://api.tvmaze.com/shows
  Future<List<Show>> fetchShows() async {
    final res = await http
        .get(Uri.parse('$kBaseUrl/shows'))
        .timeout(const Duration(seconds: 20));
    if (res.statusCode != 200) {
      throw Exception('Gagal memuat data (${res.statusCode})');
    }
    final List data = jsonDecode(res.body) as List;
    return data
        .map((e) => Show.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// GET https://api.tvmaze.com/shows/{id}
  Future<Show> fetchShowDetail(int id) async {
    final res = await http
        .get(Uri.parse('$kBaseUrl/shows/$id'))
        .timeout(const Duration(seconds: 20));
    if (res.statusCode != 200) {
      throw Exception('Gagal memuat detail (${res.statusCode})');
    }
    return Show.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
  }
}
