# W3Cart Fashion Store

Aplikasi e-commerce fashion modern yang dibangun dengan **Flutter**, menampilkan pengalaman belanja online yang elegan dan responsif dengan dukungan tema gelap/terang.

## Fitur Utama

### Splash & Onboarding
- Animated splash screen dengan transisi halus
- Onboarding multi-halaman untuk pengguna baru

### Autentikasi
- **Login** — Form login dengan validasi
- **Register** — Pendaftaran akun baru
- **Forgot Password** — Permintaan reset password
- **OTP Verification** — Verifikasi kode OTP
- **Reset Password** — Input & konfirmasi password baru dengan navigasi ke login

### Home
- Carousel banner promo interaktif dengan auto-slide dan loop
- Kategori tab horizontal
- Section "Most Popular" dan "Trending Now" dengan navigasi ke halaman produk
- Sidebar navigation (App Drawer) dengan akses cepat ke semua halaman

### Products & Catalog
- Grid produk dengan tampilan card yang informatif
- Sistem filter yang lengkap:
  - **Sort By** — Recommended, Newest, Price, Rating
  - **Filter** — Price Range slider dengan badge harga, Size grid selector
  - **Brand** — Multi-select checkbox dengan counter
  - **Discount** — Pilihan diskon dengan icon informatif
- Filter chips dengan active state dan badge indikator

### Detail Produk
- Galeri gambar produk
- Pemilihan warna dengan indikator visual (border, check icon, glow)
- Pemilihan ukuran
- Informasi harga, rating, dan review
- Tombol "Add Cart" yang fungsional

### Search
- Halaman pencarian produk dengan field interaktif

### Categories
- Grid kategori lengkap dengan navigasi ke produk per kategori

### Wishlist
- Tampilan grid produk favorit
- Navigasi ke detail produk

### Cart
- Daftar produk di keranjang
- Widget cart item yang dapat dimodifikasi
- Ringkasan harga dan checkout

### Orders
- Riwayat pesanan pengguna
- Card order dengan status pesanan

### Coupons
- Daftar kupon yang tersedia untuk pengguna

### Profile
- Informasi pengguna dengan avatar
- Quick action buttons (Orders, Wishlist, Coupons, Help Center)
- Menu pengaturan:
  - Edit Profile
  - Saved Addresses (dengan tambah alamat baru)
  - Select Language — bottom sheet dari bawah
  - Notification Setting
  - Log Out

## Desain & UI/UX

- **Tema Gelap & Terang** — Toggle melalui sidebar, warna dan kontras otomatis menyesuaikan
- **Persistent Bottom Navigation** — IndexedStack untuk navigasi tanpa reload
- **Floating Action Button** — Tombol cart di tengah bottom navigation
- **Bottom Sheet Konsisten** — Semua popup (filter, sort, brand, discount, bahasa) muncul dari bawah
- **Modern Color Scheme** — Background `#F5F6FA` dengan card putih untuk kontras visual
- **Typography** — Google Fonts Plus Jakarta Sans (konsisten di seluruh aplikasi)
- **Animasi** — Smooth transitions pada filter, color selector, dan carousel

## Arsitektur Proyek

```
lib/
├── core/
│   ├── models/
│   │   └── product_model.dart          # Model data produk
│   ├── theme/
│   │   ├── app_colors.dart             # Konstanta warna light & dark
│   │   └── app_theme.dart              # ThemeData light & dark (Plus Jakarta Sans)
│   └── widgets/
│       ├── custom_text_field.dart      # TextField reusable
│       ├── page_transition.dart        # Animasi transisi antar halaman
│       └── rounded_hexagon_border.dart # Custom border hexagon
│
├── features/
│   ├── auth/
│   │   └── screens/
│   │       ├── login_screen.dart           # Halaman login
│   │       ├── register_screen.dart        # Halaman registrasi
│   │       ├── forgot_password_screen.dart # Halaman lupa password
│   │       ├── otp_screen.dart             # Halaman verifikasi OTP
│   │       └── reset_password_screen.dart  # Halaman reset password
│   │
│   ├── cart/
│   │   ├── screens/
│   │   │   └── cart_screen.dart            # Halaman keranjang belanja
│   │   └── widgets/
│   │       └── cart_item_widget.dart       # Widget item keranjang
│   │
│   ├── categories/
│   │   ├── models/
│   │   │   └── category_model.dart         # Model data kategori
│   │   ├── screens/
│   │   │   └── categories_screen.dart      # Halaman grid kategori
│   │   └── widgets/
│   │       └── category_card_widget.dart   # Widget card kategori
│   │
│   ├── coupons/
│   │   └── screens/
│   │       └── coupons_screen.dart         # Halaman daftar kupon
│   │
│   ├── home/
│   │   ├── screens/
│   │   │   ├── home_screen.dart            # Halaman utama
│   │   │   └── product_detail_screen.dart  # Halaman detail produk
│   │   └── widgets/
│   │       ├── app_drawer.dart             # Sidebar navigasi
│   │       ├── category_tabs_widget.dart   # Tab kategori horizontal
│   │       ├── color_selector_widget.dart  # Selector warna produk
│   │       ├── product_card_widget.dart    # Card produk home
│   │       ├── promo_banner_widget.dart    # Banner promo carousel
│   │       ├── size_selector_widget.dart   # Selector ukuran produk
│   │       ├── trending_card_widget.dart   # Card trending produk
│   │       └── trending_carousel_widget.dart # Carousel trending
│   │
│   ├── onboarding/
│   │   └── screens/
│   │       └── onboarding_screen.dart      # Halaman onboarding
│   │
│   ├── orders/
│   │   ├── models/
│   │   │   └── order_model.dart            # Model data pesanan
│   │   ├── screens/
│   │   │   └── orders_screen.dart          # Halaman riwayat pesanan
│   │   └── widgets/
│   │       └── order_card_widget.dart      # Widget card pesanan
│   │
│   ├── products/
│   │   ├── screens/
│   │   │   └── products_screen.dart        # Halaman katalog & filter produk
│   │   └── widgets/
│   │       └── catalog_product_card.dart   # Card produk katalog
│   │
│   ├── profile/
│   │   ├── address_model.dart              # Model data alamat
│   │   └── screens/
│   │       ├── profile_screen.dart         # Halaman profil utama
│   │       ├── edit_profile.dart           # Halaman edit profil
│   │       ├── saved_addresses.dart        # Halaman daftar alamat tersimpan
│   │       └── add_address.dart            # Halaman tambah alamat baru
│   │
│   ├── search/
│   │   └── screens/
│   │       └── search_screen.dart          # Halaman pencarian produk
│   │
│   └── wishlist/
│       └── screens/
│           └── wishlist_screen.dart        # Halaman daftar wishlist
│
├── screens/
│   ├── main_screen.dart                    # Shell navigasi utama (BottomNav)
│   └── splash_screen.dart                  # Halaman splash awal
│
└── main.dart                               # Entry point aplikasi
```

## Tech Stack

| Teknologi | Keterangan |
|-----------|------------|
| **Flutter** | Framework UI cross-platform |
| **Dart** | Bahasa pemrograman |
| **Google Fonts** | Plus Jakarta Sans typography |
| **Material 3** | Design system |

## Cara Menjalankan

```bash
# Clone repository
git clone https://github.com/Aldikurniawan19/responsiKel6.git

# Masuk ke direktori proyek
cd responsiKel6

# Install dependencies
flutter pub get

# Jalankan dalam mode debug
flutter run

# Build APK release
flutter build apk
```

## Persyaratan

- Flutter SDK `^3.11.0`
- Dart SDK `^3.11.0`
- Android SDK (untuk build Android)

## Tim Pengembang

**Kelompok 6** — Responsi Aplikasi Perangkat Bergerak & Praktik

| NIM | Nama | GitHub |
|-----|------|--------|
| 5230311013 | Aldi Kurniawan | [![GitHub](https://img.shields.io/badge/-GitHub-181717?logo=github&logoColor=white)](https://github.com/Aldikurniawan19) |
| 5230311043 | Wimbo Sedayu | [![GitHub](https://img.shields.io/badge/-GitHub-181717?logo=github&logoColor=white)](https://github.com/wimbo17) |
| 5230311053 | Muhammad Vito Pratama | [![GitHub](https://img.shields.io/badge/-GitHub-181717?logo=github&logoColor=white)](https://github.com/JustV0402) |
| 5230311069 | Imsida Oktavia Putri Nabilah | [![GitHub](https://img.shields.io/badge/-GitHub-181717?logo=github&logoColor=white)](https://github.com/nabila1370) |
| 5230311072 | Lailatul Mukaromah | [![GitHub](https://img.shields.io/badge/-GitHub-181717?logo=github&logoColor=white)](https://github.com/latulmkrmh) |

## Lisensi

Proyek ini dibuat untuk keperluan akademik.

---

> **W3Cart Fashion Store** — *Your Style, Your Way* 

