import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_firebase/router/app_router.dart';
import 'package:flutter/material.dart';

import '../../../components/grid_view.dart';
import '../../../model/user_model.dart';
import '../home_screen.dart';
import 'section_title.dart';

late UserModel userModel;

Size? size;

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    double getWidth(value) {
      double screenWidth = MediaQuery.of(context).size.width;
      return (value / 375.0) * screenWidth;
    }

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
          child: SectionTitle(
            title: "Our categories ",
            press: () {},
          ),
        ),
        SizedBox(height: getWidth(20)),
        Container(
          height: MediaQuery.of(context).size.height * 0.1 + 20,
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("categories").snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshort) {
              if (!streamSnapshort.hasData) {
                return Center(child: const CircularProgressIndicator());
              }
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemCount: streamSnapshort.data!.docs.length,
                itemBuilder: (ctx, index) {
                  return SpecialOfferCard(
                    image: streamSnapshort.data!.docs[index]['categoryImage'],
                    category: streamSnapshort.data!.docs[index]['categoryName'],
                    numOfBrands: 4,
                    press: () {
                      AppRouter.appRouter.goToWidget(GridViewWidget(
                        subCollection: streamSnapshort.data!.docs[index]
                            ["categoryName"],
                        collection: "categories",
                        id: streamSnapshort.data!.docs[index].id,
                      ));
                    },
                  );
                },
              );
            },
          ),
        ),
        // SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        //   child: Row(
        //     children: [
        //       SpecialOfferCard(
        //         image: "assets/images/Image Banner 2.png",
        //         category: "Smartphone",
        //         numOfBrands: 18,
        //         press: () {},
        //       ),
        //       SpecialOfferCard(
        //         image: "assets/images/Image Banner 3.png",
        //         category: "Fashion",
        //         numOfBrands: 24,
        //         press: () {},
        //       ),
        //       SizedBox(width: getWidth(20)),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.numOfBrands,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final int numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    double getWidth(value) {
      double screenWidth = MediaQuery.of(context).size.width;
      return (value / 375.0) * screenWidth;
    }

    return Padding(
      padding: EdgeInsets.only(left: getWidth(20)),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: getWidth(200),
          height: getWidth(100),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 44, 80, 131).withOpacity(0.4),
                        Color.fromARGB(255, 5, 60, 100).withOpacity(0.15),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getWidth(15.0),
                    vertical: getWidth(10),
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "$category\n",
                          style: TextStyle(
                            fontSize: getWidth(18),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: "$numOfBrands Brands")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
