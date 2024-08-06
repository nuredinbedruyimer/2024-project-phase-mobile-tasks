import "dart:io";

void main() {
  String? prompt;
  ProductManger man = ProductManger();
  var prompts = {
    "ADD": man.addProduct,
    "DELETE": man.deleteProduct,
    "VIEW": man.view,
    "VIEW ALL": man.viewALL,
    "": man.editProduct
  };
  var commandList =
      "Available commands:\nadd: for adding a product\nedit: for editing a product\nview: for viewing a product\nview all: for viewing all products\ndelete: for deleting a product\nexit: exits the program";

  print("==================\n$commandList\n==================");
  while (prompt != "exit") {
    stdout.write('>> ');
    prompt = stdin.readLineSync() ?? "";
    if (prompts.containsKey(prompt)) {
      prompts[prompt]?.call();
    } else if (prompt == "help") {
      print(commandList);
    } else if (prompt != "exit") {
      print("Unknown Command");
    }
  }
}

class Product {
  String? name, disc;
  int? price;
  Product(String? name, disc, int price) {
    this.name = name;
    this.disc = disc;
    this.price = price;
  }
  String? getName() {
    return name;
  }

  String? getDisc() {
    return disc;
  }

  int? getPrice() {
    return price;
  }
}

//add, view all, view, edit a product, delete a product
class ProductManger {
  var allProducts;
  ProductManger() {
    allProducts = {};
  }
  int addProduct() {
    stdout.write("Enter name: ");
    var name = stdin.readLineSync();
    if (name == "") {
      print("Invalid Input");
      return 0;
    }
    stdout.write("Enter Description: ");
    var temp = stdin.readLineSync();
    if (temp == null) {
      print("Invalid Input");
      return 0;
    }
    stdout.write("Enter Price: ");
    int price;
    try {
      price = int.parse(stdin.readLineSync() ?? "");
    } catch (e) {
      print("Invalid Input");
      return 0;
    }
    allProducts[name] = Product(name, temp, price);
    return 1;
  }

  void view() {
    stdout.write("Enter Name: ");
    String? name = stdin.readLineSync();
    if (name == null) {
      print("Invalid name");
      return;
    }
    if (allProducts.containsKey(name)) {
      print(
          "Product Name: $name\n Product Discription: ${allProducts[name].getDisc()}\n Price: ${allProducts[name].getPrice()}");
    } else {
      print("No such product");
    }
  }

  void viewALL() {
    for (final name in allProducts.keys) {
      print(
          "Product Name: $name\n Product Discription: ${allProducts[name].getDisc()}\n Price: ${allProducts[name].getPrice()}");
    }
  }

  void deleteProduct() {
    stdout.write("Enter Name: ");
    String? name = stdin.readLineSync();
    if (name == "") {
      print("Invalid Input");
      return;
    }
    if (allProducts.containsKey(name)) {
      allProducts.remove(name);
      print("Successfully removed $name");
    } else {
      print("No such product");
    }
  }

  void editProduct() {
    stdout.write("Enter Name: ");
    String? name = stdin.readLineSync();
    if (name == "") {
      print("Invalid Input");
      return;
    }
    if (allProducts.containsKey(name)) {
      if (addProduct() == 1) {
        allProducts.remove(name);
      }
    } else {
      print("No such product");
    }
  }
}
