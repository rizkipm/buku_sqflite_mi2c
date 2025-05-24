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

  // Future<void> _fetchDataBuku() async{
  //   final bukuMaps = await DatabaseHelper.instance.queryAllBuku();
  //   setState(() {
  //     _buku = bukuMaps.map((bukuMaps) => ModelBuku.fromMap(bukuMaps)).toList();
  //   });
  // }

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
                    var result=await DatabaseHelper.instance.deleteUser(bukuId);
                    if (result != null) {
                      Navigator.pop(context);
                      _fetchDataBuku();
                      _showSuccessSnackBar(
                          'User Detail Deleted Success');
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
      // body: ListView.builder(
      //   itemCount: _buku.length,
      //   itemBuilder: (context, index){
      //     return ListTile(
      //       title: Text(_buku[index].namaBuku),
      //       subtitle: Text(_buku[index].judulBuku),
      //       onLongPress: (){
      //         _deleteFormDialog(context, _buku[index].id);
      //       },
      //     );
      //   },
      // ),

      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _buku.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_buku[index].namaBuku),
            subtitle: Text(_buku[index].judulBuku),
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
