import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';


class Data{
  int id;
  String name;
  String img;
  double price;
  String desc;
  String stock;
  Data({
    required this.id,
    required this.name,
    required this.img,
    required this.price,
    required this.desc,
    required this.stock,
  });
}