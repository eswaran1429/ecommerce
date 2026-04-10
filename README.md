# 🛍️ Flutter E-Commerce App

A modern Flutter e-commerce application built with **GetX**, **Hive**, and clean architecture principles.
This project demonstrates real-world features like product listing, wishlist, cart management, pagination, and unit testing.

---

## 🚀 Features

### 🛒 Product Module

* Fetch products from API
* Pagination (infinite scroll)
* Search with debounce
* Cached first-page data using Hive

### ❤️ Wishlist

* Add / remove products
* Instant UI update (Optimistic UI)
* Persistent storage using Hive

### 🛍️ Cart

* Add, remove, and update quantity
* Mock stock validation (max limit per product)
* Total price calculation
* Persistent cart using Hive

### ⚡ Performance

* Lazy loading using `Get.lazyPut`
* Efficient state management with GetX
* Local caching with Hive

---

## 🧠 Architecture

The app follows a **clean and scalable structure**:

```
lib/
│
├── core/            # Services (Hive, Dio)
├── models/          # Data models
├── repositories/    # Data handling (API + local)
├── modules/
│   ├── product/
│   ├── cart/
│   └── wishlist/
├── bindings/        # Dependency injection
├── routes/          # Navigation
```

---

## 🔧 Tech Stack

* **Flutter**
* **GetX** (State Management + Routing + DI)
* **Hive** (Local Database)
* **Dio** (API calls)

---

## 🧪 Unit Testing

Cart logic is fully unit tested:

✔ Add to cart
✔ Increment / decrement quantity
✔ Remove item
✔ Total price calculation
✔ Stock validation

Example:

```dart
test("Total price calculation", () {
  controller.addToCart(product);
  controller.addToCart(product);

  expect(controller.totalPrice, 200);
});
```

Run tests:

```bash
flutter test
```

---

## 📦 Installation

```bash
git clone https://github.com/your-username/ecommerce-app.git
cd ecommerce-app
flutter pub get
flutter run
```

---

## 📸 Screenshots

*(Add your app screenshots here)*

---

## 💡 Key Highlights

* Optimistic UI updates (instant feedback)
* Clean architecture for scalability
* Dependency injection using bindings
* Offline support with Hive caching
* Testable business logic

---

## 📌 Future Improvements

* Payment integration
* User authentication
* Order history
* Backend integration

---

## 👨‍💻 Author

**Your Name**
Flutter Developer

---

## ⭐ If you like this project

Give it a ⭐ on GitHub!
