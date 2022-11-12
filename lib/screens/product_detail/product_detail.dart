import 'package:account_manager/models/product_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProductDetail extends StatefulWidget {
  final String id;
  const ProductDetail({Key? key, required this.id}) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  ProductModel? productModel;

  Future<ProductModel> snapshot()async{
    DocumentSnapshot<Map<String, dynamic>> data =
    await FirebaseFirestore.instance.collection('recommend').doc(widget.id).get();
    ProductModel product = ProductModel(
      id: data['id'],
      name: data['name'],
      image: data['image'],
      price: data['price'],
      numofimage: data['numofimage'],
      number: data['number']
    );
    productModel = product;
    return product;
  }
  
  List<String> size = ['S', 'M', 'L', 'XL'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: FutureBuilder<ProductModel>(
              future: snapshot(),
              builder: (context, AsyncSnapshot<ProductModel> snapshot){
                if(snapshot.hasData){
                  ProductModel model = snapshot.data!;
                  List<String> images = model.getImages();
                  List<Widget> p = images.map((i){
                    return Builder(
                      builder: (BuildContext context){
                        return Image.asset(
                          'assets/images/products/$i.jpg',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        );
                      },
                    );
                  }).toList();
                  return Column(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          aspectRatio: 0.80,
                          viewportFraction: 1.0
                        ),
                        items: p,
                      ),
                      //Name and price
                      Container(
                        width: double.infinity,
                        height: 140,
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 40,
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    model.name,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400
                                    ),
                                  ),
                                  const Icon(
                                    Icons.share,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 40,
                              padding: const EdgeInsets.symmetric( horizontal: 18),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${model.price}đ",
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontSize: 23,
                                      fontWeight: FontWeight.w700
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      for(var i=0; i<5; i++)
                                      const Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 15,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 18),
                              child: Text(
                                  'Size',
                                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18, top: 8),
                              child: Row(
                                children: [
                                  for(var i=0; i<4; i++)
                                  Container(
                                    width: 60,
                                    height: 28,
                                    margin: const EdgeInsets.only(left: 6),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Center(child: Text(size[i])),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 15,),
                      Container(
                        height: 300,
                        width: double.infinity,
                        decoration: const BoxDecoration(color: Colors.white),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 18, top: 10),
                          child: Text(
                            'Decription',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 17,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                }
                return Container();
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(
                children:  [
                  const SizedBox(
                    height: 60,
                    width: 70,
                    child: Center(
                      child: Icon(
                          Icons.favorite_border,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: ()async{
                        if(productModel!= null){
                          Map<String, dynamic> json = {
                            'id': productModel!.id,
                            'name': productModel!.name,
                            'image': productModel!.image,
                            'price': productModel!.price,
                            'numofimage': productModel!.numofimage,
                            'number': 1
                          };
                          await FirebaseFirestore.instance
                              .collection('shop_bag')
                              .doc(productModel!.id)
                              .set(json);
                          Get.snackbar('Done','Added to cart', backgroundColor: Colors.white);
                        }
                      },
                      child: Container(
                        width: 300,
                        height: 40,
                        decoration: const BoxDecoration(color: Colors.green),
                        child: const Center(
                          child: Text(
                            'ADD TO BAG',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
