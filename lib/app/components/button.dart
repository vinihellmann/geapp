import 'package:geapp/themes/color.dart';
import 'package:geapp/themes/text.dart';
import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  const Button({
    super.key,
    this.outlined = false,
    this.label,
    this.width,
    this.bgColor,
    this.isLoading,
    this.onClick,
    this.content,
  });

  final bool? outlined;
  final String? label;
  final double? width;
  final Color? bgColor;
  final bool? isLoading;
  final Function? onClick;
  final Widget? content;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        height: 40,
        width: widget.width ?? MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color:
              widget.outlined == true
                  ? TColor.background.main
                  : widget.bgColor ?? TColor.button.primary,
          border:
              widget.outlined == true
                  ? Border.all(color: TColor.button.primary)
                  : null,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          splashColor:
              widget.outlined == true
                  ? TColor.background.main
                  : TColor.primary.dark,
          highlightColor:
              widget.outlined == true
                  ? TColor.background.main
                  : TColor.primary.dark,
          onTap:
              widget.isLoading != true && widget.onClick != null
                  ? () => widget.onClick!()
                  : null,
          child: Center(
            child:
                widget.isLoading == true
                    ? SizedBox(
                      width: 15,
                      height: 15,
                      child: CircularProgressIndicator(
                        color: TColor.text.primary,
                        strokeWidth: 2,
                      ),
                    )
                    : (widget.label != null
                            ? Text(widget.label!, style: TText.ml)
                            : null) ??
                        widget.content,
          ),
        ),
      ),
    );
  }
}
