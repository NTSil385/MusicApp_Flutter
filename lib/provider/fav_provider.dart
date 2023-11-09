import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  Map<String, bool> _favoriteStatus = {};

  Map<String, bool> get favoriteStatus => _favoriteStatus;

  setFavoriteStatus(String songId, bool isFavorite) {
    _favoriteStatus[songId] = isFavorite;
    notifyListeners();
  }
}
