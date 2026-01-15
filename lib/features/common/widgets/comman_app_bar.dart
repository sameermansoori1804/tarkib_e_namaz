import 'package:flutter/material.dart';
import '../../../utils/app_color.dart';

class CommanAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CommanAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.primaryColor,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: AppColor.white),
        onPressed: () => Navigator.pop(context), // ✅ makes back button functional
      ),
      title: Text(
        title,
        style: TextStyle(
          color: AppColor.white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
