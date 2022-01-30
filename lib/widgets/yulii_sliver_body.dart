import 'package:flutter/material.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/themes/yulli_themes.dart';
import 'package:yulli/widgets/body_header.dart';

class YuliiSliverBody extends StatefulWidget {
  final double minHeaderHeight;
  final double maxHeaderHeight;
  final ImageProvider headerBackgroundImage;
  final Widget headerFixedArea;
  final Widget headerBackground;
  final String bodyTitle;
  final int bodyBadgeCount;
  final Widget body;
  final ScrollController controller;

  const YuliiSliverBody({
    Key key,
    @required this.minHeaderHeight,
    @required this.maxHeaderHeight,
    @required this.headerBackgroundImage,
    @required this.headerFixedArea,
    @required this.headerBackground,
    @required this.bodyTitle,
    @required this.body,
    this.bodyBadgeCount = 0,
    this.controller,
  })  : assert(minHeaderHeight != null),
        assert(maxHeaderHeight != null),
        assert(headerBackgroundImage != null),
        assert(headerFixedArea != null),
        assert(headerBackground != null),
        assert(bodyTitle != null),
        assert(bodyBadgeCount != null),
        assert(body != null),
        super(key: key);

  @override
  _YuliiSliverBodyState createState() => _YuliiSliverBodyState();
}

class _YuliiSliverBodyState extends State<YuliiSliverBody> {
  bool _appBarCollapsed = false;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: widget.controller,
      slivers: <Widget>[
        SliverAppBar(
          bottom: PreferredSize(
            child: const SizedBox(),
            preferredSize: Size.fromHeight(widget.minHeaderHeight),
          ),
          expandedHeight: widget.maxHeaderHeight,
          elevation: 0,
          floating: false,
          pinned: true,
          flexibleSpace: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: <Widget>[
                  FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    centerTitle: true,
                    background: LayoutBuilder(
                      builder: (context, constraints) {
                        return Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  YulliColors.blue[500].withOpacity(0.6),
                                  BlendMode.dstIn,
                                ),
                                child: Image(
                                  image: widget.headerBackgroundImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 72,
                              child: ConstrainedBox(
                                constraints: constraints,
                                child: widget.headerBackground,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: BodyHeader(
                      title: widget.bodyTitle,
                      badge: widget.bodyBadgeCount,
                      showShadow: _appBarCollapsed,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: AppDimens.xlPadding,
                      left: AppDimens.lgPadding,
                      right: AppDimens.padding,
                    ),
                    child: widget.headerFixedArea,
                  )
                ],
              );
            },
          ),
        ),
        widget.body,
        SliverPadding(
          padding: EdgeInsets.symmetric(
            vertical: AppDimens.lgPadding,
          ),
        ),
      ],
    );
  }
}
