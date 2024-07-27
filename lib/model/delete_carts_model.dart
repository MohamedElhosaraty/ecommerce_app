class DeleteCartsModel {
  final bool status;
  final String message;
  final Data data;

  DeleteCartsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DeleteCartsModel.fromJson(Map<String, dynamic> json) => DeleteCartsModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  final Cart cart;
  final dynamic subTotal;
  final dynamic total;

  Data({
    required this.cart,
    required this.subTotal,
    required this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    cart: Cart.fromJson(json["cart"]),
    subTotal: json["sub_total"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "cart": cart.toJson(),
    "sub_total": subTotal,
    "total": total,
  };
}

class Cart {
  final int id;
  final int quantity;
  final Product product;

  Cart({
    required this.id,
    required this.quantity,
    required this.product,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    id: json["id"],
    quantity: json["quantity"],
    product: Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "quantity": quantity,
    "product": product.toJson(),
  };
}

class Product {
  final int id;
  final dynamic price;
  final dynamic oldPrice;
  final int discount;
  final String image;

  Product({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    price: json["price"],
    oldPrice: json["old_price"],
    discount: json["discount"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "price": price,
    "old_price": oldPrice,
    "discount": discount,
    "image": image,
  };
}
