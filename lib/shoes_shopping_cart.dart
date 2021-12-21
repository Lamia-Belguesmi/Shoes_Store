import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoes_store_app/shoes.dart';

const _buttonSizeWidth = 160.0;
const _buttonSizeHeight = 60.0;
const _buttonCircularSize = 60.0;
const _finalImageSize = 30.0;
const _imageSize = 150.0;

class ShoppingCart extends StatefulWidget {
  final Shoes shoes;

  ShoppingCart({required this.shoes});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation? _animationResize;
  Animation? _animationMovementIn;
  Animation? _animationMovementOut;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 3000,
      ),
    );
    _animationResize = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Interval(
          0.0,
          0.3,
        ),
      ),
    );
    _animationMovementIn = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Interval(
          0.35,
          0.45,
          curve: Curves.easeOutQuint,
        ),
      ),
    );
    _animationMovementOut = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Interval(
          0.6,
          1.0,
          curve: Curves.elasticIn,
        ),
      ),
    );
    _controller!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pop(true);
      }
    });
    super.initState();
  }

  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  Widget _buildPanel() {
    final size = MediaQuery.of(context).size;
    final currentImageSize = (_imageSize * _animationResize!.value)
        .clamp(_finalImageSize, _imageSize);

    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 400),
      curve: Curves.easeIn,
      tween: Tween(begin: 1.0, end: 0.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(
            0,
            value * size.height * 0.9,
          ),
          child: child,
        );
      },
      child: Container(
        height: (size.height * 0.9 * _animationResize!.value).clamp(
          _buttonCircularSize,
          size.height * 0.9,
        ),
        width: (size.width * _animationResize!.value).clamp(
          _buttonCircularSize,
          size.width,
        ),
        decoration: BoxDecoration(
          color:  Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: _animationResize!.value == 1
                ? Radius.circular(0)
                : Radius.circular(30),
            bottomRight: _animationResize!.value == 1
                ? Radius.circular(0)
                : Radius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: _animationResize!.value == 1
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    widget.shoes.images.first,
                    height: currentImageSize,
                  ),
                  if (_animationResize!.value == 1) ...[
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          widget.shoes.model,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          '\$${widget.shoes.currentPrice.toInt().toString()}',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              _ShoesSizeItem(text: '6'),
                              _ShoesSizeItem(text: '7 '),
                              _ShoesSizeItem(text: '9'),
                              _ShoesSizeItem(text: '10'),
                              _ShoesSizeItem(text: '11'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.transparent,
      child: AnimatedBuilder(
          animation: _controller!,
          builder: (context, child) {
            final buttonSizeWidth = (_buttonSizeWidth * _animationResize!.value)
                .clamp(_buttonCircularSize, _buttonSizeWidth);
            final panelSizeWidth = (size.width * _animationResize!.value)
                .clamp(_buttonCircularSize, size.width);
            return Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      color: Colors.black87,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Stack(
                    children: <Widget>[
                      if (_animationMovementIn!.value != 1)
                        Positioned(
                          top: size.height * 0.1 +
                              (_animationMovementIn!.value *
                                  size.height *
                                  0.471),
                          left: size.width / 2 - panelSizeWidth / 2,
                          width: panelSizeWidth,
                          child: _buildPanel(),
                        ),
                      Positioned(
                        top: size.height * 0.6 -
                            (_animationMovementOut!.value * 30),
                        left: size.width / 2 - buttonSizeWidth / 2,
                        child: TweenAnimationBuilder<num>(
                          duration: Duration(milliseconds: 400),
                          curve: Curves.easeIn,
                          tween: Tween(begin: 1.0, end: 0.0),
                          builder: (context, value, child) {
                            return Transform.translate(
                              offset: Offset(
                                0.0,
                                value * size.height * 0.9,
                              ),
                              child: child,
                            );
                          },
                          child: InkWell(
                            onTap: () {
                              _controller!.forward();
                            },
                            child: Container(
                              width: buttonSizeWidth,
                              height: (_buttonSizeHeight *
                                      _animationResize!.value)
                                  .clamp(
                                      _buttonCircularSize, _buttonSizeHeight),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Expanded(
                                      child: Icon(
                                        Icons.shopping_cart,
                                        color: Colors.white,
                                      ),
                                    ),
                                    if (_animationResize!.value == 1) ...[
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          'ADD TO CART ',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ]
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }),
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
          fontSize: 13,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
