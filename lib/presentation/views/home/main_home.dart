import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wewa/bussiness_logic/state_cubits/connectivity_cubit.dart';
import 'package:wewa/bussiness_logic/state_cubits/screens_cubit.dart';
import 'package:wewa/bussiness_logic/state_cubits/wewa_products_cubit.dart';
import 'package:wewa/presentation/views/home/Categories_pages/filtered_items_screen.dart';
import 'package:wewa/presentation/views/home/cart_screens/cart_screen.dart';
import 'package:wewa/presentation/views/home/notification_screens/notification_screen.dart';
import 'package:wewa/presentation/views/home/product_details_screens/poduct_details_screen.dart';

class MainHome extends StatelessWidget {
  MainHome({Key? key}) : super(key: key);
  int _current = 0;
  final CarouselController _controller = CarouselController();

  final List<String> imgList = [
    'assets/images/imagesData/Specials card.svg',
    'assets/images/imagesData/Specials card.svg',
    'assets/images/imagesData/Specials card.svg',
  ];
  final List<String> imgList2 = [
    'assets/images/imagesData/coffie.png',
    'assets/images/imagesData/coffie.png',
    'assets/images/imagesData/coffie.png',
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = imgList
        .map(
          (item) => ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: const Color(0xff0CB502),
              child: Stack(
                //fit: StackFit.expand,
                children: <Widget>[
                  SvgPicture.asset(
                    item,
                    fit: BoxFit.contain,
                    height: MediaQuery.of(context).size.height * 0.38,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Positioned(
                    top: 35,
                    left: 130,
                    child: Image.asset(
                      'assets/images/imagesData/coffie.png',
                      fit: BoxFit.fill,
                      height: MediaQuery.of(context).size.height * 0.28,
                      width: MediaQuery.of(context).size.width * 0.55,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        .toList();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<WewaProductsCubit, WewaProductsState>(
          builder: (context, state) {
            return BlocConsumer<ConnectivityCubit, ConnectivityState>(
              listener: (context, state) async {
                if (context.read<ConnectivityCubit>().connected == 'wifi' || context.read<ConnectivityCubit>().connected == 'mobile') {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Internet Connection restored!!',style: TextStyle(color: Colors.black)),backgroundColor: Colors.green,));
                  await context.read<WewaProductsCubit>().fillCategories();
                  await context.read<WewaProductsCubit>().getFilteredFlavors('121');
                }else if(context.read<ConnectivityCubit>().connected == 'none'){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No internet Connection\n\"Please open your wifi or your data and wait for reloading\"'),backgroundColor: Colors.red,));
                }
              },
              builder: (context, state) {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      floating: true,
                      expandedHeight: MediaQuery.of(context).size.height * 0.17,
                      backgroundColor: Colors.white,
                      surfaceTintColor: Colors.white,
                      elevation: 10,
                      scrolledUnderElevation: 5,
                      title: SvgPicture.asset(
                        'assets/images/logos/inAppLogo.svg',
                        height: 50,
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return NotificationScreen();
                                },
                              ));
                            },
                            icon: SvgPicture.asset(
                              'assets/images/Icons/notification.svg',
                              height: 18,
                            ),
                            style: IconButton.styleFrom(
                              backgroundColor: const Color(0xccE9F8E4),
                              minimumSize: const Size(44, 44),
                              maximumSize: const Size(44, 44),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: IconButton(
                            style: IconButton.styleFrom(
                              backgroundColor: const Color(0xccE9F8E4),
                              minimumSize: const Size(44, 44),
                              maximumSize: const Size(44, 44),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return CartScreen();
                                },
                              ));
                            },
                            icon: SvgPicture.asset(
                              'assets/images/Icons/cart.svg',
                              height: 18,
                            ),
                          ),
                        ),
                      ],
                      bottom: AppBar(
                        surfaceTintColor: Colors.white,
                        backgroundColor: Colors.white,
                        flexibleSpace: Container(
                          margin: const EdgeInsets.only(right: 20, left: 20),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: const Color(0xffA8A8A8))),
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
                                  const Expanded(
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
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          SafeArea(
                            top: true,
                            minimum: const EdgeInsets.only(
                              top: 60,
                              left: 24,
                              right: 24,
                            ),
                            left: true,
                            right: true,
                            child: Column(
                              children: [
                                SectionHead(title: 'Special Offers', seeMore: () {}),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10, top: 10),
                                  height: MediaQuery.of(context).size.height * 0.33,
                                  alignment: Alignment.center,
                                  child: StatefulBuilder(
                                    builder: (BuildContext context, void Function(void Function()) setState) {
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context).size.height * 0.28,
                                            width: MediaQuery.of(context).size.width,
                                            child: CarouselSlider(
                                              carouselController: _controller,
                                              options: CarouselOptions(
                                                autoPlay: true,
                                                onPageChanged: (index, reason) {
                                                  setState(() {
                                                    _current = index;
                                                  });
                                                },
                                                viewportFraction: 1,
                                                enlargeFactor: 0.7,
                                                enlargeCenterPage: true,
                                              ),
                                              items: imageSliders,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: imgList.asMap().entries.map((entry) {
                                              return AnimatedContainer(
                                                duration: const Duration(milliseconds: 500),
                                                width: _current == entry.key ? 18.0 : 10,
                                                height: 10.0,
                                                margin: const EdgeInsets.only(right: 5, left: 5, top: 5),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(50),
                                                  shape: BoxShape.rectangle,
                                                  color: (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black).withOpacity(
                                                    _current == entry.key ? 0.9 : 0.4,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                BlocBuilder<ScreensCubit, ScreensState>(
                                  builder: (context, state) {
                                    return SectionHead(
                                        title: 'Categories',
                                        seeMore: () {
                                          context.read<ScreensCubit>().selectPage(2);
                                        });
                                  },
                                ),

                                Container(
                                  margin: const EdgeInsets.only(bottom: 10, top: 10),
                                  height: 100,
                                  child: context.read<WewaProductsCubit>().flag == false
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: context.read<WewaProductsCubit>().Categories.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            return InkWell(
                                              onTap: () async {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return Center(child: CircularProgressIndicator());
                                                  },
                                                );
                                                context.read<WewaProductsCubit>().cat = context.read<WewaProductsCubit>().Categories[index];
                                                await context.read<WewaProductsCubit>().getCategoryProducts(
                                                      categoryId: context.read<WewaProductsCubit>().Categories[index].id ?? 0,
                                                      pageNumber: 1,
                                                    );
                                                await context.read<WewaProductsCubit>().scrollIntializer();
                                                Navigator.pop(context);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return FilteredItemsScreen(
                                                        title: context.read<WewaProductsCubit>().Categories[index].categoryName ?? '',
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                              child: Categories(
                                                icon: context.read<WewaProductsCubit>().Categories[index].CategoryImg,
                                                title: context.read<WewaProductsCubit>().Categories[index].categoryName ?? '',
                                              ),
                                            );
                                          },
                                        ),
                                ),
                                SectionHead(title: 'Top Seller', seeMore: () {}),
//
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10, top: 10),
                                  height: 250,
                                  child: context.read<WewaProductsCubit>().flag2 == false
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                context.read<WewaProductsCubit>().FilteredProducts2[index].description = context.read<WewaProductsCubit>().parseHtmlString(context.read<WewaProductsCubit>().FilteredProducts2[index].description ?? '').trim();
                                                context.read<WewaProductsCubit>().FilteredProducts2[index].description = context.read<WewaProductsCubit>().FilteredProducts2[index].description?.replaceAll('\n', ',');

                                                Navigator.push(context, MaterialPageRoute(
                                                  builder: (context) {
                                                    return ProductDetailsScreen(
                                                      product: context.read<WewaProductsCubit>().FilteredProducts2[index],
                                                      Category: 'Top Seller',
                                                    );
                                                  },
                                                ));
                                              },
                                              child: CartItem(
                                                productImage: context.read<WewaProductsCubit>().FilteredProducts2[index].images?.first['src'],
                                                title: context.read<WewaProductsCubit>().FilteredProducts2[index].name ?? '',
                                                addToCartOnTap: () {},
                                                price: context.read<WewaProductsCubit>().FilteredProducts2[index].price ?? '',
                                                rate: context.read<WewaProductsCubit>().FilteredProducts2[index].rate.toString(),
                                              ),
                                            );
                                          },
                                          itemCount: 5,
                                        ),
                                ),
                                SectionHead(title: 'Trending', seeMore: () {}),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10, top: 10),
                                  height: 250,
                                  child: context.read<WewaProductsCubit>().flag2 == false
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                context.read<WewaProductsCubit>().FilteredProducts2[index].description = context.read<WewaProductsCubit>().parseHtmlString(context.read<WewaProductsCubit>().FilteredProducts2[index].description ?? '').trim();
                                                context.read<WewaProductsCubit>().FilteredProducts2[index].description = context.read<WewaProductsCubit>().FilteredProducts2[index].description?.replaceAll('\n', ',');

                                                Navigator.push(context, MaterialPageRoute(
                                                  builder: (context) {
                                                    return ProductDetailsScreen(
                                                      product: context.read<WewaProductsCubit>().FilteredProducts2[index],
                                                      Category: 'Trending',
                                                    );
                                                  },
                                                ));
                                              },
                                              child: CartItem(
                                                productImage: context.read<WewaProductsCubit>().FilteredProducts2[index].images?.first['src'],
                                                title: context.read<WewaProductsCubit>().FilteredProducts2[index].name ?? '',
                                                addToCartOnTap: () {},
                                                price: context.read<WewaProductsCubit>().FilteredProducts2[index].price ?? '',
                                                rate: context.read<WewaProductsCubit>().FilteredProducts2[index].rate.toString(),
                                              ),
                                            );
                                          },
                                          itemCount: 10,
                                        ),
                                ),
                                Container(margin: const EdgeInsets.only(top: 8, bottom: 8), child: Image.asset('assets/images/imagesData/card2.png')),
                                SectionHead(title: 'Top Flavors', seeMore: () {}),
                                Column(
                                  children: [
                                    Container(
                                      //color: Colors.blue,
                                      margin: const EdgeInsets.only(bottom: 10, top: 10),
                                      height: 60,
                                      width: MediaQuery.of(context).size.width,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            FilterItem(
                                              title: "All",
                                              FilterOnTap: () async {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return Center(child: CircularProgressIndicator());
                                                  },
                                                );
                                                await context.read<WewaProductsCubit>().getFilteredFlavors('121');
                                                Navigator.pop(context);
                                              },
                                            ),
                                            FilterItem2(
                                              title: "Special",
                                              FilterOnTap: () async {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return Center(child: CircularProgressIndicator());
                                                  },
                                                );
                                                await context.read<WewaProductsCubit>().getFilteredFlavors('92');
                                                Navigator.pop(context);
                                              },
                                            ),
                                            FilterItem2(
                                              title: "Karak",
                                              FilterOnTap: () async {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return Center(child: CircularProgressIndicator());
                                                  },
                                                );
                                                await context.read<WewaProductsCubit>().getFilteredFlavors('87');
                                                Navigator.pop(context);
                                              },
                                            ),
                                            FilterItem2(
                                              title: "tea",
                                              FilterOnTap: () async {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return Center(child: CircularProgressIndicator());
                                                  },
                                                );
                                                await context.read<WewaProductsCubit>().getFilteredFlavors('85');
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    context.read<WewaProductsCubit>().flag2 == false
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : context.read<WewaProductsCubit>().FilteredProducts.isEmpty
                                            ? Container()
                                            : Container(
                                                margin: const EdgeInsets.only(bottom: 10, top: 0),
                                                height: 250,
                                                child: ListView.builder(
                                                  scrollDirection: Axis.horizontal,
                                                  itemBuilder: (context, index) {
                                                    return InkWell(
                                                      onTap: () {
                                                        context.read<WewaProductsCubit>().FilteredProducts[index].description = context.read<WewaProductsCubit>().parseHtmlString(context.read<WewaProductsCubit>().FilteredProducts[index].description ?? '').trim();
                                                        context.read<WewaProductsCubit>().FilteredProducts[index].description = context.read<WewaProductsCubit>().FilteredProducts[index].description?.replaceAll('\n', ',');

                                                        Navigator.push(context, MaterialPageRoute(
                                                          builder: (context) {
                                                            return ProductDetailsScreen(
                                                              product: context.read<WewaProductsCubit>().FilteredProducts[index],
                                                              Category: 'Top Flavors',
                                                            );
                                                          },
                                                        ));
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
                                              ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class FilterItem2 extends StatelessWidget {
  FilterItem2({
    super.key,
    required this.title,
    required this.FilterOnTap,
  });

  String title;
  void Function() FilterOnTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          surfaceTintColor: Colors.transparent,
          backgroundColor: const Color(0xffE9F8E4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          minimumSize: const Size(110, 35),
          maximumSize: const Size(110, 35),
        ),
        onPressed: FilterOnTap,
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 13,
            color: Color(0xff36d02d),
          ),
        ),
      ),
    );
  }
}

class FilterItem extends StatelessWidget {
  FilterItem({
    super.key,
    required this.title,
    required this.FilterOnTap,
  });

  String title;
  void Function() FilterOnTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Container(
        width: 110,
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color(0xff0CB502),
          gradient: const LinearGradient(colors: [
            Color(0xff36d02d),
            Color(0xff02b529),
          ], transform: GradientRotation(pi / 4)),
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
            ),
            BoxShadow(
              color: Color(0xff0CB502),
              spreadRadius: -12.0,
              blurRadius: 12.0,
            ),
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            //Color(0xff0CB502),
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            minimumSize: const Size(110, 35),
            maximumSize: const Size(110, 35),
            visualDensity: const VisualDensity(horizontal: 1),
          ),
          onPressed: FilterOnTap,
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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

class Categories extends StatelessWidget {
  const Categories({
    super.key,
    required this.icon,
    required this.title,
  });

  final String? icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              height: 60,
              width: 60,
              imageUrl: icon ?? '',
              errorWidget: (context, url, error) => const Icon(Icons.image_not_supported_outlined),
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
