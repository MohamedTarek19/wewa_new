import 'package:flutter/material.dart';
import 'package:wewa/presentation/widgets/custom_signin_signup.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.55,
                  child: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        title: const Text('Cart'),
                        centerTitle: true,
                        floating: true,
                        leading: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back_ios),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return Container(
                            height: 155,
                            margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white, boxShadow: [
                              BoxShadow(color: Colors.grey, blurRadius: 10, spreadRadius: 1, offset: Offset(3, 3)),
                            ]),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      'assets/images/imagesData/product.png',
                                      height: 150,
                                      width: 130,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding:EdgeInsets.only(bottom: 8,top: 1),
                                  width:MediaQuery.of(context).size.width-166,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Coffee'),
                                          IconButton(onPressed: () {
                                            
                                          }, icon: Icon(Icons.restore_from_trash_outlined))
                                        ],
                                      ),
                                      Text('55\$',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                                      Text('Sold by: Name',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),),
                                      SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xffE9F8E4),
                                              shape: BoxShape.circle
                                            ),
                                            height: 40,
                                            width: 40,
                                            child: Center(child: Icon(Icons.remove,color: Color(0xff0CB502),)),
                                          ),
                                          Container(
                                            height:40,
                                            width:40,
                                            child: Center(child: Text('5',style: TextStyle(fontSize: 16),)),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xff0CB502),
                                                shape: BoxShape.circle
                                            ),
                                            height: 40,
                                            width: 40,
                                            child: Center(child: Icon(Icons.add,color: Color(0xfffffffff),)),
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }, childCount: 5),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          label: const Text('Promo Code'),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                          suffix: InkWell(
                            child: const Text('Apply'),
                            onTap: () {},
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Order summary',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.start,
                      ),
                      const Card(
                        elevation: 0.5,
                        color: Color(0xffE9F8E4),
                        margin: EdgeInsets.only(top: 10),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Subtotal(2)', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                                  Text('EGP 55', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Subtotal(2)', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                                  Text('EGP 55', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Subtotal(2)', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                                  Text('EGP 55', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomSignIn_UpOne(
                        title: 'Checkout',
                        ontap: () {},
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
