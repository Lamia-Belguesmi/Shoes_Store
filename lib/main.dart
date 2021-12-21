import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoes_store_app/shoes.dart';
import 'package:shoes_store_app/shoes_details.dart';

void main() => runApp(MainShoesStore());

class MainShoesStore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        home: ShoesStoreHome());
  }
}

class ShoesStoreHome extends StatelessWidget {
  final ValueNotifier<bool> notifierBottomBar = ValueNotifier(true);

  void _onShoesPressed(Shoes shoes, BuildContext context) async {
    notifierBottomBar.value = false;
    await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) {
          return FadeTransition(
            opacity: animation1,
            child: ShoesDetails(shoes: shoes),
          );
        },
      ),
    );
    notifierBottomBar.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Image.asset(
                    'images/nike_logo.png',
                    height: 50,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: shoes.length,
                      itemBuilder: (context, index) {
                        final shoesItem = shoes[index];
                        return ShoesItem(
                          shoesItem: shoesItem,
                          onTap: () {
                            _onShoesPressed(shoesItem, context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            ValueListenableBuilder<bool>(
                valueListenable: notifierBottomBar,
                builder: (context, value, child) {
                  return AnimatedPositioned(
                    duration: Duration(milliseconds: 250),
                    left: 0,
                    right: 0,
                    bottom: -56 / 5,
                    height: 56,
                    child: Container(
                      color: Colors.white.withOpacity(0.7),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Icon(Icons.home),
                          ),
                          Expanded(
                            child: Icon(Icons.search),
                          ),
                          Expanded(
                            child: Icon(Icons.favorite_border),
                          ),
                          Expanded(
                            child: Icon(Icons.shopping_cart),
                          ),
                          Expanded(
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })
          ],
        ));
  }
}

class ShoesItem extends StatelessWidget {
  final Shoes shoesItem;
  final VoidCallback onTap;

  ShoesItem({required this.shoesItem, required this.onTap});

  @override
  Widget build(BuildContext context) {
    const itemHeight = 250;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: SizedBox(
          height: 280,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Positioned.fill(
                child: Hero(
                  tag: 'background_${shoesItem.model}',
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: shoesItem.color,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Hero(
                  tag: 'number_${shoesItem.model}',
                  child: SizedBox(
                    height: itemHeight * 0.6,
                    child: Material(
                      color: Colors.transparent ,
                      child: FittedBox(
                        child: Text(
                          shoesItem.modelNumber.toString(),
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.05),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 20,
                left: 100,
                height: itemHeight * 0.8,
                child: Hero(
                  tag: 'image_${shoesItem.model}',
                  child: Image.asset(
                    shoesItem.images.first,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.grey,
                ),
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.grey,
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      shoesItem.model,
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '\$${shoesItem.oldPrice.toInt().toString()}',
                      style: TextStyle(
                        color: Colors.red,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '\$${shoesItem.currentPrice.toInt().toString()}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
