class ProductModel{
  String id;
  String name;
  String image;
  String price;
  int numofimage;
  int number;

  ProductModel({
   required this.id,
   required this.name,
   required this.image,
   required this.price,
   required this.numofimage,
   required this.number
});

  List<String> getImages (){
    List<String> images = [];
    for(var i=0; i< numofimage; i++){
      images.add('$image$i');
    }
    return images;
  }


}