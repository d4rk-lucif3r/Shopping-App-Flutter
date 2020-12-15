import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;

  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });
  Future<void> togglefavoriteStatus(
      String id, String authToken, String userId) async {
    final url =
        'https://shopping-app-daa11-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$authToken';
    var previousFavoriteStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    try {
      final response = await http.put(url,
          body: json.encode(
            isFavorite,
          ));

      if (response.statusCode >= 400) {
        isFavorite = previousFavoriteStatus;
        notifyListeners();
        throw HttpException('Could not delete Product.');
      }
    } catch (error) {
      isFavorite = previousFavoriteStatus;
      notifyListeners();
    }
  }
}
