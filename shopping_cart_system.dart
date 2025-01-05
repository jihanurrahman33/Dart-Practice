class Product {
  Product(this.id, this.name, this.price, this.stockQuantity);

  String id;
  String name;
  double price;
  int stockQuantity;

  @override
  String toString() {
    return '$name (ID: $id, Price: \$${price.toStringAsFixed(2)}, Stock: $stockQuantity)';
  }
}

class ShoppingCart {
  Map<Product, int> cartItems = {};

  void addProduct(Product product, int quantity) {
    try {
      if (quantity <= 0) {
        throw Exception('Quantity must be greater than zero.');
      }
      if (product.stockQuantity < quantity) {
        throw Exception('Not enough stock available for ${product.name}.');
      }
      if (cartItems.containsKey(product)) {
        cartItems[product] = cartItems[product]! + quantity;
      } else {
        cartItems[product] = quantity;
      }
      product.stockQuantity -= quantity; // Reduce stock
      print('Added $quantity of ${product.name} to the cart.');
    } catch (e) {
      print('Error adding product: $e');
    }
  }

  void removeProduct(Product product, int quantity) {
    try {
      if (!cartItems.containsKey(product)) {
        throw Exception('${product.name} is not in the cart.');
      }
      if (quantity <= 0) {
        throw Exception('Quantity must be greater than zero.');
      }
      if (cartItems[product]! < quantity) {
        throw Exception('You are trying to remove more than in the cart.');
      }

      cartItems[product] = cartItems[product]! - quantity;

      if (cartItems[product] == 0) {
        cartItems.remove(product);
      }

      product.stockQuantity += quantity; // Restore stock
      print('Removed $quantity of ${product.name} from the cart.');
    } catch (e) {
      print('Error removing product: $e');
    }
  }

  double calculateTotalPrice() {
    double totalPrice = 0;
    cartItems.forEach((product, quantity) {
      totalPrice += product.price * quantity;
    });
    return totalPrice;
  }

  Future<void> checkout() async {
    print('Processing checkout...');
    await Future.delayed(Duration(seconds: 2));
    cartItems.clear(); // Empty the cart
    print('Checkout complete! Cart is now empty.');
  }

  void displayCart() {
    if (cartItems.isEmpty) {
      print('The cart is empty.');
    } else {
      print('Cart Items:');
      cartItems.forEach((product, quantity) {
        print(
            '${product.name}: $quantity x \$${product.price.toStringAsFixed(2)}');
      });
      print('Total Price: \$${calculateTotalPrice().toStringAsFixed(2)}');
    }
  }
}

void main() {
  // Example usage
  Product product1 = Product('1', 'Product1', 100.0, 10);
  Product product2 = Product('2', 'Product2', 200.0, 5);

  ShoppingCart cart = ShoppingCart();

  cart.addProduct(product1, 2);
  cart.addProduct(product2, 3);
  cart.addProduct(product1, 15); // Invalid due to insufficient stock
  cart.displayCart();

  cart.removeProduct(product1, 1);
  cart.displayCart();

  cart.checkout().then((_) => cart.displayCart());
}
