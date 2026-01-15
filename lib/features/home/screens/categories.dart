import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/qaza_namaz/controller/qaza_controller.dart';
import 'package:flutter_template/utils/images.dart';
import 'package:get/get.dart';
import 'package:modern_dialog/modern_dialog.dart';

import '../../../route/routes.dart';
import '../../common/screens/animated_item.dart';
import '../../splash/controller/splash_controller.dart';
import '../domain/models/post_model.dart';




class CategoryScreen extends StatefulWidget {


  final int categories;
  CategoryScreen({required this.categories});
  @override
  _CategoryScreenState createState() => _CategoryScreenState();


}

class _CategoryScreenState extends State<CategoryScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4ECDC4),
        elevation: 0,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        title: Text(
          'Qaza Namaz',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body:GetBuilder<SplashController>(builder: (splashController){
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            itemCount: splashController.categories![widget.categories].posts!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.9,
            ),
            itemBuilder: (context, index) {
              Posts post = splashController.categories![widget.categories].posts![index];

              // Animation delay based on index for staggered effect
              final animationDelay = 100 * index;

              return AnimatedItem(
                delay: animationDelay,
                child: InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.openPdfRoute(post.url ?? "", post.title ?? ""));
                  },
                  child: Column(
                    children: [
                      // Animated container with shadow
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.easeInOut,
                        width: 120,
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Stack(
                            children: [
                              // Cached network image with fade animation
                              Hero(
                                tag: post.thumbnail ?? "thumbnail-$index",
                                child: CachedNetworkImage(
                                  imageUrl: (post.thumbnail != null && post.thumbnail!.isNotEmpty)
                                      ? post.thumbnail!
                                      : "invalid-url",
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => FadeTransition(
                                    opacity: AlwaysStoppedAnimation(0.5),
                                    child: Image.asset(
                                      Images.noInternet,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Image.asset(
                                    Images.noInternet,
                                    fit: BoxFit.cover,
                                  ),
                                  fadeInDuration: const Duration(milliseconds: 300),
                                  fadeInCurve: Curves.easeIn,
                                ),
                              ),
                              // Optional overlay for better text visibility
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black.withOpacity(0.3),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Animated text
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                        child: Text(
                          _limitText(post.title ?? ""),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      })
    );
  }
  String _limitText(String text, {int maxLength = 15}) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }
}
