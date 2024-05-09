// mock_data.dart

// All product categories and subcategories.

// Bakeries & Pastries:
// Bread, Pastries, Cakes, Cookies, Muffins

// Fruits & Vegetables:
// Fresh Fruits, Fresh Vegetables, Organic Produce, Exotic Fruits, Salad Greens

// Cold Cuts & Deli:
// Lunchon, Salami, Ham, Cheese, Olives, Pickles

// Dairy & Eggs:
// Eggs, Cheese, Butter, Cream, Yoghurts, Labneh

// Ready to Eat:
// Sandwiches, Salads, Sushi, Wraps, Pre-made Meals

// Milk:
// Milk, Powdered Milk, Flavored Milk, Organic Milk

// Ice Cream:
// Bars, Cones, Sticks, Cups, Tups, Family Packs

// Meat, Poultry & Seafood:
// Beef, Chicken, Pork, Fish, Shellfish

// Frozen:
// Frozen Vegetables, Frozen Fruits, Frozen Meals, Ice Cream, Frozen Pizza

// Snacks:
// Chips, Crackers, Popcorn, Nuts, Granola Bars

// Beverages:
// Water, Soda, Juice, Coffee, Tea

// Canned & Jarred:
// Canned Seafood, Canned Vegetables, Fava Beans

// Cooking & Baking:
// Baking Ingredients, Frying Oil, Olive Oil, Ghee, Sugar & Sweeteners, Pastas, Grains

// Condiments:
// Salad Dressing & Viniger, Sauces, Spices & Seasonings, Salt

// Breakfast Food:
// Cereals, Spreads, Halawa, Pancake Mix, Syrup, Honey

// final Map<String, dynamic> users = {
//   "userId1": {
//     "firstName": "Alice",
//     "lastName": "Smith",
//     "hashedPass": "hashed_password_here",
//     "salt": "salt_value_here",
//     "pic": "profile_picture_url_here",
//     "userType": "customer",
//     "isVerified": true,
//     "orders": [
//       {
//         "orderId": "orderId1",
//         "numberOfProducts": 2,
//         "products": [
//           {"productId": "productId1", "quantity": 1},
//           {"productId": "productId2", "quantity": 1}
//         ]
//       }
//     ]
//   },
//   "userId2": {
//     "firstName": "Bob",
//     "lastName": "Johnson",
//     "hashedPass": "hashed_password_here",
//     "salt": "salt_value_here",
//     "pic": "profile_picture_url_here",
//     "userType": "vendor",
//     "isVerified": true,
//     "orders": []
//   }
// };

final Map<String, dynamic> products = {
  "productId1": {
    "title": "Lion Chips",
    "description": "Delicious crunchy chips perfect for snacking.",
    "category": "Snacks",
    "subCategory": "Chips",
    "price": "2.99",
    "createdVendor": "Vendor1",
    "image": "product.png",
    "ratings": {"userId1": 4, "userId2": 5},
    "comments": {
      "commentId1": {
        "userId": "userId1",
        "comment": "Great taste!",
        "firstName": "Alice",
        "lastName": "Smith"
      },
      "commentId2": {
        "userId": "userId2",
        "comment": "Love these chips!",
        "firstName": "Bob",
        "lastName": "Johnson"
      }
    }
  },
  "productId2": {
    "title": "Organic Apples spliced with banana genes",
    "description":
        "Fresh, organic apples bursting with flavor. And this time we are creating a special long description to test the text overflow feature of the app.",
    "category": "Fruits & Vegetables",
    "subCategory": "Fresh Fruits",
    "price": "3.99",
    "createdVendor": "Vendor2",
    "image": "product.png",
    "ratings": {},
    "comments": {}
  },
  "productId3": {
    "title": "Whole Grain Bread",
    "description": "Nutritious whole grain bread, perfect for sandwiches.",
    "category": "Bakeries & Pastries",
    "subCategory": "Bread",
    "price": "4.99",
    "createdVendor": "Vendor3",
    "image": "product.png",
    "ratings": {"userId1": 5},
    "comments": {
      "commentId1": {
        "userId": "userId2",
        "comment": "Love this bread!",
        "firstName": "Bob",
        "lastName": "Johnson"
      }
    }
  },
  "productId4": {
    "title": "Fresh Salmon Fillet",
    "description":
        "High-quality fresh salmon fillet, perfect for grilling or baking.",
    "category": "Meat, Poultry & Seafood",
    "subCategory": "Fish",
    "price": "9.99",
    "createdVendor": "Vendor4",
    "image": "product.png",
    "ratings": {"userId2": 4},
    "comments": {}
  },
  "productId5": {
    "title": "Classic Chocolate Chip Cookies",
    "description":
        "Delicious homemade chocolate chip cookies, a timeless favorite.",
    "category": "Bakeries & Pastries",
    "subCategory": "Cookies",
    "price": "5.99",
    "createdVendor": "Vendor5",
    "image": "product.png",
    "ratings": {"userId1": 5, "userId3": 4},
    "comments": {
      "commentId1": {
        "userId": "userId3",
        "comment": "These cookies are amazing!",
        "firstName": "Emily",
        "lastName": "Brown"
      },
      "commentId2": {
        "userId": "userId1",
        "comment": "I love these cookies!",
        "firstName": "Alice",
        "lastName": "Smith"
      }
    }
  },
  "productId6": {
    "title": "Fresh Strawberries",
    "description": "Juicy, ripe strawberries bursting with sweetness.",
    "category": "Fruits & Vegetables",
    "subCategory": "Fresh Fruits",
    "price": "6.99",
    "createdVendor": "Vendor6",
    "image": "product.png",
    "ratings": {"userId3": 5},
    "comments": {
      "commentId1": {
        "userId": "userId1",
        "comment": "These strawberries are delicious!",
        "firstName": "Alice",
        "lastName": "Smith",
      },
      "commentId2": {
        "userId": "userId3",
        "comment": "I love these strawberries!",
        "firstName": "Emily",
        "lastName": "Brown",
      }
    }
  },
  "productId7": {
    "title": "Vanilla Ice Cream",
    "description": "Creamy vanilla ice cream, perfect for dessert.",
    "category": "Ice Cream",
    "subCategory": "Cups",
    "price": "3.99",
    "createdVendor": "Vendor7",
    "image": "product.png",
    "ratings": {"userId2": 5},
    "comments": {
      "commentId1": {
        "userId": "userId2",
        "comment": "This ice cream is delicious!",
        "firstName": "Bob",
        "lastName": "Johnson"
      }
    }
  },
  "productId8": {
    "title": "Fresh Spinach",
    "description": "Crisp, fresh spinach leaves, perfect for salads.",
    "category": "Fruits & Vegetables",
    "subCategory": "Salad Greens",
    "price": "2.99",
    "createdVendor": "Vendor8",
    "image": "product.png",
    "ratings": {},
    "comments": {}
  },
  "productId9": {
    "title": "Iced Coffee",
    "description": "Refreshing iced coffee, perfect for a hot day.",
    "category": "Beverages",
    "subCategory": "Coffee",
    "price": "4.99",
    "createdVendor": "Vendor9",
    "image": "product.png",
    "ratings": {"userId3": 4},
    "comments": {
      "commentId1": {
        "userId": "userId3",
        "comment": "This coffee is delicious!",
        "firstName": "Emily",
        "lastName": "Brown"
      }
    }
  },
  "productId10": {
    "title": "Frozen Pizza",
    "description": "Delicious frozen pizza, perfect for a quick meal.",
    "category": "Frozen",
    "subCategory": "Frozen Pizza",
    "price": "7.99",
    "createdVendor": "Vendor10",
    "image": "product.png",
    "ratings": {"userId1": 4},
    "comments": {
      "commentId1": {
        "userId": "userId1",
        "comment": "This pizza is great!",
        "firstName": "Alice",
        "lastName": "Smith"
      }
    }
  },
  "productId11": {
    "title": "Fresh Oranges",
    "description": "Juicy, ripe oranges bursting with flavor.",
    "category": "Fruits & Vegetables",
    "subCategory": "Fresh Fruits",
    "price": "4.99",
    "createdVendor": "Vendor11",
    "image": "product.png",
    "ratings": {"userId1": 5},
    "comments": {
      "commentId1": {
        "userId": "userId1",
        "comment": "These oranges are delicious!",
        "firstName": "Alice",
        "lastName": "Smith",
      },
      "commentId2": {
        "userId": "userId3",
        "comment": "I love these oranges!",
        "firstName": "Emily",
        "lastName": "Brown",
      }
    }
  },
  "productId12": {
    "title": "Fresh Broccoli",
    "description": "Crunchy and nutritious broccoli florets.",
    "category": "Fruits & Vegetables",
    "subCategory": "Fresh Vegetables",
    "price": "2.49",
    "createdVendor": "Vendor12",
    "image": "product.png",
    "ratings": {},
    "comments": {}
  },
  "productId13": {
    "title": "Organic Strawberries",
    "description": "Organic and sweet strawberries.",
    "category": "Fruits & Vegetables",
    "subCategory": "Organic Produce",
    "price": "5.99",
    "createdVendor": "Vendor13",
    "image": "product.png",
    "ratings": {},
    "comments": {}
  },
  "productId14": {
    "title": "Fresh Pineapple",
    "description":
        "Juicy and tropical pineapple, perfect for snacking or desserts.",
    "category": "Fruits & Vegetables",
    "subCategory": "Salad Greens",
    "price": "3.99",
    "createdVendor": "Vendor14",
    "image": "product.png",
    "ratings": {},
    "comments": {}
  },
  "productId15": {
    "title": "Organic Kale",
    "description":
        "Nutritious and leafy organic kale, great for salads or smoothies.",
    "category": "Fruits & Vegetables",
    "subCategory": "Exotic Fruits",
    "price": "2.99",
    "createdVendor": "Vendor15",
    "image": "product.png",
    "ratings": {},
    "comments": {}
  },
  "productId16": {
    "title": "Fresh Avocado",
    "description":
        "Creamy and nutritious avocado, perfect for salads or guacamole.",
    "category": "Fruits & Vegetables",
    "subCategory": "Fresh Vegetables",
    "price": "1.99",
    "createdVendor": "Vendor16",
    "image": "product.png",
    "ratings": {},
    "comments": {}
  },
  "productId17": {
    "title": "Fresh Bananas",
    "description": "Sweet and nutritious bananas, perfect for snacking.",
    "category": "Fruits & Vegetables",
    "subCategory": "Fresh Fruits",
    "price": "0.99",
    "createdVendor": "Vendor17",
    "image": "product.png",
    "ratings": {},
    "comments": {}
  },
  "productId18": {
    "title": "Fresh Mango",
    "description":
        "Juicy and tropical mango, perfect for snacking or smoothies.",
    "category": "Fruits & Vegetables",
    "subCategory": "Exotic Fruits",
    "price": "2.99",
    "createdVendor": "Vendor18",
    "image": "product.png",
    "ratings": {},
    "comments": {}
  },
  "productId19": {
    "title": "Organic Blueberries",
    "description": "Sweet and antioxidant-rich blueberries.",
    "category": "Fruits & Vegetables",
    "subCategory": "Fresh Fruits",
    "price": "3.99",
    "createdVendor": "Vendor19",
    "image": "product.png",
    "ratings": {},
    "comments": {}
  },
  "productId20": {
    "title": "Fresh Bell Peppers",
    "description":
        "Crisp and colorful bell peppers, perfect for salads or stir-fries.",
    "category": "Fruits & Vegetables",
    "subCategory": "Fresh Vegetables",
    "price": "1.49",
    "createdVendor": "Vendor20",
    "image": "product.png",
    "ratings": {},
    "comments": {}
  }
};
