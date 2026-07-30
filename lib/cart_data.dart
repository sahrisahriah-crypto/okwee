import 'package:flutter/material.dart';

class CartProduct {
  final String name;
  final int price;
  final String image;
  int quantity;

  CartProduct({
    required this.name,
    required this.price,
    required this.image,
    this.quantity = 1,
  });
}

class CartData {
  static final ValueNotifier<List<CartProduct>> cartNotifier =
  ValueNotifier<List<CartProduct>>([]);

  static List<CartProduct> get items => cartNotifier.value;

  static void addProduct({
    required String name,
    required int price,
    required String image,
  }) {
    final List<CartProduct> updatedItems =
    List<CartProduct>.from(cartNotifier.value);

    final int index = updatedItems.indexWhere(
          (product) => product.name == name,
    );

    if (index >= 0) {
      updatedItems[index].quantity++;
    } else {
      updatedItems.add(
        CartProduct(
          name: name,
          price: price,
          image: image,
        ),
      );
    }

    cartNotifier.value = updatedItems;
  }

  static void increaseQuantity(int index) {
    final List<CartProduct> updatedItems =
    List<CartProduct>.from(cartNotifier.value);

    if (index < 0 || index >= updatedItems.length) {
      return;
    }

    updatedItems[index].quantity++;
    cartNotifier.value = updatedItems;
  }

  static void decreaseQuantity(int index) {
    final List<CartProduct> updatedItems =
    List<CartProduct>.from(cartNotifier.value);

    if (index < 0 || index >= updatedItems.length) {
      return;
    }

    if (updatedItems[index].quantity > 1) {
      updatedItems[index].quantity--;
    } else {
      updatedItems.removeAt(index);
    }

    cartNotifier.value = updatedItems;
  }

  static void removeProduct(int index) {
    final List<CartProduct> updatedItems =
    List<CartProduct>.from(cartNotifier.value);

    if (index < 0 || index >= updatedItems.length) {
      return;
    }

    updatedItems.removeAt(index);
    cartNotifier.value = updatedItems;
  }

  static void clearCart() {
    cartNotifier.value = <CartProduct>[];
  }

  static int get totalPrice {
    return cartNotifier.value.fold<int>(
      0,
          (total, product) =>
      total + (product.price * product.quantity),
    );
  }

  static int get totalQuantity {
    return cartNotifier.value.fold<int>(
      0,
          (total, product) => total + product.quantity,
    );
  }
}