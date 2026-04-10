# 🛍️ HotDiee Fashion Store

Aplikasi e-commerce fashion modern yang dibangun dengan **Flutter**, menampilkan pengalaman belanja online yang elegan dan responsif dengan dukungan tema gelap/terang.

## 📱 Fitur Utama

### 🏠 Home
- Carousel banner promo interaktif dengan auto-slide dan loop
- Kategori tab horizontal
- Section "Most Popular" dan "Trending Now" dengan navigasi ke halaman produk
- Sidebar navigation dengan akses cepat ke semua halaman

### 🛒 Products & Catalog
- Grid produk dengan tampilan card yang informatif
- Sistem filter yang lengkap:
  - **Sort By** — Recommended, Newest, Price, Rating
  - **Filter** — Price Range slider dengan badge harga, Size grid selector
  - **Brand** — Multi-select checkbox dengan counter
  - **Discount** — Pilihan diskon dengan icon informatif
- Filter chips dengan active state dan badge indikator

### ❤️ Wishlist
- Tampilan grid produk favorit
- Navigasi ke detail produk

### 👤 Profile
- Informasi pengguna dengan avatar
- Quick action buttons (Orders, Voucher, Wishlist, Review)
- Menu pengaturan (Account, Notification, Address, Payment, Security, Privacy)

### 🛍️ Cart
- Daftar produk di keranjang
- Ringkasan harga dan checkout

### 🔍 Search
- Halaman pencarian produk

### 📋 Categories
- Grid kategori lengkap dengan navigasi ke produk per kategori

### 📦 Detail Produk
- Galeri gambar produk
- Pemilihan warna dengan indikator visual (border, check icon, glow)
- Pemilihan ukuran
- Informasi harga, rating, dan review
- Tombol "Add Cart" yang fungsional

## 🎨 Desain & UI/UX

- **Tema Gelap & Terang** — Toggle melalui sidebar, warna dan kontras otomatis menyesuaikan
- **Persistent Bottom Navigation** — IndexedStack untuk navigasi tanpa reload
- **Floating Action Button** — Tombol cart di tengah bottom navigation
- **Modern Color Scheme** — Background `#F5F6FA` dengan card putih untuk kontras visual
- **Typography** — Google Fonts Plus Jakarta Sans
- **Animasi** — Smooth transitions pada filter, color selector, dan carousel

## 🏗️ Arsitektur Proyek

```
lib/
├── core/
│   ├── models/          # Model data (Product)
│   ├── theme/           # AppColors, AppTheme
│   └── widgets/         # Widget reusable (RoundedHexagonBorder, CustomTextField)
├── features/
│   ├── auth/            # Login & Register
│   ├── cart/            # Keranjang belanja
│   ├── categories/      # Halaman kategori
│   ├── home/            # Home screen, product detail, widgets
│   ├── onboarding/      # Onboarding screen
│   ├── products/        # Catalog produk & filter
│   ├── profile/         # Profil pengguna
│   ├── search/          # Pencarian
│   └── wishlist/        # Daftar favorit
├── screens/
│   └── main_screen.dart # Shell navigasi utama
└── main.dart            # Entry point
```

## 🛠️ Tech Stack

| Teknologi | Keterangan |
|-----------|------------|
| **Flutter** | Framework UI cross-platform |
| **Dart** | Bahasa pemrograman |
| **Google Fonts** | Plus Jakarta Sans typography |
| **Material 3** | Design system |

## 🚀 Cara Menjalankan

```bash
# Clone repository
git clone https://github.com/Aldikurniawan19/responsiKel6.git

# Masuk ke direktori proyek
cd hotdie

# Install dependencies
flutter pub get

# Jalankan dalam mode debug
flutter run

# Build APK release
flutter build apk
```

## 📌 Persyaratan

- Flutter SDK `^3.11.0`
- Dart SDK `^3.11.0`
- Android SDK (untuk build Android)

## 👥 Tim Pengembang

**Kelompok 6** — Responsi Aplikasi Perangkat Bergerak & Paraktik

## 📄 Lisensi

Proyek ini dibuat untuk keperluan akademik.

---

> **HotDiee Fashion Store** — *Your Style, Your Way* 🔥
