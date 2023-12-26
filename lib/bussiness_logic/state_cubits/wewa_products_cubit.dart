import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:wewa/app_brain/api_end_points.dart';
import 'package:wewa/models/ProductModel.dart';
import 'package:wewa/models/categories_model.dart';
import 'package:wewa/presentation/views/home/main_home.dart';
import 'package:woocommerce_api/woocommerce_api.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';


part 'wewa_products_state.dart';

class WewaProductsCubit extends Cubit<WewaProductsState> {
  WewaProductsCubit() : super(WewaProductsInitial());
  List<CategoriesModel> Categories = [];
  List<ProductModel> Products = [];
  List<ProductModel> FilteredProducts = [];
  List<ProductModel> FilteredProducts2 = [];
  bool flag = false;
  bool flag2 = false;
  int catId = 0;
  int pageNum = 0;
  int itemCount = 0;
  bool isLoading = false;
  late ScrollController controller;
  late CategoriesModel cat;
  fillCategories() async {
    Categories.clear();
    WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
        url: baseurl, consumerKey: consumerKey, consumerSecret: consumerSecret);
    // Get data using the "products" endpoint
    var categories = await wooCommerceAPI.getAsync("products/categories/?per_page=100");
    print(categories.length);
    for (Map<String, dynamic> v in categories) {
      if (v['image'] != null) {
        Categories.add(CategoriesModel(
          id: v['id'],
          categoryName: v['name'],
          CategoryImg: v['image']['src'],
          numberOfitems: v['count'],
        ));
      } else {
        Categories.add(CategoriesModel(
            id: v['id'],
            categoryName: v['name'],
            CategoryImg: '',
            numberOfitems: v['count'],
        ));
      }
    }
    flag = true;
    emit(WewaCategorisSuccess());
  }

  Future getCategoryProducts({required int categoryId,required int pageNumber}) async {
    // Initialize the API
    print(categoryId);
      Products.clear();
      catId = categoryId;
      
      itemCount = 0;
      emit(WewaProductsNewCat());

    pageNum=1;
      try {
        emit(WewaProductsLoading());
        var headers = {
          'X-WP-Total': '100',
          'X-WP-TotalPages': '100',
          'Authorization': 'Basic Y2tfZWFlYmE3NTVhNjY0ODE2NmQyM2I5OGQxMmU1YTU0MDdiY2FkZDRkYTpjc180NDAyOWI3YmI1ZTQ2NjEyNzIwODdhNzA3YTBmODViNjhhZDBhZDk2',
        };
        var url = Uri.parse('https://wewatea.com/wp-json/wc/v3/products?category=${categoryId}&per_page=10&page=1');
        var response1 = await http.get(url,headers: headers);
        var res1 = jsonDecode(response1.body) as List;

        print(res1.length);
        for (var pr in res1) {
          Products.add(
            ProductModel(
              name: pr['name'],
              description: pr['description'],
              price: pr['price'],
              category: pr['categories'],
              images: pr['images'],
              rate: pr['rating_count'],
            ),
          );
          //print(pr['images'].runtimeType);
        }
        itemCount = Products.length;
        print(Products.length);
        emit(WewaProductsSuccess());
      } catch (e) {
        emit(WewaProductsFail());
        return null;
      }



  }
  
  scrollIntializer(){
    controller = ScrollController();
  }

  Future<bool> DisposeController() async{
    controller.dispose();
    return true;
  }
  Future KeepScrolling({int? pageNumber}) async {
    print(10);
    if (controller.position.pixels == controller.position.maxScrollExtent && !isLoading){
      isLoading = true;
      emit(WewaProductsLoading());
      pageNum++;
      try {
        var headers = {
          'X-WP-Total': '100',
          'X-WP-TotalPages': '100',
          'Authorization': 'Basic Y2tfYTE4MjY2YTRlMjQwZjQ0ZDk5MmQ3MTAyNTc0MzNmZGQ1YjdmYTllMjpjc182ZTM5ZmJlZjcxYTkwMjJiYzc5ZDcxY2QwZGZiMGI2MWQ0OWU4ZTFk',
        };
        var url = Uri.parse('https://wewatea.com/wp-json/wc/v3/products?category=${catId}&per_page=10&page=${pageNum}');
        var response1 = await http.get(url,headers: headers);
        var res1 = jsonDecode(response1.body) as List;

        print(res1.length);
        for (var pr in res1) {
          Products.add(
            ProductModel(
              name: pr['name'],
              description: pr['description'],
              price: pr['price'],
              category: pr['categories'],
              images: pr['images'],
              rate: pr['rating_count'],
            ),
          );
          //print(pr['images'].runtimeType);
        }
        itemCount = Products.length;
        print(Products.length);

      } catch (e) {
        emit(WewaProductsFail());
        return null;
      }
    }

    isLoading = false;
    emit(WewaProductsSuccess());

  }




  Future getFilteredFlavors(String category) async {
    var headers = {
      'X-WP-Total': '100',
      'X-WP-TotalPages': '100',
      'Authorization': 'Basic Y2tfYTE4MjY2YTRlMjQwZjQ0ZDk5MmQ3MTAyNTc0MzNmZGQ1YjdmYTllMjpjc182ZTM5ZmJlZjcxYTkwMjJiYzc5ZDcxY2QwZGZiMGI2MWQ0OWU4ZTFk',
    };
    late Uri url;
    if(category =='121'){
      url = Uri.parse('https://wewatea.com/wp-json/wc/v3/products?per_page=10&page=1');
    }else{
      url = Uri.parse('https://wewatea.com/wp-json/wc/v3/products?category=$category&per_page=10&page=1');
    }
    FilteredProducts.clear();
    var response1 = await http.get(url,headers: headers);
    var res1 = jsonDecode(response1.body) as List;
    for (var pr in res1) {
      FilteredProducts.add(
        ProductModel(
          name: pr['name'],
          description: pr['description'],
          price: pr['price'],
          category: pr['categories'],
          images: pr['images'],
          rate: pr['rating_count'],
        ),
      );
      //print(pr['images'].runtimeType);
    }
    if(category =='121'){
      FilteredProducts2.addAll(FilteredProducts);
    }
    flag2 = true;

    emit(WewaProductsFiltered());
  }

  String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body?.text).documentElement!.text;

    return parsedString;
  }


}

