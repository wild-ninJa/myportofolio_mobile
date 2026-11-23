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

### Tugas 8
1. Jelaskan perbedaan antara Navigator.push(), Navigator.pushReplacement(), dan Navigator.pop(). Metode apa yang digunakan untuk membuka formulir dari kartu aksi? Jelaskan juga bagaimana opsi Home di drawer membawa pengguna kembali ke halaman utama.
> Navigator.push() menambah halaman baru di atas tumpukan (stack), Navigator.pushReplacement() mengganti halaman teratas dengan halaman baru, dan Navigator.pop() menghapus halaman teratas untuk kembali ke halaman sebelumnya.
> Metode yang digunakan untuk membuka formuril dari kartu aksi adalah Navigator.push()
> Saat Home ditekan, pushReplacement membuang halaman form dari stack dan menggantinya dengan halaman utama. Hasilnya, tombol kembali tidak lagi membawa ke form, dan stack tidak menumpuk setiap kali berpindah lewat drawer.
 
2. Bagaimana susunan Scaffold, AppBar, dan Drawer membantu menjaga struktur halaman tetap konsisten? Berikan satu contoh penggunaan warna tema portofolio di lebih dari satu halaman.
> Scaffold, Appbar, dan Drawer bekerja sebagai satu kerangka halaman. Scaffold menyediakan slot tetap, AppBar mengisi slot atas, dan Drawer mengisi slot samping. Kalau semua halaman mengisi slot yang sama dengan isi yang sama, tampilannya otomatis seragam.
> Scaffold sebagai kerangka utama, appbar menjadi identitas dan navigasi, Drawer menyediakan banyak halaman dalam satu menu.
> Contohnya warna dasar save button -> 0xFF29B6F6 dipakai di glossy_button.dart yang dipakai di kedua form add project dan add experience
3. Mengapa tata letak tersebut dipilih untuk formulir? Jelaskan peran widget pengatur jarak dan widget penggulir ketika ruang layar terbatas.
> Memilih column di dalam form, karena Input formulir bersifat berurutan, jadi susunan vertikal paling alami untuk dibaca dan diisi, crossAxisAlignment: stretch membuat semua input selebar kartu, sehingga rapi dan mudah ditekan, Form dengan GlobalKey menjadi pembungkus yang bisa memvalidasi semua TextFormField di dalamnya sekaligus lewat validate().
> Padding memberi jarak 8 px atas-bawah tiap input. Jadi jarak ditulis sekali di satu fungsi, bukan di setiap input; SizedBox(height: 8) yaitu spasi kosong sebelum tombol Simpan, supaya tombol tidak menempel ke input terakhir; EdgeInsets.fromLTRB(16, 72, 16, 24) merupakan jarak dari tepi layar. Angka 72 di atas dipakai karena extendBodyBehindAppBar: true membuat isi halaman naik ke bawah AppBar. Tanpa padding itu, input pertama tertutup AppBar; SafeArea menjaga isi tidak tertutup notch, status bar, atau tepi layar yang melengkung.
> Peran widget penggulir (SingleChildScrollView): SingleChildScrollView membuat isi bisa digulir, sehingga semua input dan tombol tetap bisa dicapai pada layar terbatas atau saat papan ketik tampil.

4. Apa peran GlobalKey<FormState>, validator, dan validate() saat tombol Simpan ditekan? Berikan satu contoh nilai yang ditolak oleh validasi dan jelaskan mengapa memilih jenis input atau papan ketik saja belum cukup.
> GlobalKey<FormState> sebagai pemegang ke form. Form menyimpan state-nya sendiri (daftar semua TextFormField di dalamnya). GlobalKey adalah "remote control" supaya kode kita di luar Form, misalnya di _save bisa mengaksesnya. Tanpa key, save button tidak punya cara untuk menyuruh form memeriksa isinya.
> Validasi sebagai aturan per kolom. Fungsi kecil di tiap TextFormField. Ia menerima isi kolom, lalu mengembalikan null jika valid, String jika tidak valid, dan string itu muncul sebagai pesan merah di bawah kolom.
> validate() menjalankan semuanya sekaligus, memanggil semua validator di form, hasilnya true jika semuanya mengembalikan null, dn false jika ada setidaknya satu yang error. Kolom yang gagal juga otomatis mengirimkan error message.
> Contoh nilai yang ditolah oleh validasi: Judul "       ", akan menjadi kosong karena trim(), atau judul yang melebihi 256 karakter, atau thumbnail diisi "abc" semua contho tersebut akan ditolah oleh validasi masing-masing validator.
> Memilih jenis input atau papan ketik saja tentu belum cukup, karena keyboardType (misalnya TextInputType.url) hanya mengubah tampilan papan ketik, tidak membatasi apa yang masuk ke kolom. Begitu juga dropdown dan date picker: keduanya membatasi pilihan, tetapi tidak menjamin semua kolom wajib terisi atau urutan tanggalnya benar. adi papan ketik dan jenis input itu kenyamanan (membantu pengguna mengetik), sedangkan validasi itu penjaga aturan (menolak data yang salah).

AI Disclosure Tugas 8 {
    log: https://claude.ai/share/32004409-f85d-4ce2-b5d4-31d8ced99669
    Penjelasan: Saya menggunakan AI untuk membantu saya guide untuk mengerjakan hal yang menurut saya membingungkan, serta memahami konsep yang belum saya kuasai. Demikian keterbatasan AI tidak sepenuhnya mengetahui apa yang sebenarnya saya inginkan, saya menggantikan sesuai dengan preferensi saya, dan untuk pemahaman perlu disesuaikan dengan materi di kelas.                                                               
}