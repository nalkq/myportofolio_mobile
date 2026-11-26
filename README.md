[![CI](https://github.com/nalkq/myportofolio_mobile/actions/workflows/main.yaml/badge.svg?branch=Tugas-9)](https://github.com/nalkq/myportofolio_mobile/actions/workflows/main.yaml)

Nama : Kaysan Navid Musyaffa

NPM : 2506625470

Kelas : PBP B

## Panduan Jalankan Aplikasi Secara Lokal

### 1. Siapkan Lingkungan Pengembangan

Pastikan Flutter SDK sudah terpasang dan tersedia melalui PATH.
Periksa lingkungan pengembangan dengan:

```bash
flutter doctor
```

Siapkan perangkat untuk menjalankan aplikasi, misalnya emulator
Android, perangkat Android fisik, atau Chrome untuk versi web.

### 2. Clone Repositori

Buka terminal, lalu jalankan:

```bash
git clone https://github.com/nalkq/myportofolio_mobile.git
cd myportofolio_mobile
```

### 3. Install Dependencies

Jalankan perintah berikut dari folder utama proyek:

```bash
flutter pub get
dart run build_runner build
```

### 4. Periksa Perangkat yang Tersedia

```bash
flutter devices
```

Pastikan perangkat tujuan terdeteksi. Jika menggunakan emulator,
nyalakan emulator terlebih dahulu.

### 5. Jalankan Backend Django

Clone [repositori backend Django](https://github.com/nalkq/myportofolio) ke folder terpisah. Dari folder backend yang berisi `manage.py`, jalankan perintah berikut di PowerShell:

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install -r requirements.txt
python manage.py migrate
```

Untuk menguji pembuatan Experience, buat akun superuser dengan `python manage.py createsuperuser` jika belum punya. Lalu nyalakan server:

```powershell
python manage.py runserver
```

Daftar Experience tersedia di `http://localhost:8000/api/v1/experiences/` dan bisa dibuka tanpa login.

### 6. Jalankan Flutter

Biarkan Django berjalan. Buka terminal kedua di folder `myportofolio_mobile`.

Untuk emulator Android:

```powershell
flutter run
```

Untuk Chrome:

```powershell
flutter run -d chrome --dart-define=API_BASE_URL=http://localhost:8000
```

Buka **Lihat Experience** untuk melihat daftar dan detail. Untuk menambah data, pilih **Tambah Experience** dan masuk dengan akun superuser Django.

## AI Disclosure
Tentu projek yang saya kerjakan ini memiliki andil AI di dalamnya, AI membantu saya mengeksplor apa saja yang bisa dilakukan flutter dan memberikan saya berbagai macam pilihan style yang dapat saya implementasikan ke projek yang saya kerjakan ini. AI juga membantu saya dalam memahami tata cara conventional commits yang baik dan benar agar sesuai dengan standar profesional. AI juga membantu saya dalam memberikan panduan penambahan/perubahan kode apa yang harus saya lakukan, membantu memahami konteks materi yang ditanyakan di pertanyaan reflektif, serta membantu saya dalam menyusun README.md yang baik dan benar.

### Tugas 7
Pada pengerjaan tugas kali ini, saya tidak mengalami kesulitan yang signifikan karena perubahan yang diminta masih cukup mudah untuk dimengerti. Saya menggunakan AI untuk membantu saya lebih paham lagi apa yang ditanyakan pada pertanyaan reflektif.

https://chatgpt.com/s/cx_6afab7caf21c819198f675290d2b70a1

### Tugas 8
Pada pengerjaan tugas kali ini, saya cukup kesulitan untuk mencoba membuat tampilan form sendiri tanpa panduan tutorial, saya menggunakan bantuan AI untuk memberikan saya panduan dalam membuat form experiece yang ingin saya buat. Saya cukup kesulitan dan kurang mengerti penjelasan yang diberikan oleh AI. Saya juga menggunakan AI untuk membantu saya lebih paham lagi apa yang ditanyakan pada pertanyaan reflektif.

https://chatgpt.com/s/cx_6b002fa590f48191981ab112700e9451

## Pertanyaan Reflektif
### Tugas 7

#### 1. Jelaskan apa yang dimaksud dengan widget tree pada Flutter dan bagaimana hubungan induk-anak (parent-child) bekerja antar-widget!
Widget adalah bagian penyusun tampilan, seperti tulisan, ikon, dan kartu. Widget tree adalah susunan bagian-bagian tersebut. Widget dapat menampung satu anak melalui child, atau beberapa anak melalui children, sesuai jenis widgetnya. Contohnya, Row menjadi induk dari tiga kartu identitas dan menyusunnya secara mendatar.

#### 2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya masing-masing!
- MyApp: Mengatur aplikasi secara keseluruhan.
- MaterialApp: Mengatur tema dan halaman pertama aplikasi.
- MyHomePage: Menyusun tampilan halaman utama.
- Scaffold: Menyediakan kerangka halaman.
- AppBar: Menampilkan bar judul di atas layar.
- Text: Menampilkan tulisan.
- Icon: Menampilkan ikon.
- Row: Menyusun bagian-bagian secara mendatar.
- Column: Menyusun bagian-bagian dari atas ke bawah.
- Padding: Memberikan jarak di sekeliling isi.
- SizedBox: Memberikan ruang kosong sebagai jarak.
- Center: Meletakkan isi di tengah.
- Container: Menjadi wadah yang bisa diatur ukuran dan jaraknya.
- Card: Membuat tampilan berbentuk kartu.
- GridView.count: Menyusun tombol menjadi beberapa kolom.
- Material: Memberikan warna dan bentuk pada permukaan tombol.
- InkWell: Membuat bagian tampilan bisa ditekan dan memberikan efek sentuhan.
- SnackBar: Menampilkan pesan sementara di bawah layar.
- InfoCard: Kartu buatan sendiri untuk menampilkan identitas.
- ItemCard: Kartu tombol buatan sendiri untuk menu aksi.

#### 3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini umumnya digunakan sebagai root widget pada aplikasi Flutter!
MaterialApp digunakan untuk mengatur tema, halaman awal, dan navigasi aplikasi. MaterialApp dapat dianggap sebagai tempat pengaturan utama aplikasi. Widget ini biasanya diletakkan di bagian atas susunan aplikasi supaya pengaturannya dapat digunakan oleh bagian-bagian di bawahnya. Contohnya, warna tema dapat dipakai oleh halaman utama.

#### 4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget! Kapan kita sebaiknya memilih StatelessWidget dan kapan harus menggunakan StatefulWidget?
Perbedaannya terletak pada kebutuhan menyimpan data yang berubah selama aplikasi digunakan. StatelessWidget: cocok untuk bagian yang tidak perlu menyimpan perubahan datanya sendiri. Contohnya kartu yang menampilkan nama dan NPM. StatefulWidget: cocok untuk bagian yang menyimpan perubahan data. Contohnya tombol penghitung: setiap ditekan, angka yang ditampilkan bertambah.

#### 5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di dalam metode build?
BuildContext bisa dibayangkan sebagai alamat suatu widget dalam susunan aplikasi. Alamat ini membantu widget menemukan pengaturan atau fasilitas yang dibutuhkannya. Pada aplikasi ini, context digunakan untuk mengambil warna tema, mengetahui ukuran layar, dan menampilkan SnackBar. Saat metode build menyusun tampilan, context diberikan agar widget dapat mengakses kebutuhan tersebut dari tempatnya berada.

#### 6. Jelaskan konsep hot reload di Flutter dan apa perbedaannya dengan hot restart! Kapan kita tidak bisa hanya mengandalkan hot reload dan harus melakukan hot restart atau full restart?
Hot reload: memperlihatkan perubahan kode tanpa mengulang aplikasi dari awal. Cocok untuk mencoba perubahan tulisan atau warna. Data yang sedang digunakan tetap dipertahankan. Hot restart: mengulang aplikasi Flutter dari awal sehingga datanya kembali ke kondisi awal. Digunakan jika ingin menjalankan ulang pengaturan awal aplikasi. Full restart: menghentikan aplikasi lalu menjalankannya kembali sepenuhnya. Diperlukan, misalnya, ketika mengubah bagian Android yang ditulis dengan Java atau Kotlin. Untuk perubahan tampilan sederhana bisa memakai hot reload. Jika perlu mengulang proses awal, bisa memakai hot restart.


### Tugas 8

#### 1. Jelaskan perbedaan antara `Navigator.push()`, `Navigator.pushReplacement()`, dan `Navigator.pop()`. Metode apa yang digunakan untuk membuka formulir dari kartu aksi? Jelaskan juga bagaimana opsi Home di drawer membawa pengguna kembali ke halaman utama.
`Navigator.push()` membuka halaman baru tanpa menghapus halaman sebelumnya, sehingga pengguna bisa kembali menggunakan tombol Back. `Navigator.pushReplacement()` mengganti halaman yang sedang dibuka dengan halaman baru. Sementara itu, `Navigator.pop()` menutup halaman atau dialog yang sedang terbuka.
Pada kode ini, kartu Tambah Experience menggunakan `Navigator.push()` untuk membuka formulir. Opsi Home pada drawer menggunakan `Navigator.pushReplacement()` untuk mengganti halaman formulir dengan halaman utama.

#### 2. Bagaimana susunan `Scaffold`, `AppBar`, dan `Drawer` membantu menjaga struktur halaman tetap konsisten? Berikan satu contoh penggunaan warna tema portofolio di lebih dari satu halaman.
`Scaffold` menyediakan kerangka halaman, `AppBar` menampilkan judul di bagian atas, dan `Drawer` menyediakan menu untuk berpindah halaman.
Saya menggunakan drawer yang sama pada halaman utama dan formulir agar pilihan navigasinya konsisten. Selain itu, `AppBar` pada halaman utama dan formulir `Experience` sama-sama menggunakan warna utama dari tema aplikasi.

#### 3. Mengapa tata letak tersebut dipilih untuk formulir? Jelaskan peran widget pengatur jarak dan widget penggulir ketika ruang layar terbatas.
Saya menggunakan Column untuk menyusun input dari atas ke bawah agar formulir mudah dibaca dan diisi. `Padding` memberikan jarak dari tepi halaman, sedangkan `SizedBox` memberikan jarak antarelemen supaya tidak berdempetan.
Saya juga menggunakan `SingleChildScrollView` agar formulir bisa digulir. Dengan begitu, pengguna tetap dapat menjangkau seluruh input dan tombol Simpan pada layar kecil atau ketika keyboard muncul.

#### 4. Apa peran `GlobalKey<FormState>`, `validator`, dan `validate()` saat tombol Simpan ditekan? Berikan satu contoh nilai yang ditolak oleh validasi dan jelaskan mengapa memilih jenis input atau papan ketik saja belum cukup.
`GlobalKey<FormState>` digunakan untuk mengakses keadaan form. Setiap `validator` berisi aturan pemeriksaan input pada kolom terkait. Saat tombol Simpan ditekan, `validate()` menjalankan seluruh pemeriksaan tersebut.
Jika ada input yang salah, pesan kesalahan ditampilkan pada kolom terkait. Jika semuanya benar, aplikasi menampilkan dialog berisi isian pengguna.
Contoh input yang ditolak adalah judul yang hanya berisi spasi, karena judul wajib memiliki isi. Judul yang melebihi 100 karakter juga ditolak. Memilih jenis input atau keyboard saja belum cukup karena tidak otomatis memeriksa apakah kolom kosong, hanya berisi spasi, atau terlalu panjang.