import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:yulli/themes/app_colors.dart';
import 'package:yulli/themes/app_dimens.dart';
import 'package:yulli/themes/app_text_styles.dart';

class SignInput extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool obscured;
  final bool obscurable;
  final String Function(String value) validator;
  final IconData iconData;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final FocusNode focusNode;
  final Function(String value) onFieldSubmitted;
  final double marginBottom;
  final bool enabled;

  const SignInput({
    Key key,
    @required this.label,
    @required this.iconData,
    this.controller,
    this.obscured = false,
    this.obscurable = false,
    this.validator,
    this.hint,
    this.textInputAction,
    this.keyboardType,
    this.focusNode,
    this.textCapitalization,
    this.onFieldSubmitted,
    this.marginBottom = AppDimens.padding,
    this.enabled = true,
  })  : assert(label != null),
        assert(iconData != null),
        assert(enabled != null),
        super(key: key);

  @override
  _SignInputState createState() => _SignInputState();
}

class _SignInputState extends State<SignInput> {
  bool _obscured = false;

  @override
  void initState() {
    _obscured = widget.obscured;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = AppTextStyles.of(context);
    final baseBorderSide = BorderSide(
      color: Colors.transparent,
      width: 2,
    );
    final baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(22),
      gapPadding: 0,
      borderSide: baseBorderSide,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Center(
          child: Text(
            widget.label,
            style: textStyles.signInputLabelTextStyle,
          ),
        ),
        SizedBox(
          height: AppDimens.smPadding,
        ),
        TextFormField(
          controller: widget.controller,
          enabled: widget.enabled,
          obscureText: _obscured,
          focusNode: widget.focusNode,
          validator: widget.validator,
          textInputAction: widget.textInputAction,
          keyboardType: widget.keyboardType,
          onFieldSubmitted: widget.onFieldSubmitted,
          textCapitalization:
              widget.textCapitalization ?? TextCapitalization.none,
          minLines: 1,
          maxLines: 1,
          style: textStyles.signInputTextStyle.copyWith(height: 1.5),
          decoration: InputDecoration(
            hintText: widget.hint,
            labelText: null,
            hintStyle: textStyles.signInputHintTextStyle,
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppDimens.smPadding,
            ),
            isDense: true,
            border: baseBorder,
            enabledBorder: baseBorder,
            errorBorder: baseBorder.copyWith(
              borderSide: baseBorderSide.copyWith(
                color: Colors.red,
              ),
            ),
            focusedBorder: baseBorder.copyWith(
              borderSide: baseBorderSide.copyWith(
                color: AppColors.secondary,
              ),
            ),
            fillColor: AppColors.signFormInputBackground,
            filled: true,
            prefixIcon: Icon(
              widget.iconData,
              size: 20,
              color: Colors.white,
            ),
            suffixIcon: widget.obscurable
                ? GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      setState(() {
                        _obscured = !_obscured;
                      });
                    },
                    child: Icon(
                      _obscured ? FeatherIcons.eyeOff : FeatherIcons.eye,
                      size: 20,
                      color: Colors.white,
                    ),
                  )
                : null,
          ),
        ),
        SizedBox(
          height: widget.marginBottom ?? AppDimens.padding,
        )
      ],
    );
  }
}
