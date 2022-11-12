import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_tab/shop_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  List<Tab> myTab = <Tab>[
    const Tab(text: 'Shop',),
    const Tab(text: 'Male',),
    const Tab(text: 'Female',),
    const Tab(text: 'Children',)
  ];
  late TabController tabController;
  @override
  void initState(){
    super.initState();
    tabController = TabController(length: myTab.length, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.green,
      ),
      body: Container(
        margin: const EdgeInsets.all(5),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            TabBar(
              tabs: myTab,
              controller: tabController,
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.green,
              indicator: CircleTabIndicator(color: Colors.green, radius: 4),
            ),
            Expanded(
              child: SizedBox(
                width: double.maxFinite,
                height: double.infinity,
                child: TabBarView(
                  controller: tabController,
                  children: const [
                    ShopWidget(),
                    ShopWidget(),
                    ShopWidget(),
                    ShopWidget()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CircleTabIndicator extends Decoration{
  final Color color;
  double radius;
  CircleTabIndicator({required this.color, required this.radius});
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: Colors.black, radius: 4);
  }
}

class _CirclePainter extends BoxPainter {
  double radius;
  Color color;
  _CirclePainter({required this.color, required this.radius});
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg){
    Paint paint = Paint();
    paint.color = Colors.green;
    paint.isAntiAlias = true;
    final Offset circleOffset =
        offset + Offset(cfg.size!.width/2 - radius/2, cfg.size!.height - radius-3);
    canvas.drawCircle(circleOffset, 3, paint);
  }
}
