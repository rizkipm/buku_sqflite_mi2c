import 'package:buku_sqflite_mi2c/helper/db_helper.dart';
import 'package:buku_sqflite_mi2c/model/model_buku.dart';
import 'package:buku_sqflite_mi2c/uiscreen/addbuku_view.dart';
import 'package:flutter/material.dart';


class ListViewBuku extends StatefulWidget {
  const ListViewBuku({super.key});

  @override
  State<ListViewBuku> createState() => _ListViewBukuState();
}

class _ListViewBukuState extends State<ListViewBuku> {

  List<ModelBuku> _buku = [];
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseHelper.instance.initializeDataBuku();
    _fetchDataBuku();
  }

  Future<void> _fetchDataBuku() async {
    setState(() {
      _isLoading = true;
    });

    final bukuMaps = await DatabaseHelper.instance.queryAllBuku();

    setState(() {
      _buku = bukuMaps.map((bukuMaps) => ModelBuku.fromMap(bukuMaps)).toList();
      _isLoading = false;
    });
  }

  _deleteFormDialog(BuildContext context, bukuId) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text(
              'Are You Sure to Delete',
              style: TextStyle(color: Colors.teal, fontSize: 20),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.red),
                  onPressed: ()  async{
                    var result=await DatabaseHelper.instance.deleteBuku(bukuId);
                    if (result != null) {
                      Navigator.pop(context);
                      _fetchDataBuku();
                      _showSuccessSnackBar(
                          'Buku Id ${bukuId} berhasil di hapus');
                    }
                  },
                  child: const Text('Delete')),
              TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.teal),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'))
            ],
          );
        });
  }

  //Demo : 1. Proses Tambah, 2. Data otomatis bertambah di list setelah add data 3. Bisa delete dan ada snackbar
  //4. Lanjutin page edit sendiri dan bisa simpan hasil update nya kemudian muncul pesan berhasil update.

  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'List Data Buku'
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _fetchDataBuku();
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _buku.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_buku[index].namaBuku),
            subtitle: Text(_buku[index].judulBuku),
            //delete
            onLongPress: () {
              _deleteFormDialog(context, _buku[index].id);
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(onPressed: () async{
        // setState(() {
        //   Navigator.push(context, MaterialPageRoute(builder: (context)=> AddbukuView()));
        // });

          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddbukuView()),
          );
          _fetchDataBuku(); // Refresh data setelah kembali

      },
        child: Icon(Icons.add),
      ),
    );

  }
}
