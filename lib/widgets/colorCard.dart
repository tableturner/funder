import 'package:flutter/material.dart';
import 'package:funder/utils/screen_size.dart';

final bodyTextStyle = TextStyle(color: Colors.black, fontFamily: "Varela");
final titleTextStyle = TextStyle(
    color: Colors.black,
    fontFamily: "Varela",
    fontSize: 20.0,
    fontWeight: FontWeight.bold);

Widget buildColorCard(
    BuildContext context, String text, Icon icon, Color color) {
  final _media = MediaQuery.of(context).size;
  return Column(children: <Widget>[
    Container(
      margin: EdgeInsets.only(top: 20, right: 15),
      padding: EdgeInsets.all(15),
      height: screenAwareSize(79.5, context),
      width: _media.width / 2 - 25,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[800].withOpacity(0.5),
                blurRadius: 16,
                spreadRadius: 0.2,
                offset: Offset(0, 8)),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Text(
          //   text,
          //   style: TextStyle(
          //     fontSize: 18,
          //     color: Colors.white,
          //     fontWeight: FontWeight.w500,
          //   ),
          // ),
          Center(
            child: Column(
              children: <Widget>[
                IconButton(
                    onPressed: () {},
                    icon: icon,
                    iconSize: 40.0,
                    color: Colors.black),
                SizedBox(
                  height: 6.0,
                ),
                Text(
                  text,
                  style: bodyTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    )
  ]);
}
