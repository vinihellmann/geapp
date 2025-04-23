import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geapp/app/provider/list_provider.dart';
import 'package:geapp/modules/image/models/image_model.dart';
import 'package:geapp/modules/image/repositories/image_repository.dart';
import 'package:geapp/modules/product/models/product_model.dart';
import 'package:geapp/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class ImageListProvider extends ListProvider<ImageModel> {
  ImageRepository repository;
  ImageListProvider(this.repository);

  updateDependencies(ImageRepository repo) {
    repository = repo;
    notifyListeners();
  }

  ImagePicker picker = ImagePicker();
  ProductModel? product;

  List<dynamic> whereArgs = [];
  String? whereClause;

  @override
  String orderBy = "createdAt";

  Future<void> init(ProductModel model) async {
    product = model;
    await getData();
  }

  @override
  Future<void> getData() async {
    if (product == null) return;
    changeIsLoading();

    try {
      await generateWhere();

      final itemList = <ImageModel>[];
      final result = await repository.search(
        whereClause,
        whereArgs,
        page,
        limit,
        orderBy,
      );

      for (var item in result.data) {
        final object = ImageModel.fromMap(item);
        itemList.add(object);
      }

      items = itemList;
      totalItems = result.totalItems;
      totalPages = result.totalPages;

      notifyListeners();
    } catch (e) {
      log("ImageListProvider::getData - $e");
      Utils.showToast(e.toString(), ToastType.error);
    } finally {
      changeIsLoading();
    }
  }

  Future<bool?> save(ImageModel image) async {
    try {
      changeIsLoading();

      final result = await repository.upsert(image);
      return result != null;
    } catch (e) {
      log("ImageListProvider::save - $e");
      return null;
    } finally {
      changeIsLoading();
    }
  }

  Future<bool?> delete(ImageModel image) async {
    try {
      changeIsLoading();

      final result = await repository.delete(image);
      product?.images.remove(image);
      return result != null;
    } catch (e) {
      log("ImageListProvider::delete - $e");
      return null;
    } finally {
      changeIsLoading();
    }
  }

  Future<void> generateWhere() async {
    List<String> whereList = [];
    whereClause = null;
    whereArgs.clear();

    whereList.add("productCode = ?");
    whereArgs.add(product?.code);

    whereClause = whereList.isNotEmpty ? whereList.join(' AND ') : null;
  }

  Future<bool> pickImage(BuildContext context) async {
    try {
      XFile? picked = await picker.pickImage(source: ImageSource.gallery);

      if (picked != null) {
        final bytes = await picked.readAsBytes();
        final base64Image = base64Encode(bytes);

        final newImage = ImageModel(
          productCode: product?.code,
          image: base64Image,
        );

        await save(newImage);
        product?.images.add(newImage);
        return true;
      }

      return false;
    } catch (e) {
      log("ImageListProvider::pickImage - $e");
      Utils.showToast(e.toString(), ToastType.error);
      return false;
    }
  }
}
