import 'package:flutter/material.dart';

class FavoriteProduct {
  final String name;
  final int price;
  final String image;
  final String description;

  FavoriteProduct({
    required this.name,
    required this.price,
    required this.image,
    required this.description,
  });
}

class FavoriteData {
  static final ValueNotifier<List<FavoriteProduct>> favoriteNotifier =
  ValueNotifier([]);

  // Cek apakah produk sudah ada di favorit
  static bool isFavorite(String name) {
    return favoriteNotifier.value.any((item) => item.name == name);
  }

  // Tambah atau Hapus dari Favorit (Toggle)
  static bool toggleFavorite({
    required String name,
    required int price,
    required String image,
    required String description,
  }) {
    List<FavoriteProduct> current = List.from(favoriteNotifier.value);
    int index = current.indexWhere((item) => item.name == name);

    bool isAdded;
    if (index >= 0) {
      current.removeAt(index);
      isAdded = false;
    } else {
      current.add(FavoriteProduct(
        name: name,
        price: price,
        image: image,
        description: description,
      ));
      isAdded = true;
    }

    favoriteNotifier.value = current;
    return isAdded;
  }
}