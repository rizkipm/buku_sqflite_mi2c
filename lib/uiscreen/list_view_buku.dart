import 'package:buku_sqflite_mi2c/helper/db_helper.dart';
import 'package:buku_sqflite_mi2c/model/model_buku.dart';
import 'package:flutter/material.dart';


class ListViewBuku extends StatefulWidget {
  const ListViewBuku({super.key});

  @override
  State<ListViewBuku> createState() => _ListViewBukuState();
}

class _ListViewBukuState extends State<ListViewBuku> {

  List<ModelBuku> _buku = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchDataBuku();
  }

  Future<void> _fetchDataBuku() async{
    final bukuMaps = await DatabaseHelper.instance.queryAllBuku();
    setState(() {
      _buku = bukuMaps.map((bukuMaps) => ModelBuku.fromMap(bukuMaps)).toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'List Data Buku'
        ),
      ),
      body: ListView.builder(
        itemCount: _buku.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text(_buku[index].namaBuku),
            subtitle: Text(_buku[index].judulBuku),
          );
        },
      ),
    );

  }
}
