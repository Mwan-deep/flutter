import 'dart:io';

ProductList productlist = ProductList();

void main() {
  int? choice;
  do {
    print('Vui lòng nhập lựa chọn của bạn:');
    print('1. Nhập thông tin sản phẩm');
    print('2. Hiển thị thông tin sản phẩm');
    print('3. Tìm sản phẩm theo tên');
    print('4. Bán sản phẩm');
    print('5. Thoát');
    choice = int.tryParse(stdin.readLineSync()!);
    switch (choice) {
      case 1:
        addProduct();
        break;
      case 2:
        displayProducts();
        break;
      case 3:
        findProductByName();
        break;
      case 4:
        sellProduct();
      case 5:
        print('Thoát chương trình.');
        return;
      default:
    }
  } while (choice != 4);
}

void addProduct() {
  print('Nhập tên sản phẩm:');
  String name = stdin.readLineSync()!;
  print('Nhập giá sản phẩm:');
  double price = double.parse(stdin.readLineSync()!);
  print('Nhập số lượng sản phẩm:');
  int quantity = int.parse(stdin.readLineSync()!);

  Product product = Product(name, price, quantity);
  productlist.addProduct(product);
}

void displayProducts() {
  if (productlist.pro.isEmpty) {
    print('Danh sách sản phẩm trống.');
  } else {
    for (int i = 0; i < productlist.pro.length; i++) {
      print('Thông tin sản phẩm ${i + 1}:');
      productlist.getProduct(i).displayInfo();
      print('-------------------');
    }
  }
}

void findProductByName() {
  if (productlist.pro.isEmpty) {
    print('Danh sách sản phẩm trống.');
    return;
  }
  print('Nhập tên sản phẩm cần tìm:');
  String name = stdin.readLineSync()!;
  bool found = false;
  for (int i = 0; i < productlist.pro.length; i++) {
    if (productlist.getProduct(i).name.toLowerCase() == name.toLowerCase()) {
      print('Thông tin sản phẩm tìm thấy:');
      productlist.getProduct(i).displayInfo();
      found = true;
      break;
    }
  }
  if (!found) {
    print('Không tìm thấy sản phẩm với tên "$name".');
  }
}

void sellProduct() {
  print('Nhập tên sản phẩm cần bán:');
  String name = stdin.readLineSync()!;
  print('Nhập số lượng cần bán:');
  int quantity = int.parse(stdin.readLineSync()!);
  for (int i = 0; i < productlist.pro.length; i++) {
    if (productlist.getProduct(i).name.toLowerCase() == name.toLowerCase()) {
      if (productlist.getProduct(i).quantity >= quantity) {
        productlist.getProduct(i).quantity -= quantity;
        print('Đã bán $quantity sản phẩm "$name".');
        return;
      } else {
        print('Số lượng sản phẩm không đủ để bán.');
        return;
      }
    }
  }
  print('Không tìm thấy sản phẩm với tên "$name".');
}

class Product {
  String name;
  double price;
  int quantity;

  Product(this.name, this.price, this.quantity);

  void displayInfo() {
    print('Tên sản phẩm: $name');
    print('Giá: $price');
    print('Số lượng: $quantity');
  }
}

class ProductList {
  List<Product> pro = [];

  void addProduct(Product product) {
    pro.add(product);
  }

  Product getProduct(int index) {
    return pro[index];
  }
}
