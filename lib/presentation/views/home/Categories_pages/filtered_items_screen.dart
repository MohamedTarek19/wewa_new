import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wewa/bussiness_logic/state_cubits/wewa_products_cubit.dart';
import 'package:wewa/presentation/views/home/product_details_screens/poduct_details_screen.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';

class FilteredItemsScreen extends StatelessWidget {
  FilteredItemsScreen({Key? key, required this.title}) : super(key: key);
  String title;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: context.read<WewaProductsCubit>().DisposeController,
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: SvgPicture.asset(
            'assets/images/logos/inAppLogo.svg',
            height: 50,
          ),
          centerTitle: true,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height * 0.92,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 5),
                child: Container(
                  margin: const EdgeInsets.only(right: 20, left: 20),
                  child: Container(
                    height: MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.07 : MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Color(0xffEBEBEB), border: Border.all(color: const Color(0xffEBEBEB))),
                    child: Center(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 20,
                              child: SvgPicture.asset(
                                'assets/images/Icons/search.svg',
                                height: 20,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 9,
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'What are you calving',
                                contentPadding: EdgeInsets.all(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  //height: MediaQuery.of(context).orientation == Orientation.portrait?MediaQuery.of(context).size.height * 0.77:MediaQuery.of(context).size.height * 0.52,
                  width: MediaQuery.of(context).size.width,
                  child: BlocBuilder<WewaProductsCubit, WewaProductsState>(
                    builder: (context, state) {
                      return GestureDetector(
                        onHorizontalDragUpdate: (details) async {
                          if (details.delta.dx < 0 && context.read<WewaProductsCubit>().itemCount < (context.read<WewaProductsCubit>().cat.numberOfitems ?? 0)) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Center(child: CircularProgressIndicator());
                              },
                            );
                            await context.read<WewaProductsCubit>().KeepScrolling();
                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                          child: SingleChildScrollView(
                            controller: context.read<WewaProductsCubit>().controller,
                            child: LayoutGrid(
                              columnSizes: [2.fr,2.fr],
                              rowSizes: [auto,auto,auto,auto,auto,auto,],
                              columnGap: 5,rowGap: 10,
                              children: [
                                for(int index = 0;index <context.read<WewaProductsCubit>().Products.length;index++)
                                  InkWell(
                                    onTap: () {
                                      context.read<WewaProductsCubit>().Products[index].description = context.read<WewaProductsCubit>().parseHtmlString(context.read<WewaProductsCubit>().Products[index].description??'').trim();
                                      context.read<WewaProductsCubit>().Products[index].description = context.read<WewaProductsCubit>().Products[index].description?.replaceAll('\n', ',');

                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        return ProductDetailsScreen(product: context.read<WewaProductsCubit>().Products[index],Category: title,);
                                      },));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 1),
                                      child: CartItem(
                                        title: context.read<WewaProductsCubit>().Products[index].name ?? '',
                                        productImage: context.read<WewaProductsCubit>().Products[index].images?.first['src'],
                                        price: context.read<WewaProductsCubit>().Products[index].price??'',
                                        rate: context.read<WewaProductsCubit>().Products[index].rate.toString(),
                                        addToCartOnTap: (){},
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  CartItem({
    super.key,
    required this.productImage,
    required this.addToCartOnTap,
    required this.price,
    required this.rate,
    required this.title,
  });

  String productImage;
  String title;
  String rate;
  String price;
  void Function() addToCartOnTap;
  final RegExp arabic = RegExp(r'^[\u0621-\u064A]+');

  @override
  Widget build(BuildContext context) {
    if (!(productImage.contains('https://') && productImage.contains('https://'))) {
      productImage = 'http://' + productImage;
    }
    // print(productImage);
    return Directionality(
      textDirection: arabic.hasMatch(title) ? TextDirection.rtl : TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.only(bottom:10),
        child: Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 220,
            width: 170,
            margin: const EdgeInsets.only(
              left: 4,
              right: 4,
              top: 4,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      Container(
                        //margin: const EdgeInsets.only(left: 4,right: 4,top: 4,),
                        height: 120,
                        width: 170,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(productImage),
                              fit: BoxFit.fill,
                            )),
                      ),
                      Positioned(
                        width: 35,
                        height: 35,
                        right: 5,
                        top: 5,
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.black45),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                              child: const Icon(Icons.favorite_outline, color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 80,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    title,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow[500],
                                    size: 20,
                                  ),
                                  Text("$rate (+999)",
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400,
                                      ))
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                "24,90د.إ",
                                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, decoration: TextDecoration.lineThrough, color: Color(0x73000000)),
                              ),
                              Text("$priceد.إ",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff0CB502),
                                  )),
                            ],
                          ),
                        ],
                      )
                    : Container(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          backgroundColor: const Color(0xff0CB502),
                          shadowColor: const Color(0xff0CB502),
                          elevation: 5),
                      onPressed: addToCartOnTap,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [SvgPicture.asset('assets/images/Icons/buyCart.svg'), const Text("Add to cart", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white))],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
