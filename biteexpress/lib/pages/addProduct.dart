import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/addProductsProvider.dart';

class addProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: MaterialApp(
        theme: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(color: Color.fromARGB(255, 255, 102, 0)),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 255, 102, 0),
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 255, 102, 0),
              ),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 255, 102, 0),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 255, 102, 0),
            ),
          ),
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Add Product'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Consumer<ProductProvider>(
              builder: (context, provider, child) {
                return Form(
                  child: ListView(
                    children: <Widget>[
                      TextFormField(
                        controller: provider.titleController,
                        decoration: const InputDecoration(labelText: 'Title'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: provider.descriptionController,
                        decoration:
                            const InputDecoration(labelText: 'Description'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                      DropdownButtonFormField<String>(
                        decoration:
                            const InputDecoration(labelText: 'Category'),
                        value: provider.selectedCategory,
                        items: provider.categories.map((category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (value) {
                          provider.setCategory(value);
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a category';
                          }
                          return null;
                        },
                      ),
                      if (provider.selectedCategory != null)
                        DropdownButtonFormField<String>(
                          decoration:
                              const InputDecoration(labelText: 'Subcategory'),
                          value: provider.selectedSubcategory,
                          items: provider.subcategories?.map((subcategory) {
                            return DropdownMenuItem(
                              value: subcategory,
                              child: Text(subcategory),
                            );
                          }).toList(),
                          onChanged: (value) {
                            provider.setSubcategory(value);
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a subcategory';
                            }
                            return null;
                          },
                        ),
                      TextFormField(
                        controller: provider.priceController,
                        decoration: const InputDecoration(labelText: 'Price'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a price';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextButton.icon(
                        icon: const Icon(Icons.image),
                        label: const Text('Upload Image'),
                        onPressed: () => provider.pickImage(),
                      ),
                      if (provider.selectedImage != null)
                        Image.file(
                          provider.selectedImage!,
                          height: 150,
                        ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (provider.validateForm()) {
                            final product = provider.createProduct();
                            // Handle the product data (e.g., save to a database or navigate to another screen)
                          } else {
                            // Show validation error
                          }
                        },
                        child: const Text(
                          'Add',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
