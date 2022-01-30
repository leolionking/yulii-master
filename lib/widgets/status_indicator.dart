import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:yulli/models/status.dart';
import 'package:yulli/extensions/index.dart';
import 'package:yulli/widgets/if_else_widget.dart';

class StatusIndicator extends StatefulWidget {
  final Status status;
  final Status animateTo;
  final Function(Status, Status) onAnimationComplete;
  final double size;
  final bool animated;

  StatusIndicator({
    Key key,
    @required this.status,
    this.size = 36,
    this.animateTo,
    this.onAnimationComplete,
    this.animated = true,
  })  : assert(status != null),
        assert(animated != null),
        super(key: key);

  @override
  _StatusIndicatorState createState() => _StatusIndicatorState();
}

class _StatusIndicatorState extends State<StatusIndicator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.animateTo != null ? (widget.size + 2) : widget.size,
      width: widget.animateTo != null ? (widget.size + 2) : widget.size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: !widget.animated
            ? Border.all(
                color: widget.status.color,
                width: 3,
              )
            : null,
      ),
      child: IfElseWidget(
        condition: widget.animated,
        ifWidget: CustomAnimation<double>(
          curve: Curves.easeInOut,
          builder: (context, child, value) {
            return SleekCircularSlider(
              max: 100.0,
              initialValue: widget.animateTo != null ? value : 0,
              appearance: CircularSliderAppearance(
                animationEnabled: true,
                startAngle: 270,
                angleRange: 360,
                customWidths: CustomSliderWidths(
                  progressBarWidth: widget.animateTo != null ? 3 : 0,
                  trackWidth: 3,
                  handlerSize: 0,
                  // shadowWidth: .1,
                ),
                customColors: CustomSliderColors(
                  progressBarColor:
                      widget.animateTo?.color ?? Colors.transparent,
                  trackColor: widget.status.color,
                  shadowStep: 4,
                  shadowMaxOpacity: 0,
                  dotColor: Colors.transparent,
                  hideShadow: true,
                ),
              ),
              innerWidget: (value) {
                return Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Opacity(
                      opacity: widget.animateTo != null
                          ? ((100.0 - value) / 100.0)
                          : 1,
                      child: widget.status.widget,
                    ),
                    if (widget.animateTo != null)
                      Opacity(
                        opacity: value / 100.0,
                        child: widget.animateTo.widget,
                      ),
                  ],
                );
              },
            );
          },
          duration: Duration(milliseconds: 800),
          tween: 0.0.tweenTo(100.0),
          control: widget.animateTo != null
              ? CustomAnimationControl.PLAY
              : CustomAnimationControl.STOP,
          animationStatusListener: (astatus) {
            if (astatus == AnimationStatus.completed) {
              Future.delayed(Duration(milliseconds: 10), () {
                widget.onAnimationComplete
                    ?.call(widget.status, this.widget.animateTo);
              });
            }
          },
        ),
        elseWidget: Center(
          child: widget.status.widget,
        ),
      ),
    );
  }
}
