import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodeoapp/constant/theme.dart';
import 'package:get/get.dart';

import 'small_loader.dart';

class RoundButton extends StatefulWidget {
  const RoundButton({
    Key? key,
    required this.height,
    this.width,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.icon,
    required this.title,
    this.iconColor,
    required this.onTap,
    this.margin = 20,
    this.borderColor = Colors.white,
    this.loading = false,
    this.disabled = false,
    this.gradient = false,
  }) : super(key: key);
  final double height;
  final double? width;
  final Color backgroundColor;
  final Color textColor;
  final String? icon;
  final String title;
  final Color? iconColor;
  final Color? borderColor;
  final VoidCallback onTap;
  final double margin;
  final bool loading;
  final bool disabled;
  final bool gradient;

  @override
  State<RoundButton> createState() => _RoundButtonState();
}

class _RoundButtonState extends State<RoundButton> {
  bool pressed = false;
  final themeController = Get.put(ThemeHelper());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (details) {
        if (widget.loading || widget.disabled) return;
        setState(() {
          pressed = true;
        });
      },
      onPanEnd: (_) {
        if (widget.loading || widget.disabled) return;
        setState(() {
          pressed = false;
        });
      },
      onPanCancel: () {
        if (widget.loading || widget.disabled) return;
        setState(() {
          pressed = false;
        });
      },
      onTap: () {
        if (widget.loading || widget.disabled) return;
        widget.onTap();
      },
      child: AnimatedOpacity(
        opacity: pressed ? 0.8 : 1,
        duration: const Duration(milliseconds: 250),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            color: widget.gradient
                ? null
                : widget.disabled
                    ? widget.backgroundColor.withOpacity(0.6)
                    : widget.backgroundColor,
            gradient:
                widget.gradient ? themeController.backgroundGradient : null,
            borderRadius: BorderRadius.circular(35),
            border: Border.all(color: widget.borderColor!, width: 0.3),
            boxShadow: [
              BoxShadow(
                color: widget.backgroundColor.withOpacity(0.1),
                spreadRadius: 1.5,
                blurRadius: 4,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          height: widget.height,
          width: widget.width,
          margin: EdgeInsets.symmetric(horizontal: widget.margin),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null && !widget.loading)
                SvgPicture.asset(
                  widget.icon!,
                  color: widget.iconColor,
                  height: 20,
                ),
              if (widget.icon != null && !widget.loading)
                const SizedBox(width: 10),
              if (!widget.loading)
                Text(
                  widget.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: widget.gradient ? Colors.white : widget.textColor,
                    fontSize: 12.sp,
                  ),
                ),
              if (widget.loading)
                SmallLoader(
                  color: widget.disabled ? Color(0xFFf7746c) : Colors.white,
                  adaptive: true,
                )
            ],
          ),
        ),
      ),
    );
  }
}
