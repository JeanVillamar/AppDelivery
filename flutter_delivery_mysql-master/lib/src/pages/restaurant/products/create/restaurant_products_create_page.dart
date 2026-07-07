import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter_delivery/src/models/category.dart';
import 'package:udemy_flutter_delivery/src/pages/restaurant/products/create/restaurant_products_create_controller.dart';
import 'package:udemy_flutter_delivery/src/theme/app_theme.dart';

class RestaurantProductsCreatePage extends StatelessWidget {
  RestaurantProductsCreateController con =
      Get.put(RestaurantProductsCreateController());

  RestaurantProductsCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _banner(),
              const SizedBox(height: 24),
              _sectionLabel('Datos del producto'),
              const SizedBox(height: 14),
              _formCard(),
              const SizedBox(height: 20),
              _sectionLabel('Imágenes del producto'),
              const SizedBox(height: 14),
              _imagesCard(context),
              const SizedBox(height: 24),
              _buttonCreate(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _banner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(Icons.fastfood, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nuevo producto',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Agrega un platillo a tu catálogo',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Text(
      text.toUpperCase(),
      style: TextStyle(
        color: AppColors.muted,
        fontSize: 12,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _formCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
        child: Column(
          children: [
            TextField(
              controller: con.nameController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                hintText: 'Ej. Hamburguesa clásica',
                prefixIcon: Icon(Icons.fastfood_outlined),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: con.descriptionController,
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Descripción',
                hintText: 'Ingredientes, tamaño, etc.',
                alignLabelWithHint: true,
                prefixIcon: Icon(Icons.description_outlined),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: con.priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Precio',
                hintText: '0.00',
                prefixIcon: Icon(Icons.attach_money),
              ),
            ),
            const SizedBox(height: 16),
            _dropDownCategories(),
          ],
        ),
      ),
    );
  }

  Widget _dropDownCategories() {
    return Obx(
      () => DropdownButtonFormField<String>(
        isExpanded: true,
        decoration: const InputDecoration(
          labelText: 'Categoría',
          prefixIcon: Icon(Icons.local_offer_outlined),
        ),
        hint: const Text('Seleccionar categoría'),
        value: con.idCategory.value == '' ? null : con.idCategory.value,
        items: _dropDownItems(con.categories),
        onChanged: (option) => con.idCategory.value = option ?? '',
      ),
    );
  }

  List<DropdownMenuItem<String>> _dropDownItems(List<Category> categories) {
    return categories
        .map((category) => DropdownMenuItem<String>(
              value: category.id,
              child: Text(category.name ?? ''),
            ))
        .toList();
  }

  Widget _imagesCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GetBuilder<RestaurantProductsCreateController>(
              builder: (_) => _cardImage(context, con.imageFile1, 1),
            ),
            GetBuilder<RestaurantProductsCreateController>(
              builder: (_) => _cardImage(context, con.imageFile2, 2),
            ),
            GetBuilder<RestaurantProductsCreateController>(
              builder: (_) => _cardImage(context, con.imageFile3, 3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardImage(BuildContext context, File? imageFile, int numberFile) {
    final size = MediaQuery.of(context).size.width * 0.22;
    return GestureDetector(
      onTap: () => con.showAlertDialog(context, numberFile),
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: imageFile != null
            ? Image.file(imageFile, fit: BoxFit.cover)
            : Icon(
                Icons.add_a_photo_outlined,
                color: AppColors.muted,
                size: size * 0.35,
              ),
      ),
    );
  }

  Widget _buttonCreate(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => con.createProduct(context),
        icon: const Icon(Icons.add),
        label: const Text('CREAR PRODUCTO'),
      ),
    );
  }
}
