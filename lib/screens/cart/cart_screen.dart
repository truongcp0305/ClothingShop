import 'package:account_manager/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>{



  Stream<QuerySnapshot>snapshot(){
    var data = FirebaseFirestore.instance
        .collection("shop_bag").snapshots();
    return data;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      body: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: snapshot(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
              if(snapshot.hasData){
                List<ProductModel> data = [];
                for (var doc in snapshot.data!.docs) {
                  ProductModel model = ProductModel(
                      id: doc['id'],
                      name: doc['name'],
                      image: doc['image'],
                      price: doc['price'],
                      numofimage: doc['numofimage'],
                      number: doc['number']
                  );
                  data.add(model);
                }
                //List<ProductModel> data = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index){
                      return Container(
                        width: double.infinity,
                        height: 150,
                        margin: const EdgeInsets.only(top: 5),
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Row(
                          children: [
                            Image.asset('assets/images/products/${data[index].image}0.jpg'),
                            Container(
                              margin: const EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      data[index].name,
                                    style: const TextStyle(
                                      fontSize: 17
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                          "${data[index].price}đ",
                                        style: const TextStyle(
                                          color: Colors.green,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 50),
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: (){
                                                int number = data[index].number;
                                                if(number==1){
                                                  Get.defaultDialog(
                                                    radius: 10,
                                                    buttonColor: Colors.green,
                                                    cancelTextColor: Colors.green,
                                                    confirmTextColor: Colors.white,
                                                    middleText: 'Are you sure to delete this item?',
                                                    onCancel: (){},
                                                    onConfirm: (){
                                                      FirebaseFirestore.instance.collection('shop_bag')
                                                          .doc(data[index].id).delete();
                                                      Get.back();
                                                    }
                                                  );
                                                }else{
                                                  number--;
                                                  FirebaseFirestore.instance.collection('shop_bag')
                                                  .doc(data[index].id)
                                                  .update({'number': number});
                                                }
                                              },
                                              child: Container(
                                                width: 34,
                                                height: 23,
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.grey, width: 0.7),
                                                  borderRadius: const BorderRadius.only(
                                                    topLeft: Radius.circular(20),
                                                    bottomLeft: Radius.circular(20),
                                                  )
                                                ),
                                                child: const Icon(Icons.horizontal_rule, size: 16,),
                                              ),
                                            ),
                                            Container(
                                              width: 34,
                                              height: 23,
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                    top: BorderSide(width: 0.7, color: Colors.grey),
                                                    bottom: BorderSide(width: 0.7, color: Colors.grey)
                                                  )
                                              ),
                                              child: Center(child: Text(data[index].number.toString())),
                                            ),
                                            GestureDetector(
                                              onTap: (){
                                                int number = data[index].number;
                                                number++;
                                                FirebaseFirestore.instance.collection('shop_bag')
                                                    .doc(data[index].id)
                                                    .update({'number': number});
                                              },
                                              child: Container(
                                                width: 33,
                                                height: 23,
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.grey, width: 0.7),
                                                  borderRadius: const BorderRadius.only(
                                                    topRight: Radius.circular(20),
                                                    bottomRight: Radius.circular(20)
                                                  )
                                                    ),
                                                child: const Icon(Icons.add, size: 16,),
                                                ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
              if(snapshot.hasError){
                return Text(snapshot.error.toString());
              }
              return Container(
                child: const Text(''),
              );
            },
          ),
        ),
    );
  }
}

