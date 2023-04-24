part of 'custom_widgets.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    TextEditingController? controller,
    this.initialValue,
    this.obscureText = false,
    this.onChanged,
    this.onTap,
    this.filled = false,
    this.fillColor,
    this.suffixIcon,
    this.prefixIcon,
    this.suffixIconColor,
    this.suffixIconSize,
    this.suffixIconConstraints,
    this.errorText,
    this.errorStyle,
    this.labelText,
    this.labelStyle,
    this.hintText,
    this.hintStyle,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.isDense = true,
    this.readOnly = false,
    this.alignLabelWithText,
    this.maxLines = 1,
    this.minLines,
    this.keyboardType,
    this.border,
    this.contentPadding,
    this.contentStyle,
    this.validator,
  })  : _controller = controller,
        super(key: key);

  final TextEditingController? _controller;
  final String? initialValue;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool filled;
  final Color? fillColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? suffixIconColor;
  final double? suffixIconSize;
  final BoxConstraints? suffixIconConstraints;
  final String? errorText;
  final TextStyle? errorStyle;
  final String? labelText;
  final TextStyle? labelStyle;
  final String? hintText;
  final TextStyle? hintStyle;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final bool isDense;
  final bool readOnly;
  final bool? alignLabelWithText;
  final int? maxLines;
  final int? minLines;
  final TextInputType? keyboardType;
  final InputBorder? border;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? contentStyle;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: filled,
        fillColor: fillColor,
        border: border,
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(
                color: Colors.black,
              ),
            ),
        errorBorder: errorBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Colors.grey),
            ),
        focusedErrorBorder: focusedErrorBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
        errorText: errorText,
        errorStyle: errorStyle,
        hintText: hintText,
        hintStyle: hintStyle,
        isDense: isDense,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        contentPadding:
            contentPadding ?? const EdgeInsets.fromLTRB(16, 12, 16, 12),
        suffixIconConstraints: suffixIconConstraints,
        labelText: labelText,
        labelStyle: labelStyle,
        alignLabelWithHint: alignLabelWithText,
      ),
      onTap: onTap,
      readOnly: readOnly,
      keyboardType: keyboardType,
      controller: _controller,
      onChanged: onChanged,
      validator: validator,
      style: contentStyle,
      maxLines: maxLines,
      minLines: minLines,
    );
  }
}
