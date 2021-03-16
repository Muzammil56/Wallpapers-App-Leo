import 'package:wallapaers_leo/model/categories_model.dart';

String apiKey ="563492ad6f91700001000001d6e6e3db2182420990db7b83959c1681";

List <CategoryModel> getCategories(){

  List<CategoryModel> categories = List();
  CategoryModel categoryModel = CategoryModel();
  //
  categoryModel.categoriesName = "Street Art";
  categories.add(categoryModel);
  categoryModel = CategoryModel();

  //
  categoryModel.categoriesName = "Wild Life";
  categories.add(categoryModel);
  categoryModel = CategoryModel();

  //
  categoryModel.categoriesName = "Nature";
  categories.add(categoryModel);
  categoryModel = CategoryModel();

  //
  categoryModel.categoriesName = "City";
  categories.add(categoryModel);
  categoryModel = CategoryModel();

  //
  categoryModel.categoriesName = "Motivation";

  categories.add(categoryModel);
  categoryModel = CategoryModel();

  //
  categoryModel.categoriesName = "Bikes";
  categories.add(categoryModel);
  categoryModel = CategoryModel();

  //
  categoryModel.categoriesName = "Cars";
  categories.add(categoryModel);
  categoryModel = CategoryModel();

  return categories;
}