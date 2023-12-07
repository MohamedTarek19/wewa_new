import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wewa/app_brain/api_end_points.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

part 'wewa_products_state.dart';

class WewaProductsCubit extends Cubit<WewaProductsState> {
  WewaProductsCubit() : super(WewaProductsInitial());


  Future getProducts() async {
    // Initialize the API
    try{
      emit(WewaProductsLoading());
      WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
          url: baseurl,
          consumerKey: consumerKey,
          consumerSecret: consumerSecret);

      // Get data using the "products" endpoint
      var products = await wooCommerceAPI.getAsync("products");
      emit(WewaProductsSuccess());
      print(products.first);
      return products;
    }catch(e){
      print('didn\'t get: ${e}');
      emit(WewaProductsFail());
      return null;
    }

  }
}
