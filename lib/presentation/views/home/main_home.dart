import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                    height: MediaQuery.of(context).size.height*0.38,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Positioned(
                    top: 35,
                    left: 130,
                    child: Image.asset(
                      'assets/images/imagesData/coffie.png',
                      fit: BoxFit.fill,
                        height: MediaQuery.of(context).size.height*0.28,
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
        child: CustomScrollView(
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
                    onPressed: () {},
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
                    onPressed: () {},
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
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: const Color(0xffA8A8A8))),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Special Offers",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                )),
                            InkWell(
                              onTap: () {},
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
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10, top: 10),
                          height: MediaQuery.of(context).size.height*0.33,
                          alignment: Alignment.center,
                          child: StatefulBuilder(
                            builder: (BuildContext context,
                                void Function(void Function()) setState) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height*0.28,
                                    width:MediaQuery.of(context).size.width,
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
                                    children:
                                        imgList.asMap().entries.map((entry) {
                                      return AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        width:
                                            _current == entry.key ? 18.0 : 10,
                                        height: 10.0,
                                        margin: const EdgeInsets.only(
                                            right: 5, left: 5, top: 5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          shape: BoxShape.rectangle,
                                          color:
                                              (Theme.of(context).brightness ==
                                                          Brightness.dark
                                                      ? Colors.white
                                                      : Colors.black)
                                                  .withOpacity(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Categories",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                )),
                            InkWell(
                              onTap: () {},
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
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10, top: 10),
                          height: 100,
                          child: const SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Categories(
                                    icon: 'assets/images/Icons/flavors.png',
                                    title: 'Flavors'),
                                Categories(
                                    icon: 'assets/images/Icons/coffee.png',
                                    title: 'Coffee'),
                                Categories(
                                    icon: 'assets/images/Icons/offers.png',
                                    title: 'Offers'),
                                Categories(
                                    icon: 'assets/images/Icons/tea.png',
                                    title: 'Tea'),
                                Categories(
                                    icon: 'assets/images/Icons/biscuits.png',
                                    title: 'Biscuits'),
                                Categories(
                                    icon: 'assets/images/Icons/karak.png',
                                    title: 'Karak'),
                                Categories(
                                    icon: 'assets/images/Icons/tools.png',
                                    title: 'Tools'),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Top Seller",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                )),
                            InkWell(
                              onTap: () {},
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
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10, top: 10),
                          height: 250,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Material(
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    height: 120,
                                    width: 160,
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Stack(
                                            children: [
                                              Container(
                                                //margin: const EdgeInsets.only(left: 4,right: 4,top: 4,),
                                                height: 130,
                                                width: 160,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    image: const DecorationImage(
                                                      image: AssetImage(
                                                          'assets/images/imagesData/product.png'),
                                                      fit: BoxFit.fill,
                                                    )),
                                              ),
                                              Positioned(
                                                width: 35,
                                                height: 35,
                                                right: 5,
                                                top: 5,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(100),
                                                    color: Colors.white54
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(100),
                                                    child: BackdropFilter(
                                                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                                      child: Icon(Icons.favorite_outline,color: Colors.white),
                                                    ),
                                                  ),

                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Espresso",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.yellow[500],
                                                ),
                                                const Text("4.8 (+999)",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ))
                                              ],
                                            ),
                                          ],
                                        ),
                                        const Row(
                                          children: [
                                            Text(
                                              "24,90\$",
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  color: Color(0x73000000)),
                                            ),
                                            Text("14,50\$",
                                                style: TextStyle(
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
                                                backgroundColor: Color(0xff0CB502),
                                                shadowColor: Color(0xff0CB502),
                                                elevation: 5
                                              ),
                                              onPressed: () {},
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  SvgPicture.asset('assets/images/Icons/buyCart.svg'),
                                                  Text(
                                                      "Add to cart",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w700,
                                                        color: Colors.white
                                                      )
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: 5,
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Categories extends StatelessWidget {
  const Categories({
    super.key,
    required this.icon,
    required this.title,
  });

  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Column(
        children: [
          Image.asset(
            icon,
            height: 60,
            width: 60,
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
