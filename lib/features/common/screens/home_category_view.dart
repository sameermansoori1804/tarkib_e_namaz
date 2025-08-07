import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/home/domain/models/post_model.dart';
import 'package:flutter_template/features/splash/controller/splash_controller.dart';
import 'package:get/get.dart';
import '../../../route/routes.dart';
import '../../../route/routes_name.dart';
import '../../../utils/images.dart';

class HomeCategoryView extends StatefulWidget {
  const HomeCategoryView({super.key});

  @override
  State<HomeCategoryView> createState() => _HomeCategoryViewState();
}

class _HomeCategoryViewState extends State<HomeCategoryView> {
  // Example data


  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(builder: (splashController) {
      return Column(
        children: List.generate(splashController.categories!.length, (index) {

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      splashController.categories![index].title!,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "View All",
                      style: TextStyle(color: Colors.teal),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Horizontal image list
              SizedBox(
                height: 100, // fixed height for horizontal list
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: splashController.categories![index].posts!.length, // Replace with dynamic count later
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemBuilder: (context, postIndex) {
                    Posts post = splashController.categories![index].posts![postIndex];
                    print("farukh-----");
                    print(post.thumbnail);
                    print("farukh-----");

                    return InkWell(
                      onTap: (){

                        Get.toNamed(AppRoutes.openPdfRoute(post.url ?? "",post.title ?? "")); // Replace with your HomeScreen route

                      },
                      child: Container(
                        width: 100,
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: (post.thumbnail != null && post.thumbnail!.isNotEmpty)
                                  ? post.thumbnail!
                                  : "invalid-url", // Forces errorWidget if blank
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Image.asset(
                               Images.noInternet,
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                Images.noInternet,
                                fit: BoxFit.cover,
                              ),
                            ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),
            ],
          );
        }),
      );
    });
  }
}
