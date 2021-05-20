import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

import 'favorite_button.dart';

class DefaultVideoInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              /// Username, time, brand information
              ///
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _userNameAndTimeUploadedWidget(),
                  SizedBox(height: 8.0),

                  /// rainbow brand
                  ///
                  _rainBowBrandWidget(),
                  SizedBox(height: 8.0),

                  /// song name
                  ///
                  _songNameWidget(),
                  SizedBox(height: 8.0),
                ],
              ),

              /// Like, more.
              ///
              _likeMoreWidget()
            ],
          ),
        ),
      ],
    );
  }

  /// Like heart icon: tap to increase like number
  /// More option: tap to share or edit
  ///
  Widget _likeMoreWidget() {
    return Container(
      alignment: Alignment.centerRight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "123.4k",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                height: 0.16,
                fontFamily: "Inter",
                color: Colors.white),
          ),
          SizedBox(height: 5),
          FavoriteButton(
            initFavorite: false,
            onFavoriteClicked: (liked) {
              return Future.value(!liked);
            },
          ),
          SizedBox(height: 15),
          InkWell(
            onTap: () {},
            child: Icon(
              Icons.more_horiz,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  /// Render song name, auto scroll
  ///
  Widget _songNameWidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.music_note,
          color: Colors.white,
          size: 16,
        ),
        SizedBox(width: 8.0),
        Container(
          width: 220,
          height: 20,
          child: Center(
            child: Marquee(
              text: "Đưa tay lên nào, mãi bên nhau bạn nhé",
              style: TextStyle(color: Colors.white),
              scrollAxis: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              blankSpace: 20.0,
              startPadding: 10.0,
              velocity: 50.0,
              showFadingOnlyWhenScrolling: true,
              fadingEdgeStartFraction: 0.1,
              fadingEdgeEndFraction: 0.1,
            ),
          ),
        )
      ],
    );
  }

  /// Rainbow branch information
  Widget _rainBowBrandWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.location_on,
          color: Colors.white,
          size: 16,
        ),
//        Image(
//          image: ,
//          width: 16,
//          height: 16,
//          color:  Colors.white,
//        ),
        SizedBox(width: 8.0),
        Container(
          width: 220,
          child: Text(
            "Branch name",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  /// Show user name and the time video uploaded
  ///
  Widget _userNameAndTimeUploadedWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "Owner name",
          style: TextStyle(color: Colors.white),
        ),
        Row(
          children: [
            Container(
              width: 4,
              height: 4,
              margin: EdgeInsets.only(left: 5, right: 5),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(3)),
            ),
            Text(
              "12w ago",
              textAlign: TextAlign.end,
              style: TextStyle(color: Colors.white),
            ),
          ],
        )
      ],
    );
  }
}
