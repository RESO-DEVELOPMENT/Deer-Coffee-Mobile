import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../models/product.dart';
import '../../utils/format.dart';
import '../../utils/route_constrant.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Get.toNamed("${RouteHandler.PRODUCT_DETAIL}?id=${product.id}");
            },
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Đặt căn chỉnh các phần tử trong hàng lên trên cùng
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return SizedBox(
                              width: 50,
                              height: 50,
                              child: Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            );
                          },
                          product.picUrl!.isEmpty
                              ? 'https://i.imgur.com/X0WTML2.jpg'
                              : product.picUrl!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment
                            .start, // Đặt căn chỉnh theo chiều ngang sang trái
                        children: [
                          Text(product.name ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Get.textTheme.bodySmall),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Text(product.description ?? "",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Get.textTheme.labelSmall
                                        ?.copyWith(color: Colors.grey)),
                              ),
                              Text(formatPrice(product.sellingPrice ?? 0),
                                  style: Get.textTheme.labelSmall),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Thêm nút "Add" và xử lý khi được nhấn
                  ],
                ),
              ],
            ),
          ),
        ),
        // const Divider(
        //   thickness: 0.5,
        //   height: 1,
        //   color: Colors.grey,
        // )
      ],
    );
  }
}
