import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'shoes.dart';
import 'package:animated_widgets/animated_widgets.dart';
import 'shoes_shopping_cart.dart';

class ShoesDetails extends StatelessWidget {
  final Shoes shoes;
  final ValueNotifier<bool> notifierBottomButtons = ValueNotifier(false);

  ShoesDetails({required this.shoes});
  void _openShoppingCart(context) async{
    notifierBottomButtons.value = false;
    await Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
        pageBuilder: (_, animation1, __){
      return TranslationAnimatedWidget( child: ShoppingCart(shoes: shoes ,));

    }
    ),) ;
    notifierBottomButtons.value = true;

  }

  Widget _buildCarousel(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.5,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Hero(
              tag: 'background_${shoes.model}',
              child: Container(
                color: shoes.color,
              ),
            ),
          ),
          Positioned(
            left: 120,
            right: 120,
            top: 0,
            child: Hero(
              tag: 'number_${shoes.model}',
              child: TranslationAnimatedWidget(
                values: [
                  Offset(0, 100), // disabled value value
                  Offset(0, 150), //intermediate value
                  Offset(20, 0) //enabled value
                ],
                child: Material(
                  color: Colors.transparent,
                  child: FittedBox(
                    child: Text(
                      shoes.modelNumber.toString(),
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
          PageView.builder(
              itemCount: shoes.images.length,
              itemBuilder: (context, index) {
                final tag = index == 0
                    ? 'image_${shoes.model}'
                    : 'image_${shoes.model}_$index';
                return Container(
                  alignment: Alignment.center,
                  child: Hero(
                    tag: tag,
                    child: Image.asset(
                      shoes.images[index],
                      height: 190,
                      width: 200,
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      notifierBottomButtons.value = true;
    });

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset(
          'images/nike_logo.png',
          height: 50,
        ),
        leading: BackButton(color: Colors.black),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildCarousel(context),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ScaleAnimatedWidget.tween(
                        duration: Duration(milliseconds: 600),
                        scaleDisabled: 0.5,
                        scaleEnabled: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              shoes.model,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            Spacer(),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '\$${shoes.oldPrice.toInt().toString()}',
                                    style: TextStyle(
                                      color: Colors.red,
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '\$${shoes.currentPrice.toInt().toString()}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ScaleAnimatedWidget.tween(
                        duration: Duration(milliseconds: 600),
                        scaleDisabled: 0.5,
                        scaleEnabled: 1,
                        child: Text(
                          'AVAILABLE SIZES',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ScaleAnimatedWidget.tween(
                        duration: Duration(milliseconds: 600),
                        scaleDisabled: 0.5,
                        scaleEnabled: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _ShoesSizeItem(text: '6'),
                            _ShoesSizeItem(text: '7 '),
                            _ShoesSizeItem(text: '9'),
                            _ShoesSizeItem(text: '10'),
                            _ShoesSizeItem(text: '11'),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'DESCRIPTION',
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ValueListenableBuilder<bool>(
              valueListenable: notifierBottomButtons,
              child: Row(
                children: <Widget>[
                  FloatingActionButton(
                      heroTag: 'fav_1',
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      onPressed: () {}),
                  Spacer(),
                  FloatingActionButton(
                      heroTag: 'fav_2',
                      backgroundColor: Colors.black,
                      child: Icon(Icons.shopping_cart),
                      onPressed: () {
                        _openShoppingCart(context);
                      }),
                ],
              ),
              builder: (context, value, child) {
                return AnimatedPositioned(
                  duration: Duration(milliseconds: 200),
                  left: 0,
                  right: 0,
                  bottom: value ? 0 : -56 * 1.5 ,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: child,
                  ),
                );
              }),
        ],
      ),
    );
  }
}

class _ShoesSizeItem extends StatelessWidget {
  final String text;

  const _ShoesSizeItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Text(
        'US $text',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
