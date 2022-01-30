import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yulli/common/utils/my_logger.dart';
import 'package:yulli/models/deal_obj.dart';
import 'package:yulli/models/goal.dart';
import 'package:yulli/models/task.dart';
import 'package:yulli/services/db_service.dart';
import 'package:yulli/themes/yulli_themes.dart';
import 'package:yulli/widgets/dotted_button.dart';
import 'package:yulli/widgets/round_image.dart';
import 'package:yulli/widgets/small_text.dart';

class TaskSelector extends StatefulWidget {
  final String title;
  final List<Task> selected;
  final Function(Task) onSelected;

  TaskSelector(
    this.title, {
    Key key,
    this.selected = const [],
    this.onSelected,
  }) : super(key: key);

  @override
  _TaskSelectorState createState() => _TaskSelectorState();
}

class _TaskSelectorState<T> extends State<TaskSelector> {
  @override
  Widget build(BuildContext context) {
    final dbService = Provider.of<DbService>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 30, left: YulliVars.horizpadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SmallText(widget.title),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
              ),
              DottedButton(() async {
                var elements = [];

                elements = await dbService.getAuthoredTasks();

                runDialog(context, elements);
              }),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
              ),
              Column(
                  children: List.generate(widget.selected.length, (index) {
                var goal = widget.selected[index];

                return Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: <Widget>[
                      // RoundImage("assets/images/Bitmap.png"),
                      // Padding(
                      //   padding: EdgeInsets.only(right: 10),
                      // ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            goal.name,
                            style: TextStyle(
                              color: YulliColors.grey_dark,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                goal.points.toString() + " points",
                                style: TextStyle(
                                  color: YulliColors.grey,
                                ),
                              ),
                              // Padding(
                              //   padding: EdgeInsets.only(left: 10.0),
                              //   child: Image.asset("assets/images/clock.png"),
                              // ),
                            ],
                          )
                        ],
                      ),
                    ],
                    //trailing: Icon(Icons.more_vert),
                  ),
                );
              }))
            ],
          ),
        )
      ],
    );
  }

  runDialog(context, List<Task> elements) {
    var dialogHeight = MediaQuery.of(context).size.height * 2 / 5;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: YulliColors.blue[500],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.0),
                    ),
                    Text(
                      widget.title,
                      style: TextStyle(color: YulliColors.light, fontSize: 18),
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
                            vertical: 0.0, horizontal: 15.0),
                        child: Icon(
                          Icons.search,
                          color: YulliColors.light,
                        ),
                      ),
                      new Expanded(
                        child: TextField(
                          style: TextStyle(height: 1.0),
                          cursorColor: YulliColors.light,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Titre",
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
                    itemCount: elements.length,
                    itemBuilder: (context, index) {
                      var element = elements[index];

                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: Ink(
                          child: InkWell(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text(
                                  element.name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  element.points.toString(),
                                  style: TextStyle(
                                    color: YulliColors.light,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              // MyLogger.debug(message: element);
                              widget.onSelected?.call(element);
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  constraints: new BoxConstraints.loose(
                    new Size(
                      MediaQuery.of(context).size.width,
                      dialogHeight - 120,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
