import 'package:core/core.dart';
import 'package:ecommerce_task/features/home/presentation/riverpod/product_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productNotifierProvider =
NotifierProvider<ProductNotifier, BaseState>(
  ProductNotifier.new,
);