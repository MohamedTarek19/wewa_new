import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainHome extends StatelessWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                delegate: SliverChildListDelegate([
              SafeArea(
                top: true,
                minimum: const EdgeInsets.only(top: 60),
                child: Column(
                  children: [
                    
                    Container(
                      height: 200,
                      color: Colors.green,
                    ),
                    Container(
                      height: 200,
                      color: Colors.blue,
                    ),
                    Container(
                      height: 200,
                      color: Colors.black,
                    ),
                    Container(
                      height: 200,
                      color: Colors.grey,
                    ),
                    Container(
                      height: 200,
                    ),
                    Container(
                      height: 200,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
              
            ],),),
          ],
        ),
      ),
    );
  }
}
