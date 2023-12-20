import 'dart:ui';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wewa/bussiness_logic/state_cubits/wewa_products_cubit.dart';
import 'package:wewa/models/ProductModel.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({Key? key, required this.product, required this.Category}) : super(key: key);
  ProductModel product;
  String Category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        margin: const EdgeInsets.only(right: 15, left: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Category > ',
                    style: TextStyle(color: Colors.grey[500], fontSize: 15),
                  ),
                  Text(
                    '$Category',
                    style: const TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  '${product.name}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.33,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: product.images?.first['src'],
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  ),
                  const Positioned(
                    width: 40,
                    height: 40,
                    right: 10,
                    top: 15,
                    child: BlurryContainer(
                      color: Colors.black12,
                      blur: 10,
                      elevation: 5,
                      child: Icon(
                        Icons.favorite_outline,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    width: 90,
                    height: 30,
                    left: 10,
                    bottom: 15,
                    child: BlurryContainer(
                      padding: const EdgeInsets.only(left: 2, right: 2),
                      color: Colors.black12,
                      blur: 10,
                      elevation: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow[500],
                          ),
                          Text("${product.rate} (+999)",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("د.إ",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff0CB502),
                        )),
                    Text(
                      ' ${product.price} ',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Card(
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Sold by: Vendor Name',
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.star,
                                size: 25,
                                color: Colors.yellow[500],
                              ),
                              Text("${product.rate} (+999)",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ))
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            '47811 Melisa Squares,',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.location_on_sharp,
                                size: 25,
                                color: Colors.grey[500],
                              ),
                              Text("1.5 Km",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Details',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  '${product.description}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      backgroundColor: const Color(0xff0CB502),
                      shadowColor: const Color(0xff0CB502),
                      elevation: 5),
                  onPressed: (){

                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [SvgPicture.asset('assets/images/Icons/buyCart.svg'),SizedBox(width: 5), const Text("Add to cart", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white))],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              SectionHead(title: 'Suggestted', seeMore: () {
                Navigator.pop(context);
              }),
              BlocBuilder<WewaProductsCubit, WewaProductsState>(
                builder: (context, state) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10, top: 10),
                    height: 250,
                    child: context.read<WewaProductsCubit>().flag == false
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  context.read<WewaProductsCubit>().FilteredProducts[index].description = context.read<WewaProductsCubit>().parseHtmlString(context.read<WewaProductsCubit>().FilteredProducts[index].description??'').trim();
                                  context.read<WewaProductsCubit>().FilteredProducts[index].description = context.read<WewaProductsCubit>().FilteredProducts[index].description?.replaceAll('\n', ',');

                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                    return ProductDetailsScreen(product: context.read<WewaProductsCubit>().FilteredProducts[index],Category: Category,);
                                  },));
                                },
                                child: CartItem(
                                  productImage: context.read<WewaProductsCubit>().FilteredProducts[index].images?.first['src'],
                                  title: context.read<WewaProductsCubit>().FilteredProducts[index].name ?? '',
                                  addToCartOnTap: () {},
                                  price: context.read<WewaProductsCubit>().FilteredProducts[index].price ?? '',
                                  rate: context.read<WewaProductsCubit>().FilteredProducts[index].rate.toString(),
                                ),
                              );
                            },
                            itemCount: context.read<WewaProductsCubit>().FilteredProducts.length,
                          ),
                  );
                },
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
    return Directionality(
      textDirection: arabic.hasMatch(title) ? TextDirection.rtl : TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 140,
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
                        height: 130,
                        width: 170,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(productImage),
                              fit: BoxFit.fill,
                            )),
                      ),
                      Positioned(
                        width: 35,
                        height: 35,
                        right: 5,
                        top: 5,
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.black),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                              child: const Icon(Icons.favorite_outline, color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 90,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow[500],
                        ),
                        Text("$rate (+999)",
                            style: const TextStyle(
                              fontSize: 12,
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

class SectionHead extends StatelessWidget {
  SectionHead({super.key, required this.title, required this.seeMore});

  String title;
  void Function() seeMore;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            )),
        InkWell(
          onTap: seeMore,
          child: const Text(
            "See All",
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xA6000000),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}