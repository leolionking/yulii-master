import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:yulli/constants/asset_images.dart';
import 'package:yulli/themes/yulli_themes.dart';
import 'package:yulli/widgets/avatar.dart';
import 'package:yulli/widgets/my_avatar.dart';

class FriendWidget extends StatelessWidget {
  String name;
  int nb_point;
  int note;
  int max;
  bool closable;

  FriendWidget(this.name, this.nb_point, this.note, this.max, {closable = true})
      : this.closable = closable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: YulliVars.horizpadding, vertical: 15),
      child: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(5),
                child: MyAvatar(user: null),
              ),
              closable
                  ? Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.red,
                        ),
                        height: 12,
                        width: 12,
                        child: Icon(
                          Icons.close,
                          size: 10,
                          color: Colors.white,
                        ),
                      ))
                  : Container()
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: 15),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.sort,
                    color: YulliColors.grey,
                  ),
                  LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width - 215,
                    lineHeight: 8.0,
                    percent: note / max,
                    backgroundColor: YulliColors.grey,
                    progressColor: YulliColors.blue[500],
                  ),
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: note.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                                text: "/${max.toString()}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12)),
                          ]))
                ],
              ),
              Row(
                children: <Widget>[
                  Image.asset(
                    "assets/images/trophy.png",
                    width: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                  ),
                  Text("$nb_point ",
                      style: TextStyle(
                          color: YulliColors.yellow[500],
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  Text("points",
                      style: TextStyle(color: YulliColors.yellow[500]))
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
