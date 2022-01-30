import 'package:flutter/material.dart';
import 'package:yulli/themes/yulli_themes.dart';
import 'package:yulli/widgets/body_header.dart';

class MySylverAppbar extends StatelessWidget {
  double height;
  String image;
  Widget sylverFixedWidget;
  Widget sylvercollapsedWidget;
  Widget pageBody;
  double preferedsize;
  String title;
  int badge;
  FloatingActionButton floatButton;
  bool containAppBar;
  bool containSearchBar;

  MySylverAppbar(
    this.title,
    this.badge,
    this.height,
    this.image,
    this.preferedsize,
    this.sylverFixedWidget,
    this.sylvercollapsedWidget,
    this.pageBody, {
    containAppBar = false,
    containSearchBar = false,
  }) {
    this.containAppBar = containAppBar;
    this.containSearchBar = containSearchBar;
  }
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              leading: new Container(),
              elevation: 0.0,
              bottom: PreferredSize(
                // Add this code
                preferredSize: Size.fromHeight(preferedsize), // Add this code
                child: Text(''), // Add this code
              ),
              iconTheme: IconThemeData(
                color: Colors.white, //change your color here
              ),
              //title: Text(commerc_title, style: TextStyle(color: Colors.white)),
              expandedHeight: height,
              floating: false,
              pinned: true,
              flexibleSpace: Stack(
                children: <Widget>[
                  FlexibleSpaceBar(
                    centerTitle: true,
                    background: Stack(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              YulliColors.blue[500].withOpacity(0.6),
                              BlendMode.dstIn,
                            ),
                            child: Image.asset(
                              image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 80,
                          child: sylvercollapsedWidget,
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: BodyHeader(
                      title: title,
                      badge: badge,
                      hasAppBarBehavior: containAppBar,
                      containSearchbar: containSearchBar,
                    ),
                  ),
                  sylverFixedWidget
                ],
              ),
              actions: <Widget>[],
            ),
          ),
        ];
      },
      body: Builder(
        builder: (context) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverFillRemaining(
                child: pageBody,
              ),
            ],
          );
        },
      ),
    );
    /**/
  }
}
