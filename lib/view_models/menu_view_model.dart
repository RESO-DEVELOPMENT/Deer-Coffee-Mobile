import 'package:deer_coffee/api/menu_api.dart';
import 'package:deer_coffee/models/blog.dart';
import 'package:deer_coffee/models/store.dart';
import 'package:deer_coffee/view_models/base_view_model.dart';

import '../enums/product_enum.dart';
import '../enums/view_status.dart';
import '../models/category.dart';
import '../models/collection.dart';
import '../models/menu.dart';
import '../models/product.dart';
import '../utils/share_pref.dart';

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
  StoreModel? selectedStore;
  List<BlogModel>? blogList = [];
  MenuViewModel() {
    menuAPI = MenuAPI();
    currentMenu = Menu();
  }

  Future<void> getMenuOfBrand() async {
    try {
      setState(ViewStatus.Loading);
      currentMenu = await menuAPI?.getBrandMenu(selectedStore?.id ?? '');
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
      await getListBlog();

      setState(ViewStatus.Completed);
    } catch (e) {
      setState(ViewStatus.Error, e.toString());
    }
  }

  Future getListStore() async {
    setState(ViewStatus.Loading);
    storeList = await menuAPI?.getListStore();
    var storeId = await getStoreId();
    if (storeId != null) {
      var store = storeList?.firstWhere((element) => element.id == storeId);
      if (store == -1) {
        selectedStore = storeList![0];
        await setStoreId(selectedStore?.id);
      } else {
        selectedStore = store;
      }
    } else {
      selectedStore = storeList![0];
      await setStoreId(selectedStore?.id);
    }
    setState(ViewStatus.Completed);
  }

  Future<void> setStore(StoreModel store) async {
    setState(ViewStatus.Loading);
    selectedStore = store;
    await setStoreId(selectedStore?.id);
    await getMenuOfBrand();
    setState(ViewStatus.Completed);
  }

  Future getListBlog() async {
    setState(ViewStatus.Loading);
    blogList = await menuAPI?.getListBlog();
    blogList?.sort((a, b) => b.priority!.compareTo(a.priority!));
    setState(ViewStatus.Completed);
  }

  BlogModel? getBlogDetailById(String id) {
    return blogList?.firstWhere((element) => element.id == id);
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
