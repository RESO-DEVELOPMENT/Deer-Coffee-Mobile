import 'package:deer_coffee/api/menu_api.dart';
import 'package:deer_coffee/models/blog.dart';
import 'package:deer_coffee/models/store.dart';
import 'package:deer_coffee/view_models/base_view_model.dart';
import 'package:get/get.dart';

import '../enums/product_enum.dart';
import '../enums/view_status.dart';
import '../models/category.dart';
import '../models/collection.dart';
import '../models/menu.dart';
import '../models/product.dart';

class MenuViewModel extends BaseViewModel {
  late Menu? currentMenu;
  MenuAPI? menuAPI;
  List<Product>? normalProducts = [];
  List<Category>? categories = [];
  List<Collection>? collections = [];
  List<Product>? extraProducts = [];
  List<Product>? childProducts = [];
  List<Product>? productsFilter = [];

  List<StoreModel>? storeList = [];
  List<BlogModel>? blogList = [];
  MenuViewModel() {
    menuAPI = MenuAPI();
    currentMenu = Menu();
  }

  Future<void> getMenuOfBrand() async {
    try {
      setState(ViewStatus.Loading);
      currentMenu = await menuAPI?.getBrandMenu();
      categories = currentMenu?.categories!
          .where((element) => element.type == CategoryTypeEnum.Normal)
          .toList();
      categories?.sort((a, b) => b.displayOrder!.compareTo(a.displayOrder!));
      collections = currentMenu?.collections!;
      normalProducts = currentMenu?.products!
          .where((element) =>
              element.type == ProductTypeEnum.SINGLE ||
              element.type == ProductTypeEnum.PARENT ||
              element.type == ProductTypeEnum.COMBO)
          .toList();
      extraProducts = currentMenu?.products!
          .where((element) => element.type == ProductTypeEnum.EXTRA)
          .toList();
      childProducts = currentMenu?.products!
          .where((element) => element.type == ProductTypeEnum.CHILD)
          .toList();
      productsFilter = normalProducts;
      productsFilter
          ?.sort((a, b) => b.displayOrder!.compareTo(a.displayOrder!));
      setState(ViewStatus.Completed);
      print(currentMenu);
    } catch (e) {
      setState(ViewStatus.Error, e.toString());
    }
  }

  Future getListStore() async {
    setState(ViewStatus.Loading);
    storeList = await menuAPI?.getListStore();
    setState(ViewStatus.Completed);
  }

  Future getListBlog() async {
    setState(ViewStatus.Loading);
    blogList = await menuAPI?.getListBlog();
    setState(ViewStatus.Completed);
  }

  Product getProductById(String id) {
    return normalProducts!.firstWhere((element) => element.id == id);
  }

  List<Product> getProductsByCategory(String? categoryId) {
    notifyListeners();
    return extraProducts!
        .where((element) => element.categoryId == categoryId)
        .toList();
  }
   List<Product> getNormalProductsByCategory(String? categoryId) {
    notifyListeners();
    return normalProducts!
        .where((element) => element.categoryId == categoryId)
        .toList();
  }

  List<Product> getProductsByCollection(String? collectionID) {
    return normalProducts!
        .where((element) => ((element.collectionIds == null)
            ? false
            : element.collectionIds!.contains(collectionID)))
        .toList();
  }

  List<Category>? getExtraCategoryByNormalProduct(Product product) {
    List<Category> listExtraCategory = [];
    for (Category item in currentMenu!.categories!) {
      if (product.extraCategoryIds!.contains(item.id)) {
        listExtraCategory.add(item);
      }
    }
    notifyListeners();
    return listExtraCategory;
  }

  List<Product>? getChildProductByParentProduct(String? productId) {
    List<Product> listChilds = childProducts!
        .where((element) => element.parentProductId == productId)
        .toList();

    List<Product> listChildsSorted = [];
    for (Product item in listChilds) {
      if (item.size == ProductSizeEnum.SMALL) {
        listChildsSorted.add(item);
      }
    }
    for (Product item in listChilds) {
      if (item.size == ProductSizeEnum.MEDIUM) {
        listChildsSorted.add(item);
      }
    }
    for (Product item in listChilds) {
      if (item.size == ProductSizeEnum.LARGE) {
        listChildsSorted.add(item);
      }
    }
    notifyListeners();
    return listChildsSorted;
  }
}
