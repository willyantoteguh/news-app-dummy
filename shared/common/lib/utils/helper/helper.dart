import 'dart:developer';

import 'package:flutter/material.dart';

void onSelectToFetchData(
  BuildContext context,
  String selectedCategory,
  Future Function(BuildContext context) getOlahraga,
  Future Function(BuildContext context) getBisnis,
  Future Function(BuildContext context) getHiburan,
  Future Function(BuildContext context) getKesehatan,
  Future Function(BuildContext context) getSemua,
) {
  if (selectedCategory == 'Olahraga') {
    getOlahraga;
  } else if (selectedCategory == 'Bisnis') {
    getBisnis;
  } else if (selectedCategory == 'Hiburan') {
    getHiburan;
  } else if (selectedCategory == 'Kesehatan') {
    getKesehatan;
  } else {
    getSemua;
  }
}

void selectCategory(String title, String selectedCategory, setState) {
  if (selectedCategory.contains(title)) {
    setState(() {
      selectedCategory = '';
      log(selectedCategory);
    });
  } else {
    setState(() {
      selectedCategory = title;
      log(selectedCategory);
    });
  }
}
