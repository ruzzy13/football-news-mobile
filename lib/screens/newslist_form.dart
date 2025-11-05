import 'package:flutter/material.dart';
import 'package:football_news/widget/left_drawer.dart'; 

class NewsFormPage extends StatefulWidget {
  const NewsFormPage({super.key});

  @override
  State<NewsFormPage> createState() => _NewsFormPageState();
}

class _NewsFormPageState extends State<NewsFormPage> {
  // Kunci global untuk mengelola state form
  final _formKey = GlobalKey<FormState>();

  // Variabel untuk menyimpan data input
  String _title = "";
  String _content = "";
  String _category = "update"; // Nilai default
  String _thumbnail = "";
  bool _isFeatured = false; // Nilai default

  // Daftar kategori untuk Dropdown
  final List<String> _categories = [
    'transfer',
    'update',
    'exclusive',
    'match',
    'rumor',
    'analysis',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Form Tambah Berita',
          ),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      // Menambahkan drawer yang sudah dibuat sebelumnya
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Input Judul Berita ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Judul Berita",
                    labelText: "Judul Berita",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _title = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Judul tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // === Input Isi Berita ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5, // Memperbolehkan input multi-baris
                  decoration: InputDecoration(
                    hintText: "Isi Berita",
                    labelText: "Isi Berita",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _content = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Isi berita tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // === Input Kategori (Dropdown) ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Kategori",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  value: _category, // Nilai yang terpilih
                  items: _categories
                      .map((cat) => DropdownMenuItem(
                            value: cat,
                            // Menampilkan nama kategori dengan huruf kapital di awal
                            child: Text(cat[0].toUpperCase() + cat.substring(1)),
                          ))
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _category = newValue!;
                    });
                  },
                ),
              ),

              // === Input URL Thumbnail ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "URL Thumbnail (opsional)",
                    labelText: "URL Thumbnail",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _thumbnail = value!;
                    });
                  },
                  // Tidak ada validator karena opsional
                ),
              ),

              // === Input Berita Unggulan (Switch) ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SwitchListTile(
                  title: const Text("Tandai sebagai Berita Unggulan"),
                  value: _isFeatured,
                  onChanged: (bool value) {
                    setState(() {
                      _isFeatured = value;
                    });
                  },
                ),
              ),

              Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.indigo),
                ),
                
                onPressed: () {
                  // 1. Validasi form
                  if (_formKey.currentState!.validate()) {
                    // 2. Tampilkan AlertDialog
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          
                          title: const Text('Berita berhasil disimpan!'),
                          content: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text('Judul: $_title'),
                                Text('Isi: $_content'),
                                Text('Kategori: $_category'),
                                Text('Thumbnail: $_thumbnail'),
                                Text('Unggulan: ${_isFeatured ? "Ya" : "Tidak"}'),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.pop(context);
                                _formKey.currentState!.reset();
                              },
                            ),
                          ],
                        );
                      },
                    );
                    
                    // 3. Reset form setelah dialog muncul
                    // Reset juga state non-formfield secara manual
                    setState(() {
                      _category = "update";
                      _isFeatured = false;
                    });
                  }
                },
                child: const Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
            ],
          ),
        ),
      ),
    );
  }
}