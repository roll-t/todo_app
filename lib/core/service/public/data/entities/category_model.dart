class CategoryModel {
  final String id; // ID của danh mục (dùng để quản lý)
  final String name; // Tên danh mục
  final String color; // Màu danh mục (lưu dưới dạng hex code hoặc tên màu)

  CategoryModel({
    required this.id,
    required this.name,
    required this.color,
  });

  // Chuyển đổi từ Firestore
  factory CategoryModel.fromFirestore(Map<String, dynamic> data, String id) {
    return CategoryModel(
      id: id,
      name: data['name'] as String,
      color: data['color'] as String,
    );
  }

  // Chuyển đổi sang Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'color': color,
    };
  }
}