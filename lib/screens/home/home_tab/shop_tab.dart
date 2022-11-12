import 'package:account_manager/screens/product_detail/product_detail.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopWidget extends StatefulWidget {
  const ShopWidget({Key? key}) : super(key: key);

  @override
  State<ShopWidget> createState() => _ShopWidgetState();
}

class _ShopWidgetState extends State<ShopWidget> {
  List<String> icons = [
    "https://cdn0.iconfinder.com/data/icons/clothes-fashion-line/2048/1300_-_Cocktail_Dress-512.png",
    "https://cdn0.iconfinder.com/data/icons/clothes-fashion-line/2048/1291_-_T_Shirt_with_lines-512.png",
    "https://cdn0.iconfinder.com/data/icons/clothes-fashion-line/2048/1292_-_Polo_Shirt-512.png",
    "https://cdn0.iconfinder.com/data/icons/clothes-fashion-line/2048/1320_-_Hat_IV-512.png",
    "https://cdn0.iconfinder.com/data/icons/clothes-fashion-line/2048/1306_-_Pants-512.png",
    "https://cdn0.iconfinder.com/data/icons/clothes-fashion-line/2048/1310_-_Stilletos-512.png",
  ];
  List<String> icons2 = [
    "https://cdn0.iconfinder.com/data/icons/clothes-fashion-line/2048/1305_-_Shorts-512.png",
    "https://cdn0.iconfinder.com/data/icons/clothes-fashion-line/2048/1328_-_Locket-512.png",
    "https://cdn0.iconfinder.com/data/icons/clothes-fashion-line/2048/1332_-_Sunglasses-512.png",
    "https://cdn0.iconfinder.com/data/icons/clothes-fashion-line/2048/1330_-_Wrist_Watch-512.png",
    "https://cdn0.iconfinder.com/data/icons/clothes-fashion-line/2048/1319_-_Hat_III-512.png",
    "https://cdn0.iconfinder.com/data/icons/clothes-fashion-line/2048/1297_-_Ladies_Vest-512.png",
  ];
  List<String> textIcons =[
    'Dress',
    'Top',
    'Pocket',
    'Sweater',
    'Jeans',
    'Shoes'
  ];
  List<String> textIcons2 =[
    'Pants',
    'Necklace',
    'Glass',
    'Watch',
    'Hat',
    'Undershirt'
  ];


  Future<List<DocumentSnapshot>> salebanner ()async{
    List<DocumentSnapshot> snapshot = [];
    var data = await FirebaseFirestore.instance
        .collection("salebanner")
        .get();
    for (var doc in data.docs) {
      snapshot.add(doc);
    }
    return snapshot;
  }

  Future<List<DocumentSnapshot>> recommend ()async{
    List<DocumentSnapshot> snapshot = [];
    var data = await FirebaseFirestore.instance
        .collection("recommend")
        .get();
    for (var doc in data.docs) {
      snapshot.add(doc);
    }
    return snapshot;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 5,),
            CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 1.873,
                viewportFraction: 1.0
              ),
              items: [0,1,2,3].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Image.asset(
                        'assets/images/banner/banner_$i.jpg',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 10,),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                  crossAxisSpacing: 2
                ),
                itemCount: 6,
                itemBuilder: (context, index){
                  return  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){},
                            child: Container(
                              decoration : const BoxDecoration(
                                shape: BoxShape.circle,
                                //border: Border.all(color: Colors.green),
                                color: Color(0xffeadfdf)
                              ),
                              child: Image.network(
                                icons[index],
                                color: Colors.green,
                                height: 52,
                                width: 52,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            child: Text(textIcons[index]),
                          )
                        ],
                      );
                },
              ),
            ),
            const SizedBox(height: 10,),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 2
                ),
                itemCount: 6,
                itemBuilder: (context, index){
                  return  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){},
                        child: Container(
                          decoration : const BoxDecoration(
                              shape: BoxShape.circle,
                              //border: Border.all(color: Colors.green),
                              color: Color(0xffeadfdf)
                          ),
                          child: Image.network(
                            icons2[index],
                            color: Colors.green,
                            height: 52,
                            width: 52,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        child: Text(textIcons2[index]),
                      )
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 10,),
            const SizedBox(
              child: Center(
                child: Text(
                  "Flash sale",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color: Colors.green
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            SizedBox(
              height: 180,
              width: double.infinity,
              child: FutureBuilder<List<DocumentSnapshot>>(
                future: salebanner(),
                builder: (context, AsyncSnapshot<List<DocumentSnapshot>> snapshot){
                  if(snapshot.hasData){
                    List<DocumentSnapshot> data = snapshot.data!;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.length,
                      itemBuilder: (context, index){
                        return Container(
                          padding: const EdgeInsets.only(right: 5),
                          height: 80,
                          width: 100,
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/sale_banner/sale_banner$index.jpg',
                                fit: BoxFit.cover,
                              ),
                              Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    data[index]['price'],
                                    style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w600
                                    ),
                                  )
                              )
                            ],
                          ),
                        );
                      },
                    );
                  }
                  if(snapshot.hasError){
                    return const SizedBox(
                      height: 120,
                      width: double.infinity,
                    );
                  }
                  return const SizedBox(
                    height: 120,
                    width: double.infinity,
                  );
                },
              ),
            ),
            const SizedBox(height: 10,),
            const SizedBox(
              child: Center(
                child: Text(
                  "Recommend",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Colors.green
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            FutureBuilder(
              future: recommend(),
              builder: (context, AsyncSnapshot<List<DocumentSnapshot>> snapshot){
                if(snapshot.hasData){
                  List<DocumentSnapshot> data = snapshot.data!;
                  return Column(
                    children: [
                      for(int i =0; i<3; i++)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Get.to(()=>ProductDetail(id: data[i*2]['id'],));
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                                        child: Image.asset(
                                          'assets/images/products/${data[i*2]['image']}0.jpg',
                                          width: 160,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(15)),
                                          color: Colors.grey.shade300
                                        ),
                                        width: 160,
                                        height: 30,
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 5, left: 10),
                                          child: Text(
                                            '${data[i*2]['price'].toString()}đ',
                                            style: const TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Get.to(()=> ProductDetail(id: data[i*2+1]['id'],));
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                                        child: Image.asset(
                                          'assets/images/products/${data[i*2+1]['image']}0.jpg',
                                          width: 160,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        )
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(15)),
                                        ),
                                        width: 160,
                                        height: 30,
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 5, left: 10),
                                          child: Text(
                                            '${data[i*2+1]['price'].toString()}đ',
                                            style: const TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.w600
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
                        )
                    ],
                  );
                }
                return Container();
              },
            )
          ],
        ),
    );
  }
}
