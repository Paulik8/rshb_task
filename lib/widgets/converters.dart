import 'package:rshb_test/product/models/catalogModel.dart';

String convertToUnit(num value) {
  if (value ==  0) return "__";
  return value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 1);
}

bool isImageFromAssets(String url) {
      final firstBlock = url.split('/').first;
      return firstBlock == 'assets';
    } 

class ProductSorter {

  List<Product> sortByRating(List<Product> products, {bool ascending = false}) {
    if (!ascending) products.sort((b, a) => a.totalRating.compareTo(b.totalRating));
    return products;
  }

  List<Product> sortByPrice(List<Product> products, {bool ascending = true}) {
    if (ascending) products.sort((a, b) => a.price.compareTo(b.price));
    return products;
  }

  // List<Product> sortByCategoryId(List<Product> products, {int id}) {
  //   return products.where((el) => el.categoryId == id);
  // }

  List<Product> sortByCategoryIdAndSortedByFilter(List<Product> products, {List<Product> cProducts, int id, bool byRating = true}) {
    if (cProducts == null) {
      cProducts = List();
    }
    var categoryProducts = products.where((el) => el.categoryId == id);
    if (byRating) {
      return sortByRating(cProducts..addAll(categoryProducts));
    } else {
      return sortByPrice(cProducts..addAll(categoryProducts));
    }
  }

}
  