import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FavoriteButton extends StatefulWidget {
  final Future<bool> Function(bool) onFavoriteClicked;
  final bool initFavorite;

  FavoriteButton({required this.onFavoriteClicked, this.initFavorite = false});

  @override
  State<StatefulWidget> createState() {
    return _FavoriteButtonState();
  }
}

class _FavoriteButtonState extends State<FavoriteButton>
    with TickerProviderStateMixin {
  bool _isFavorite = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.initFavorite;

    _controller = AnimationController(
        vsync: this,
        value: _isFavorite ? 1.0 : 0.0,
        duration: Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _isFavorite = !_isFavorite;
        var s = widget.onFavoriteClicked(_isFavorite);
        if (s == null) return;
        if (_isFavorite) {
          _controller.animateTo(1.0, duration: Duration(milliseconds: 300));
        } else {
          _controller.animateBack(0, duration: Duration(milliseconds: 300));
        }
//        widget.onFavoriteClicked(_isFavorite).then((value) {
//          if (value != null && value) {
//            _controller.animateTo(1.0, duration: Duration(milliseconds: 300));
//          } else {
//            _controller.animateBack(0, duration: Duration(milliseconds: 300));
//          }
//        });
      },
      child: Container(
        child: Lottie.asset("assets/lottie_heart.json", controller: _controller,
            onLoaded: (composition) {
          _controller..duration = composition.duration;
        }),
        width: 50,
        height: 50,
      ),
    );
  }
}
