import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wewa/bussiness_logic/state_cubits/wewa_products_cubit.dart';
import 'package:wewa/presentation/views/home/Categories_pages/filtered_items_screen.dart';

class AllCategories extends StatelessWidget {
  const AllCategories({Key? key}) : super(key: key);

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 5),
              child: Container(
                margin: const EdgeInsets.only(right: 20, left: 20),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: const Color(0xffEBEBEB), border: Border.all(color: const Color(0xffEBEBEB))),
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
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: BlocBuilder<WewaProductsCubit, WewaProductsState>(
                  builder: (context, state) {
                    return context.read<WewaProductsCubit>().flag == false
                        ? const Center(
                            child: Text("Loading"),
                          )
                        : SingleChildScrollView(
                            child: Center(
                              child: LayoutGrid(
                                columnSizes: MediaQuery.of(context).orientation == Orientation.portrait
                                    ? [2.fr, 2.fr, 2.fr, 2.fr,]
                                    : [2.fr, 2.fr, 2.fr, 2.fr, 2.fr,],
                                rowSizes: MediaQuery.of(context).orientation == Orientation.portrait
                                ?[for (int index = 0; index < context.read<WewaProductsCubit>().Categories.length / 4; index++) auto]:
                                [for (int index = 0; index < context.read<WewaProductsCubit>().Categories.length / 5; index++) auto],
                                columnGap: -1,
                                rowGap: 10,
                                children: [
                                  for (int index = 0; index < context.read<WewaProductsCubit>().Categories.length; index++)
                                    InkWell(
                                      onTap: () async {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Center(child: CircularProgressIndicator());
                                          },
                                        );
                                        context.read<WewaProductsCubit>().cat = context.read<WewaProductsCubit>().Categories[index];
                                        await context.read<WewaProductsCubit>().scrollIntializer();
                                        await context.read<WewaProductsCubit>().getCategoryProducts(
                                              categoryId: context.read<WewaProductsCubit>().Categories[index].id ?? 0,
                                              pageNumber: 1,
                                            );
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
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 1),
                                        child: Categories(
                                          title: context.read<WewaProductsCubit>().Categories[index].categoryName ?? '',
                                          icon: context.read<WewaProductsCubit>().Categories[index].CategoryImg,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                    //itemCount: context.read<WewaProductsCubit>().Categories.length,
                  },
                ),
              ),
            )
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

  final String? icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                height: 70,
                width: 130,
                imageUrl: icon ?? '',
                fit: BoxFit.fill,
                errorWidget: (context, url, error) => const Icon(Icons.image_not_supported_outlined),
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
