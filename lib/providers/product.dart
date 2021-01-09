// Framework & Standard Libraries
import 'dart:convert';
import 'package:flutter/foundation.dart';

// 3rd Party Packages
import 'package:http/http.dart' as http;

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

  void _setFavorite(bool value) {
    isFavorite = value;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String userId, String authToken) async {
    final oldStatus = isFavorite;
    _setFavorite(!isFavorite);
    final url =
        'https://flutter-shop-b6801-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$authToken';
    try {
      final response = await http.put(url, body: json.encode(isFavorite));
      if (response.statusCode >= 400) {
        _setFavorite(oldStatus);
      }
    } catch (error) {
      print(error.toString());
      _setFavorite(oldStatus);
    }
  }
}
