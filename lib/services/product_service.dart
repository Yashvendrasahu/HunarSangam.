// lib/services/product_service.dart

import 'dart:async';
import '../models/product_model.dart';
import '../add_product/models/product_draft.dart';
import 'supabase_service.dart';

class ProductService {
  static final ProductService _instance = ProductService._internal();
  factory ProductService() => _instance;
  ProductService._internal() {
    _initProducts();
  }

  final _productsStreamController = StreamController<List<ProductModel>>.broadcast();
  Stream<List<ProductModel>> get productsStream => _productsStreamController.stream;

  final List<ProductModel> _products = [
    const ProductModel(
      id: 'prod_1',
      artisanId: 'art_1',
      title: 'Terracotta Handcrafted Vase',
      description: 'Traditional natural red clay vase crafted by heritage potters with geometric engraving.',
      price: 450.0,
      originalPrice: '₹600',
      category: 'Pottery & Ceramics',
      minOrderQuantity: 10,
      stockQuantity: 80,
      dimensions: '14" x 6" x 6"',
      leadTime: '5-7 days',
      isFeatured: true,
      rating: 4.9,
      reviewsCount: 32,
    ),
    const ProductModel(
      id: 'prod_2',
      artisanId: 'art_1',
      title: 'Woven Bamboo Storage Basket',
      description: 'Eco-friendly, sturdy golden bamboo storage basket with reinforced handles.',
      price: 320.0,
      originalPrice: '₹450',
      category: 'Bamboo & Cane',
      minOrderQuantity: 20,
      stockQuantity: 150,
      dimensions: '12" x 12" x 10"',
      leadTime: '7-10 days',
      isFeatured: true,
      rating: 4.8,
      reviewsCount: 19,
    ),
  ];

  Future<void> _initProducts() async {
    final remote = await SupabaseService().fetchProducts();
    if (remote.isNotEmpty) {
      _products.clear();
      _products.addAll(remote);
      _productsStreamController.add(List.unmodifiable(_products));
    }
  }

  List<ProductModel> getProducts() => List.unmodifiable(_products);

  Future<void> addProduct(ProductModel product) async {
    _products.add(product);
    _productsStreamController.add(List.unmodifiable(_products));
    await SupabaseService().insertProduct(product);
  }

  Future<void> createProductFromDraft(ProductDraft draft) async {
    final newProduct = ProductModel(
      id: 'prod_${DateTime.now().millisecondsSinceEpoch}',
      title: draft.title,
      description: draft.description,
      price: draft.basePrice,
      category: draft.category,
      dimensions: '${draft.diameterIn}" W x ${draft.heightIn}" H',
      stockQuantity: draft.dailyCapacityPcs * 10,
      imageUrls: [draft.photoUrl],
    );
    await addProduct(newProduct);
  }

  Future<void> updateProduct(String productId, {double? price, int? stock}) async {
    final idx = _products.indexWhere((p) => p.id == productId);
    if (idx != -1) {
      _products[idx] = _products[idx].copyWith(
        price: price ?? _products[idx].price,
        stockQuantity: stock ?? _products[idx].stockQuantity,
      );
      _productsStreamController.add(List.unmodifiable(_products));
    }
  }

  Future<void> updateProductPrice(String productId, double newPrice) async {
    await updateProduct(productId, price: newPrice);
  }

  Future<void> deleteProduct(String productId) async {
    _products.removeWhere((p) => p.id == productId);
    _productsStreamController.add(List.unmodifiable(_products));
  }
}
