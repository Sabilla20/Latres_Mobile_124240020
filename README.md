# Latres_Mobile_[NIM]

Aplikasi nonton series/show TV (API publik [TVMaze](https://www.tvmaze.com/api)) - Latihan Responsi Praktikum Mobile SI-F.

## Fitur
- Login (username = NIM, password = `123`), session di **SharedPreferences**, logout menghapus session
- Home: grid show (gambar, judul, rating), loading indicator, BottomNavigationBar (Beranda / Favorit / Profil)
- Detail: data dari `/shows/{id}` (gambar, judul, rating, genre, overview), tombol favorit
- Favorit: disimpan di **Hive**, bisa dihapus, tap untuk ke detail
- Profil: username dari SharedPreferences, kesan & pesan, tombol logout
- State management **GetX**

## Struktur
```
lib/
  core/constants.dart            <- ganti NIM, kesan, pesan di sini
  data/models/show.dart
  data/services/tvmaze_service.dart   (fetch & parse API, terpisah dari UI)
  controllers/                   (auth, home, detail, favorite)
  views/                         (login, main, home, detail, favorite, profile)
  main.dart
```

## Cara menjalankan
1. Edit `lib/core/constants.dart`: isi `kNim`, `kKesan`, `kPesan`.
2. Di folder project, buat folder platform (android/ios) lalu ambil dependency:
   ```
   flutter create . --project-name latres_mobile
   flutter pub get
   flutter run
   ```
3. Untuk build release Android, pastikan `android/app/src/main/AndroidManifest.xml` memiliki:
   `<uses-permission android:name="android.permission.INTERNET"/>`
