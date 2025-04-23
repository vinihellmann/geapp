import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:geapp/app/components/button.dart';
import 'package:geapp/app/components/layout.dart';
import 'package:geapp/app/components/loading.dart';
import 'package:geapp/modules/image/providers/image_list_provider.dart';
import 'package:geapp/modules/product/providers/product_list_provider.dart';
import 'package:geapp/themes/color.dart';
import 'package:geapp/themes/text.dart';
import 'package:geapp/utils/utils.dart';
import 'package:provider/provider.dart';

class ImageListScreen extends StatelessWidget {
  const ImageListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ImageListProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) return const Loading();
        return DefaultTabController(
          length: 1,
          child: Layout(
            title: Text("Imagens", style: TText.xl),
            padding: EdgeInsets.all(16),
            bottom: TabBar(
              labelStyle: TText.ml,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: TColor.background.main,
              tabs: [Tab(text: provider.product?.name?.toUpperCase())],
            ),
            body: TabBarView(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: CarouselSlider(
                        items:
                            provider.product?.images.map((img) {
                              return GestureDetector(
                                child: Image.memory(
                                  base64Decode(img.image!),
                                  width: double.infinity,
                                ),
                                onTap: () async {
                                  await Utils.showModal(
                                    context: context,
                                    showConfirm: true,
                                    title: "Excluir",
                                    icon: Icons.delete_outline,
                                    content: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      child: Text(
                                        "Deseja realmente excluir a imagem?",
                                        style: TText.sm,
                                      ),
                                    ),
                                    onConfirm: () async {
                                      final value = await provider.delete(img);

                                      if (context.mounted && value == true) {
                                        await context.read<ProductListProvider>().getData();
                                        Utils.showToast(
                                          "Registro deletado com sucesso",
                                          ToastType.success,
                                        );
                                      }
                                    },
                                  );
                                },
                              );
                            }).toList(),
                        options: CarouselOptions(
                          enlargeCenterPage: true,
                          aspectRatio: 1,
                          autoPlay: true,
                        ),
                      ),
                    ),
                    Button(
                      label: "Adicionar Imagem",
                      onClick: () async {
                        final needUpdate = await provider.pickImage(context);

                        if (needUpdate == true && context.mounted) {
                          await context.read<ProductListProvider>().getData();
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
