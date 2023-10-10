import 'package:flutter/material.dart';
import 'package:whatsappme/common/extension/custom_theme_extention.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key, required this.onTap, required this.icon, this.iconColor, this.iconSize, this.minWidth, this.backgroundColor, this.border,
  });
  
  final VoidCallback onTap;
  final IconData icon;
  final Color ?iconColor;
  final double? iconSize;
  final double? minWidth;
  final Color? backgroundColor;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: border
      ),
      child: IconButton(
        onPressed: onTap,
        icon: Icon(
          icon,
          color:iconColor??Theme.of(context).appBarTheme.iconTheme?.color,
        ),
        splashColor: Colors.transparent,
        splashRadius: (minWidth?? 45)-25,
        iconSize: iconSize?? 22,
        padding: EdgeInsets.zero,
        constraints:  BoxConstraints(minWidth:minWidth?? 45, minHeight: minWidth?? 45),
      ),
    );
  }
}