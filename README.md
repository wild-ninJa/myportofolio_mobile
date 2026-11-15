# myportofolio_mobile

## Tugas 7
1. Jelaskan apa yang dimaksud dengan widget tree pada Flutter dan bagaimana hubungan induk-anak (parent-child) bekerja antar-widget!
> Widget tree merupakan struktur tree dari widget yang nested dan mendeskrupsikan UI.
> Parent itu yang membungkus, Child yang dibungkus. Parent memberi constraints ke child, child memilih ukuran di dalamnya, lalu parent menentukan posisinya.

2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya masing-masing!
> In main.dart: MyApp (StatelessWidget): root aplikasi, MaterialApp: kerangka aplikasi berbentuk Material (judul, tema, halaman awal home)
> In menu.dart, struktur halaman:
    - MyHomePage (StatelessWidget): halaman utama.
    - Scaffold: kerangka dasar halaman (appBar + body).
    - AppBar: bar judul di atas (“MyPortfolio”).
    - Padding: memberi jarak 16 di sekeliling isi body.
    - Column: menyusun anak secara vertikal.
    - Row: menyusun tiga InfoCard secara horizontal, dengan spaceEvenly.
    - SizedBox: spasi kosong antar-elemen.
    - Center: menengahkan teks “Welcome to MyPortfolio”.
    - Text: menampilkan teks (judul, isi kartu, nama menu).
    - GridView.count: grid 3 kolom untuk tombol menu. shrinkWrap: true membuat tingginya menyesuaikan isi.
> In menu.dart, custom widget:
    - InfoCard (StatelessWidget): kartu info (NPM, Nama, Kelas).
    - ItemCard (StatelessWidget): kartu menu yang bisa ditekan.
> Inside InfoCard dan ItemCard
    - Card: kartu dengan bayangan (elevation).
    - Container: kotak untuk mengatur lebar dan padding.
    - Material: permukaan berwarna dengan sudut membulat; dibutuhkan agar efek ripple InkWell terlihat.
    - InkWell: mendeteksi tap dan memberi efek ripple (onTap).
    - Icon: menampilkan ikon menu.
    - SnackBar: pesan singkat di bawah layar saat kartu ditekan.

3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini umumnya digunakan sebagai root widget pada aplikasi Flutter!
> Fungsi MaterialApp adalah widget pembungkus yang menyiapkan semua yang dibutuhkan aplikasi bergaya Material Design.
> Widget ini umum digunakan sebagai root widget pada aplikasi flutter karena berada di puncak pohon, sehingga semua yang ada di bawahnya (tema, navigator, ukuran layar) otomatis bisa diakses lewat BuildContext; Widget Material butuh ancestor-nya. Scaffold, AppBar, Card, InkWell, dan SnackBar mengandalkan tema dan komponen yang disediakan MaterialApp; Tema dan routing cukup diatur sekali, tidak per halaman; Lebih efisien, tidak perlu mengatur sendiri hal-hal dasar seperti navigasi dan lokalisasi.

4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget! Kapan kita sebaiknya memilih StatelessWidget dan kapan harus menggunakan StatefulWidget?
> Stateless Widget: Tidak punya state yang berubah; tampilannya hanya ditentukan oleh data yang diberikan lewat konstruktor, Hanya punya method build(). UI baru berubah kalau parent membangun ulang dengan data baru.
> Stateful Widget: Punya state yang bisa berubah selama aplikasi berjalan, disimpan di class State terpisah, Memanggil setState() memicu build() ulang, sehingga UI ikut berubah., Punya siklus hidup, initState(), build(), dispose(), dst.
> Memilih Stateless Widget ketika: UI statis atau hanya bergantung pada data dari parent. Contoh: MyHomePage, InfoCard, ItemCard.
> Memilih Stateful Widget ketika: UI berubah karena interaksi atau waktu. Contoh: counter, form input, checkbox, toggle, animasi, data yang di-fetch.

5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di dalam metode build?
> BuildContext adalah objek yang merepresentasikan posisi sebuah widget di dalam widget tree. Lewat context, widget bisa “melihat ke atas” untuk mencari widget leluhur (ancestor).
> Kenapa penting: Widget tidak tahu apa-apa tentang pohon di sekitarnya, kecuali lewat context. Juga memungkinkan akses ke data global seperti tema, ukuran layar, navigator, dan ScaffoldMessenger, tanpa harus mengoper data lewat setiap konstruktor. Lalu setiap widget punya context sendiri, jadi hasil pencarian bergantung pada posisinya di pohon.
> Penggunaan: Flutter memberikan context ke method build, lalu mengikuti pola X.of(context). Contoh:
    <!-- // Mengambil warna dari tema (dari MaterialApp) -->
    backgroundColor: Theme.of(context).colorScheme.primary,

    <!-- // Mengambil lebar layar -->
    width: MediaQuery.of(context).size.width / 3.5,

    <!-- // Menampilkan SnackBar lewat ScaffoldMessenger -->
    ScaffoldMessenger.of(context).showSnackBar(...);

6. Jelaskan konsep hot reload di Flutter dan apa perbedaannya dengan hot restart! Kapan kita tidak bisa hanya mengandalkan hot reload dan harus melakukan hot restart atau full restart?
> Hot reload menyuntikkan kode yang berubah ke Dart VM yang sedang berjalan, lalu membangun ulang widget tree. State aplikasi tetap dipertahankan, dan prosesnya biasanya di bawah satu detik.
> Hot restart memuat ulang seluruh kode dan menjalankan aplikasi dari awal (main() dipanggil lagi). State hilang dan kembali ke nilai awal, tapi tetap lebih cepat daripada full restart.
> Kapan hot reload tidak cukup, perlu hot restart:
    - Mengubah nilai awal variabel static, global, atau field final yang diinisialisasi sekali, misalnya npm, nama, atau isi items di menu.dart.
    - Mengubah isi initState() atau main(), karena hanya berjalan sekali.
    - Mengubah tipe widget dari StatelessWidget ke StatefulWidget atau sebaliknya.
    - Mengubah enum menjadi class biasa, atau mengubah tipe generik.
    - State terlanjur kacau setelah banyak perubahan.
> Perlu full restart (stop lalu run ulang): 
    - Menambah atau mengubah dependency di pubspec.yaml.
    - Mengubah kode native (Android/iOS), izin (AndroidManifest.xml, Info.plist), atau konfigurasi Gradle/Xcode.
    - Menambah aset baru, font, atau plugin

AI disclosure Tuga 7:
Link: https://claude.ai/share/d2b85702-2cd7-4b10-a376-ecbd28886ac2
Saya menggunakan AI untuk membantu saya mendebug error, menjelaskan bagian yang saya tidak mengerti, serta mempelajari materi untuk menjawab pertanyaan refleksi. Tentu, apa yang diberi AI ini terbatas sehingga masih perlu recheck materi pada web PBP.