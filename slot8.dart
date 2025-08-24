import 'dart:io';

ProductMap productMap = ProductMap();

void main() {
  int? choice;
  do {
    print('Vui lòng nhập lựa chọn của bạn:');
    print('1. Thêm sản phẩm vào giỏ hàng');
    print('2. Sửa và xóa sản phẩm ở giỏ hàng');
    print('3. Hiển thị giỏ hàng');
    print('4. Tính tổng tiền hóa đơn ');
    print('5. Thoát');
    choice = int.tryParse(stdin.readLineSync()!);
    switch (choice) {
      case 1:
        addProduct();
        break;
      case 2:
        updateProduct();
        break;
      case 3:
        displayProducts();
        break;
      case 4:
        totalBill();
        break;
      case 5:
        print('Thoát chương trình.');
        return;
      default:
    }
  } while (choice != 5);
}

void addProduct() {
  print('Nhập tên sản phẩm:');
  String name = stdin.readLineSync()!;
  print('Nhập giá sản phẩm:');
  double price = double.parse(stdin.readLineSync()!);
  print('Nhập số lượng sản phẩm:');
  int quantity = int.parse(stdin.readLineSync()!);

  Product product = Product(price, quantity);
  productMap.addProduct(name, product);
}

void updateProduct() {
  print('Nhập tên sản phẩm cần sửa hoặc xoá:');
  String name = stdin.readLineSync()!;
  do {
    print('Nhập 1 để sửa số lượng sản phẩm, 2 để xoá sản phẩm khoải giỏ hàng');
    int choice = int.parse(stdin.readLineSync()!);
    if (choice == 1) {
      print('Nhập số lượng mới:');
      int newQuantity = int.parse(stdin.readLineSync()!);
      productMap.productMap[name]?.quantity = newQuantity;
      print('Số lượng sản phẩm đã được cập nhật.');
      break;
    } else if (choice == 2) {
      productMap.productMap.remove(name);
      print('Sản phẩm đã được xoá khỏi giỏ hàng.');
      break;
    } else {
      print('Lựa chọn không hợp lệ. Vui lòng thử lại.');
    }
  } while (true);
}

void displayProducts() {
  if (productMap.productMap.isEmpty) {
    print('Giỏ hàng trống.');
  } else {
    print('Sản phẩm trong giỏ hàng:');
    productMap.productMap.forEach((name, product) {
      print('Tên: $name, Giá: ${product.price}, Số lượng: ${product.quantity}');
    });
  }
}

void totalBill() {
  double total = 0.0;

  productMap.productMap.forEach((name, product) {
    total += product.price * product.quantity;
  });

  print('Tổng tiền hóa đơn: $total');
}

class Product {
  double price;
  int quantity;

  Product(this.price, this.quantity);

  double getPrice() {
    return price;
  }

  int getQuantity() {
    return quantity;
  }
}

class ProductMap {
  Map<String, Product> productMap = {};

  void addProduct(String name, Product product) {
    productMap[name] = product;
  }

  Product? getProduct(String name) {
    return productMap[name];
  }
}
