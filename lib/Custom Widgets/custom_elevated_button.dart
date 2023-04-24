part of 'custom_widgets.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.title,
    this.hasIcon = false,
    this.icon,
    this.iconColor,
    this.iconSize,
    this.buttonColor,
    this.border,
    this.fontColor,
    this.fontSize,
    this.radius,
    this.elevation,
    this.padding,
    this.onTap,
  }) : super(key: key);

  final String title;
  final bool hasIcon;
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;
  final Color? buttonColor;
  final BorderSide? border;
  final Color? fontColor;
  final double? fontSize;
  final double? radius;
  final double? elevation;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(elevation ?? 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 8),
            side: border ?? BorderSide.none,
          ),
        ),
        backgroundColor: MaterialStateProperty.all(buttonColor),
      ),
      child: Padding(
        padding: padding ??
            EdgeInsets.symmetric(
              vertical: 8,
            ),
        child: hasIcon
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: iconColor,
                    size: iconSize ?? 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: TextStyle(
                      color: fontColor,
                      fontSize: fontSize ?? 24,
                    ),
                  ),
                ],
              )
            : Text(
                title,
                style: TextStyle(
                  color: fontColor,
                  fontSize: fontSize ?? 24,
                ),
              ),
      ),
    );
  }
}
