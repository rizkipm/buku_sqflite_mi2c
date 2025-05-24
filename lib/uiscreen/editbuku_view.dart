import 'package:flutter/material.dart';

class EditbukuView extends StatefulWidget {
  const EditbukuView({super.key});

  @override
  State<EditbukuView> createState() => _EditbukuViewState();
}

class _EditbukuViewState extends State<EditbukuView> {
  var _namaBukuController = TextEditingController();
  var _judulBukuController = TextEditingController();

  bool _validateNama = false;
  bool _validateJudul = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Data Buku'),
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit Data Buku',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.teal,
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: _namaBukuController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Masukkan Nama Buku',
                    labelText: 'Nama Buku',
                    errorText: _validateNama ? 'Nama Tidak Boleh Kosong' : null
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: _judulBukuController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Masukkan Judul Buku',
                    labelText: 'Judul Buku',
                    errorText: _validateJudul ? 'Judul Tidak Boleh Kosong' : null
                ),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.teal,
                          textStyle: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)
                      ),
                      onPressed: (){}, child: Text('Update Details')),
                  SizedBox(width: 10,),
                  TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.red,
                          textStyle: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)
                      ),
                      onPressed: (){}, child: Text('Clear Details')),
                ],
              )
              //TASK :
              //Buat navigasi agar page edit di klik di dalam list dan add muncul ketika di klik
              //posisi klik untuk saat ini bebas

            ],
          ),
        ),
      ),

    );
  }
}
