import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height - kToolbarHeight,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(right: 10, left: 10),
        child: ListView.builder(
          itemCount: 8,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(top: 5, bottom: 5),
              height: 120,
              padding: const EdgeInsets.only(right: 3, top: 10, bottom: 10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  //color: Colors.blue,
                  border: Border(left: BorderSide.none, right: BorderSide.none, top: BorderSide.none, bottom: BorderSide(color: Colors.grey[400]!))),
              child: Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/imagesData/notimage.png'),
                        )),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.69,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Order Successful!',
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 3,),
                        Text(
                          '${Jiffy.now().yMMMEd} | ${DateFormat('kk:mm:a').format(DateTime.now())}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(height: 3,),
                        Text(
                          'You have placed an order (order name) and paid \$40. Your order will arrive soon.',
                          style: TextStyle(fontSize: 12,color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
