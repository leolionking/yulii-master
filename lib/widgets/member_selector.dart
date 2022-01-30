import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yulli/common/utils/focus_node_utils.dart';
import 'package:yulli/constants/asset_images.dart';
import 'package:yulli/models/user.dart';
import 'package:yulli/services/db_service.dart';
import 'package:yulli/themes/yulli_themes.dart';
import 'package:yulli/widgets/dotted_button.dart';
import 'package:yulli/widgets/round_image.dart';

class MemberSelector extends StatefulWidget {
  final bool forFriends;
  String title;
  List<User> selectedMembers = [];
  final Function(List<User>) onChanged;
  final bool buttonBlocked;

  MemberSelector(
    this.title,
    this.selectedMembers, {
    @required this.onChanged,
    this.forFriends = false,
    this.buttonBlocked = false,
  });

  @override
  _MemberSelectorState createState() =>
      _MemberSelectorState(this.title, this.selectedMembers);
}

class _MemberSelectorState extends State<MemberSelector> {
  List<User> selectedMembers = [];
  String title;
  _MemberSelectorState(this.title, this.selectedMembers);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ConstrainedBox(
          child: ListView.builder(
              itemCount: selectedMembers.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Row(
                  children: <Widget>[
                    selectedMembers[index].isValid
                        ? Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: RoundImage(AssetImages.avatarPlaceholder),
                          )
                        : SizedBox(),
                    index == selectedMembers.length - 1 &&
                            selectedMembers.length <= 2
                        ? DottedButton(() async {
                            FocusNodeUtils.unfocusAll();
                            if (widget.buttonBlocked) return;
                            final friends = await Provider.of<DbService>(
                                    context,
                                    listen: false)
                                .getFriends();

                            runDialog(context, friends);
                          })
                        : Container()
                  ],
                );
                /*Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: RoundImage("assets/images/Bitmap.png"),
                );*/
              }),
          constraints: new BoxConstraints.loose(
            new Size(MediaQuery.of(context).size.width / 2 - 50, 30),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 10.0),
        ),
      ],
    );
    /* */
  }

  runDialog(context, List<User> users) {
    var dialogHeight = MediaQuery.of(context).size.height * 2 / 5;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: YulliColors.blue[500],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                height: dialogHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: YulliColors.blue[500],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.close,
                              color: YulliColors.light,
                              size: 25,
                            )),
                        Padding(
                          padding: EdgeInsets.only(left: 5.0),
                        ),
                        Text(
                          title,
                          style:
                              TextStyle(color: YulliColors.light, fontSize: 18),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16),
                    ),
                    Container(
                      height: 35,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: YulliColors.blue[500],
                          width: 1.0,
                        ),
                        color: YulliColors.blue[300],
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          new Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 0.0,
                              horizontal: 15.0,
                            ),
                            child: Icon(
                              Icons.search,
                              color: YulliColors.light,
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              style: TextStyle(height: 1.0),
                              cursorColor: YulliColors.light,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Nom ou e-mail",
                                hintStyle: TextStyle(color: YulliColors.light),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 50.0),
                          )
                        ],
                      ),
                    ),
                    ConstrainedBox(
                      child: ListView.builder(
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              child: GestureDetector(
                                child: Row(
                                  children: <Widget>[
                                    RoundImage(AssetImages.avatarPlaceholder),
                                    Padding(
                                      padding: EdgeInsets.only(right: 10),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          users[index].displayName,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          users[index].email,
                                          style: TextStyle(
                                            color: YulliColors.light,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider()
                                  ],
                                  //trailing: Icon(Icons.more_vert),
                                ),
                                onTap: () {
                                  setState(() {
                                    selectedMembers.clear();
                                    selectedMembers.add(User.empty());
                                    selectedMembers.add(users[index]);
                                    Navigator.pop(context);
                                  });
                                  widget.onChanged?.call(selectedMembers);
                                },
                              ),
                            );
                          }),
                      constraints: new BoxConstraints.loose(
                        new Size(MediaQuery.of(context).size.width,
                            dialogHeight - 120),
                      ),
                    )
                  ],
                )),
          );
        });
  }
}
