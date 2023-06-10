import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("sliders").snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshort) {
        if (!streamSnapshort.hasData) {
          return Center(child: const CircularProgressIndicator());
        }

        return Container(
          height: 200,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: streamSnapshort.data!.docs.length,
            itemBuilder: (ctx, index) {
              log(streamSnapshort.data!.docs[index]['title']);
              return DiscountBar(
                imgSrc: streamSnapshort.data!.docs[index]['imageUrl'],
                title: streamSnapshort.data!.docs[index]['title'],
              );
            },
          ),
        );
      },
    );
  }
}

class DiscountBar extends StatelessWidget {
  String imgSrc;
  String title;

  DiscountBar({required this.imgSrc, required this.title});
  @override
  Widget build(BuildContext context) {
    double getWidth(value) {
      double screenWidth = MediaQuery.of(context).size.width;
      return (value / 375.0) * screenWidth;
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      margin: EdgeInsets.all(getWidth(20)),
      padding: EdgeInsets.symmetric(
        horizontal: getWidth(20),
        vertical: getWidth(15),
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
              imgSrc,
            ),
            fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text.rich(
        TextSpan(
          style: TextStyle(color: Colors.white, fontSize: 18),
          children: [
            TextSpan(text: "A summer bomb\n\n"),
            TextSpan(
              text: title,
              style: TextStyle(
                fontSize: getWidth(20),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
