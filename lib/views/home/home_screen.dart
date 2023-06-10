// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_is_empty

// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:final_project_firebase/Themes/app_colors.dart';
// import 'package:final_project_firebase/data_reposotries/fire_store_helper.dart';
// import 'package:final_project_firebase/provider/my_provider.dart';
// import 'package:final_project_firebase/router/app_router.dart';
// import 'package:final_project_firebase/views/details/details_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../components/build_drawer.dart';
// import '../../components/grid_view.dart';
// import '../../components/product_widget.dart';

// class HomeScreen extends StatelessWidget {
//   var result;
//   searchFunction(query, searchList) {
//     log(searchList.length.toString());
//     result = searchList.where((element) {
//       return !element["productName"]
//               .toString()
//               .toUpperCase()
//               .contains(query.toString()) ||
//           element["productName"].toLowerCase().contains(query) ||
//           element["productName"].toUpperCase().contains(query) &&
//               element["productName"].toLowerCase().contains(query);
//     }).toList();
//     log(result.length.toString());
//     return result;
//   }

//   Widget buildCategory() {
//     return Column(
//       children: [
//         ListTile(
//           leading: Text(
//             'Categories',
//             style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.normal,
//                 color: Colors.grey[600]),
//           ),
//         ),
//         Container(
//           height: 100,
//           child: StreamBuilder(
//             stream: FireStoreHelper.fireStoreHelper.firestore
//                 .collection('categories')
//                 .snapshots(),
//             builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//               if (!snapshot.hasData) {
//                 return Center(child: CircularProgressIndicator());
//               }
//               return ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 physics: BouncingScrollPhysics(),
//                 itemBuilder: (context, index) {
//                   return Categories(
//                       onTap: () {
//                         AppRouter.appRouter.goToWidget(GridViewWidget(
//                           subCollection: snapshot.data!.docs[index]
//                               ['categoryName'],
//                           collection: 'categories',
//                           id: snapshot.data!.docs[index].id,
//                         ));
//                       },
//                       image: snapshot.data!.docs[index]['categoryImage'] ?? '',
//                       categoryName:
//                           snapshot.data!.docs[index]['categoryName'] ?? '');
//                 },
//                 itemCount: snapshot.data!.docs.length,
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

// // FireStoreHelper.fireStoreHelper.firestore.collection('products').snapshots(),
//   Widget buildProduct(
//       {required Stream<QuerySnapshot<Map<String, dynamic>>>? stream}) {
//     return Container(
//       height: 280,
//       child: StreamBuilder(
//         stream: stream,
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return Center(child: CircularProgressIndicator());
//           }
//           return ListView.builder(
//             scrollDirection: Axis.horizontal,
//             physics: BouncingScrollPhysics(),
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               log(Provider.of<MyProvider>(context).query);
//               var varData = searchFunction(
//                   Provider.of<MyProvider>(context).query, snapshot.data!.docs);
//               var data = varData[index];
//               return ProductWidget(
//                 onTap: () {
//                   AppRouter.appRouter.goToWidget(DetailsScreen(
//                     productCategory: data['productCategory'],
//                     productId: data['productId'],
//                     productImage: data['productImage'],
//                     productName: data['productName'],
//                     productOldPrice: data['productOldPrice'],
//                     productPrice: data['productPrice'],
//                     productRate: data['productRate'],
//                     productDescription: data['productDescription'],
//                   ));
//                 },
//                 productCategory: data['productCategory'],
//                 // productFavorite: true,
//                 productId: data['productId'],
//                 productOldPrice: data['productOldPrice'],
//                 productRate: data['productRate'],
//                 productImage: data['productImage'],
//                 productName: data['productName'],
//                 productPrice: data['productPrice'],
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     Provider.of<MyProvider>(context).getCurrentUserData();
//     return Scaffold(
//         drawer: BuildDrawer(),
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//         ),
//         body: ListView(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Material(
//                 elevation: 7,
//                 shadowColor: Colors.grey[300],
//                 child: TextFormField(
//                   onChanged: (value) {
//                     Provider.of<MyProvider>(context, listen: false)
//                         .setQuery(value);
//                   },
//                   decoration: InputDecoration(
//                       prefixIcon: Icon(Icons.search),
//                       fillColor: AppColors.kwhiteColor,
//                       hintText: "Search Your Product",
//                       filled: true,
//                       border: OutlineInputBorder(borderSide: BorderSide.none)),
//                 ),
//               ),
//             ),
//             buildCategory(),
//             ListTile(
//               leading: Text(
//                 'Product',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.normal,
//                 ),
//               ),
//             ),
//             buildProduct(
//               stream: FireStoreHelper.fireStoreHelper.firestore
//                   .collection('products')
//                   .snapshots(),
//             ),

//             ListTile(
//               leading: Text(
//                 'Best Sell',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.normal,
//                 ),
//               ),
//             ),
//             buildProduct(
//               stream: FireStoreHelper.fireStoreHelper.firestore
//                   .collection('products')
//                   .where('productRate', isGreaterThan: 4)
//                   .orderBy('productRate', descending: true)
//                   .snapshots(),
//             ),
//             // Container(
//             //   height: 280,
//             //   child: StreamBuilder(

//             //     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             //       if (!snapshot.hasData) {
//             //         return Center(child: CircularProgressIndicator());
//             //       }
//             //       return ListView.builder(
//             //         scrollDirection: Axis.horizontal,
//             //         physics: BouncingScrollPhysics(),
//             //         itemBuilder: (context, index) {
//             //           // log('here');
//             //           // log(snapshot.data!.docs[index]['productImage']);
//             //           // log(snapshot.data!.docs[index]['productPrice']);
//             //           // log(snapshot.data!.docs[index]['productName ']);
//             //           var data = snapshot.data!.docs[index];
//             //           return ProductWidget(
//             //             onTap: () {
//             //               AppRouter.appRouter.goToWidget(DetailsScreen(
//             //                 productCategory: snapshot.data!.docs[index]
//             //                     ['productCategory'],
//             //                 productId: snapshot.data!.docs[index]
//             //                     ['productImage'],
//             //                 productImage: snapshot.data!.docs[index]
//             //                     ['productImage'],
//             //                 productName: snapshot.data!.docs[index]
//             //                     ['productName'],
//             //                 productOldPrice: snapshot.data!.docs[index]
//             //                     ['productOldPrice'],
//             //                 productPrice: snapshot.data!.docs[index]
//             //                     ['productPrice'],
//             //                 productRate: snapshot.data!.docs[index]
//             //                     ['productRate'],
//             //                 productDescription: snapshot.data!.docs[index]
//             //                     ['productDescription'],
//             //               ));
//             //             },
//             //             productCategory: data['productCategory'],
//             //             // productFavorite: true,
//             //             productId: data['productId'],
//             //             productOldPrice: data['productOldPrice'],
//             //             productRate: data['productRate'],
//             //             productImage: data['productImage'],
//             //             productName: data['productName'],
//             //             productPrice: data['productPrice'],
//             //           );
//             //           // return Categories(
//             //           //     onTap: () {

//             //           //     },
//             //           //     image:
//             //           //         snapshot.data!.docs[index]['categoryImage'] ?? '',
//             //           //     categoryName:
//             //           //         snapshot.data!.docs[index]['categoryName'] ?? '');
//             //         },
//             //         itemCount: snapshot.data!.docs.length,
//             //       );
//             //     },
//             //   ),
//             // ),
//           ],
//         ));
//   }
// }

// class Categories extends StatelessWidget {
//   const Categories(
//       {Key? key,
//       required this.image,
//       required this.categoryName,
//       required this.onTap})
//       : super(key: key);
//   final String image;
//   final String categoryName;
//   final Function()? onTap;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//             image:
//                 DecorationImage(fit: BoxFit.cover, image: NetworkImage(image)),
//             borderRadius: BorderRadius.circular(10)),
//         margin: EdgeInsets.all(12),
//         height: 100,
//         width: 150,
//         child: Container(
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: Colors.black.withOpacity(0.7)
//               // gradient: LinearGradient(begin: Alignment.center, colors: [
//               //   Colors.black.withOpacity(0.7),
//               //   Colors.black.withOpacity(0.7),
//               // ])
//               ),
//           child: Center(
//             child: Text(
//               categoryName,
//               style:
//                   TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project_firebase/components/product_widget.dart';
import 'package:final_project_firebase/router/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Themes/app_colors.dart';
import '../../components/build_drawer.dart';
import '../../components/grid_view.dart';
import '../../model/user_model.dart';
import '../details/details_screen.dart';

late UserModel userModel;

Size? size;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String query = "";
  var result;
  searchFunction(query, searchList) {
    result = searchList.where((element) {
      return element["productName"].toUpperCase().contains(query) ||
          element["productName"].toLowerCase().contains(query) ||
          element["productName"].toUpperCase().contains(query) &&
              element["productName"].toLowerCase().contains(query);
    }).toList();
    return result;
  }

  Future getCurrentUserDataFunction() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          userModel = UserModel.fromMap(documentSnapshot);
        } else {
          print("Document does not exist the database");
        }
      },
    );
  }

  Widget buildCategory() {
    return Column(
      children: [
        ListTile(
          leading: Text(
            "Categories",
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[600],
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Container(
          height: size!.height * 0.1 + 20,
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
                  return Categories(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => GridViewWidget(
                            subCollection: streamSnapshort.data!.docs[index]
                                ["categoryName"],
                            collection: "categories",
                            id: streamSnapshort.data!.docs[index].id,
                          ),
                        ),
                      );
                    },
                    categoryName: streamSnapshort.data!.docs[index]
                        ["categoryName"],
                    image: streamSnapshort.data!.docs[index]["categoryImage"],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildProduct(
      {required Stream<QuerySnapshot<Map<String, dynamic>>>? stream}) {
    return Container(
      height: size!.height / 3 + 40,
      child: StreamBuilder(
        stream: stream,
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshort) {
          if (!streamSnapshort.hasData) {
            return Center(child: const CircularProgressIndicator());
          }
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: streamSnapshort.data!.docs.length,
            itemBuilder: (ctx, index) {
              var varData = searchFunction(query, streamSnapshort.data!.docs);
              var data = varData[index];
              // var data = streamSnapshort.data!.docs[index];
              return ProductWidget(
                onTap: () {
                  AppRouter.appRouter.goToWidget(
                    DetailsScreen(
                      productCategory: data["productCategory"],
                      productId: data["productId"],
                      productImage: data["productImage"],
                      productName: data["productName"],
                      productOldPrice: data["productOldPrice"],
                      productPrice: data["productPrice"],
                      productRate: data["productRate"],
                      productDescription: data["productDescription"],
                    ),
                  );
                },
                productId: data["productId"],
                productCategory: data["productCategory"],
                productRate: data["productRate"],
                productOldPrice: data["productOldPrice"],
                productPrice: data["productPrice"],
                productImage: data["productImage"],
                productName: data["productName"],
                productDescription: data['productDescription'],
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    getCurrentUserDataFunction();
    return Scaffold(
      drawer: BuildDrawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              elevation: 7,
              shadowColor: Colors.grey[300],
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    query = value;
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  fillColor: AppColors.kwhiteColor,
                  hintText: "Search Your Product",
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          query == ""
              ? Column(
                  children: [
                    buildCategory(),
                    ListTile(
                      leading: Text(
                        "Products",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    buildProduct(
                      stream: FirebaseFirestore.instance
                          .collection("products")
                          .snapshots(),
                    ),
                    ListTile(
                      leading: Text(
                        "Best Sell",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    buildProduct(
                      stream: FirebaseFirestore.instance
                          .collection("products")
                          .where("productRate", isGreaterThan: 4)
                          .orderBy(
                            "productRate",
                            descending: true,
                          )
                          .snapshots(),
                    ),
                  ],
                )
              : Container(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("products")
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot> streamSnapshort) {
                      if (!streamSnapshort.hasData) {
                        return Center(child: const CircularProgressIndicator());
                      }
                      var varData =
                          searchFunction(query, streamSnapshort.data!.docs);
                      return result.isEmpty
                          ? Center(child: Text("Not Found"))
                          : GridView.builder(
                              shrinkWrap: true,
                              itemCount: result.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 5.0,
                                mainAxisSpacing: 5.0,
                                childAspectRatio: 0.6,
                              ),
                              itemBuilder: (ctx, index) {
                                var data = varData[index];
                                return ProductWidget(
                                  onTap: () {
                                    AppRouter.appRouter.goToWidget(
                                      DetailsScreen(
                                        productCategory:
                                            data["productCategory"],
                                        productId: data["productId"],
                                        productImage: data["productImage"],
                                        productName: data["productName"],
                                        productOldPrice:
                                            data["productOldPrice"],
                                        productPrice: data["productPrice"],
                                        productRate: data["productRate"],
                                        productDescription:
                                            data["productDescription"],
                                      ),
                                    );
                                  },
                                  productId: data["productId"],
                                  productCategory: data["productCategory"],
                                  productRate: data["productRate"],
                                  productOldPrice: data["productOldPrice"],
                                  productPrice: data["productPrice"],
                                  productImage: data["productImage"],
                                  productName: data["productName"],
                                  productDescription:
                                      data['productDescription'],
                                );
                              },
                            );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}

class Categories extends StatelessWidget {
  final String image;
  final String categoryName;
  final Function()? onTap;
  const Categories({
    Key? key,
    required this.onTap,
    required this.categoryName,
    required this.image,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(12.0),
        width: size!.width / 2 - 20,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              image,
            ),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black.withOpacity(0.7),
          ),
          child: Center(
            child: Text(
              categoryName,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
