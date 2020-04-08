import 'package:ansor_build/src/model/bpjs_model.dart';
import 'package:ansor_build/src/screen/beranda/beranda_screen.dart';
import 'package:ansor_build/src/service/bpjs_services.dart';
import 'package:ansor_build/src/service/local_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:indonesia/indonesia.dart';

class PembayaranBerhasil extends StatefulWidget {
  final String jenis;
  PembayaranBerhasil({this.jenis});

  @override
  _PembayaranBerhasilState createState() => _PembayaranBerhasilState();
}

class _PembayaranBerhasilState extends State<PembayaranBerhasil> {
  bool _isLoading = false;

  String _url = "";

  LocalService _localServices = LocalService();

  @override
  void initState() {
    super.initState();

    _localServices.getUrl().then(updateUrl);
  }

  void updateUrl(String updateUrl) {
    setState(() {
      this._url = updateUrl;
    });
  }

  Future<Berhasil> fetchBerhasil() async {
    final response = await http.get('http://103.9.125.18:3000' + _url);

    if (response.statusCode == 200) {
      return berhasilFromJson(response.body);
    } else {
      throw Exception('Failed to load Detail Berhasil');
    }
  }

  Future<BerhasilKerja> fetchBerhasilKerja() async {
    final response = await http.get('http://103.9.125.18:3000' + _url);

    if (response.statusCode == 200) {
      return berhasilKerjaFromJson(response.body);
    } else {
      throw Exception('Failed to load Detail Berhasil Ketenaakerjaan');
    }
  }

  tgl(data) {
    var data2 = data.toString();
    return data2.substring(8, 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.close),
            onPressed: () => Navigator.push(context,
                new MaterialPageRoute(builder: (__) => new BerandaPage())),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 333,
                        height: 35,
                        child: RaisedButton(
                          child: Text('SELESAI',
                              style: TextStyle(color: Colors.green)),
                          color: Colors.white,
                          onPressed: () {
                            setState(() => _isLoading = true);
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (__) => new BerandaPage()));
                            setState(() => _isLoading = false);
                          },
                        ),
                      )
                    ])),
            elevation: 0),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      widget.jenis == "kesehatan"
                          ? FutureBuilder<Berhasil>(
                              future: fetchBerhasil(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  DateTime periode =
                                      snapshot.data.data[0].periode;
                                  DateTime createdAt =
                                      snapshot.data.data[0].createdAt;
                                  if (snapshot.data.data.length == 0) {
                                    return Text("Tidak ada Data");
                                  } else {
                                    return (Container(
                                        child: Column(
                                      children: <Widget>[
                                        Container(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                              Center(
                                                child: Container(
                                                  width: 100.0,
                                                  height: 100.0,
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey[300],
                                                      shape: BoxShape.rectangle,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.0)),
                                                      border: Border.all(
                                                          color:
                                                              Colors.grey[300],
                                                          width: 1)),
                                                ),
                                              ),
                                              Container(height: 10),
                                              Center(
                                                child: Text(
                                                    "Transaksi Berhasil",
                                                    style: new TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.green)),
                                              ),
                                              Container(height: 15),
                                              Center(
                                                child: Text(
                                                    tgl(createdAt) +
                                                        tanggal(createdAt).substring(1) +
                                                        ", " +
                                                        DateFormat('HH:mm')
                                                            .format(createdAt),
                                                    textAlign: TextAlign.center,
                                                    style: new TextStyle(
                                                        fontSize: 12.0)),
                                              ),
                                              Center(
                                                child: Text("via Un1ty",
                                                    textAlign: TextAlign.center,
                                                    style: new TextStyle(
                                                        fontSize: 12.0)),
                                              ),
                                              Container(height: 25),
                                              Text("Detail",
                                                  textAlign: TextAlign.start,
                                                  style: new TextStyle(
                                                      fontSize: 14.0)),
                                              Container(height: 10),
                                              Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0,
                                                          right: 10.0,
                                                          top: 12.0,
                                                          bottom: 12.0),
                                                  width: double.infinity,
                                                  height: 200.0,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.rectangle,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10.0)),
                                                      border: Border.all(
                                                          color:
                                                              Colors.grey[300],
                                                          width: 1)),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Expanded(
                                                        flex: 1,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Container(
                                                              child: Text(
                                                                  "Jenis Layanan",
                                                                  style: new TextStyle(
                                                                      fontSize:
                                                                          12.0)),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                  "BPJS Kesehatan",
                                                                  style: new TextStyle(
                                                                      fontSize:
                                                                          12.0)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Container(
                                                              child: Text(
                                                                  "Nama Pelanggan",
                                                                  style: new TextStyle(
                                                                      fontSize:
                                                                          12.0)),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                  snapshot
                                                                      .data
                                                                      .data[0]
                                                                      .namaPelanggan,
                                                                  style: new TextStyle(
                                                                      fontSize:
                                                                          12.0)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Container(
                                                              child: Text(
                                                                  "No VA/Keluarga",
                                                                  style: new TextStyle(
                                                                      fontSize:
                                                                          12.0)),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                  snapshot
                                                                      .data
                                                                      .data[0]
                                                                      .noVa
                                                                      .toString(),
                                                                  style: new TextStyle(
                                                                      fontSize:
                                                                          12.0)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Container(
                                                              child: Text(
                                                                  "Periode",
                                                                  style: new TextStyle(
                                                                      fontSize:
                                                                          12.0)),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                  tanggal(periode)
                                                                      .substring(
                                                                          1),
                                                                  style: new TextStyle(
                                                                      fontSize:
                                                                          12.0)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Container(
                                                              child: Text(
                                                                  "Jumlah Keluarga",
                                                                  style: new TextStyle(
                                                                      fontSize:
                                                                          12.0)),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                  snapshot
                                                                      .data
                                                                      .data[0]
                                                                      .jumlahKeluarga
                                                                      .toString(),
                                                                  style: new TextStyle(
                                                                      fontSize:
                                                                          12.0)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Container(
                                                              child: Text(
                                                                  "Nomor Transaksi",
                                                                  style: new TextStyle(
                                                                      fontSize:
                                                                          12.0)),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                  snapshot
                                                                      .data
                                                                      .data[0]
                                                                      .noTransaksi
                                                                      .toString(),
                                                                  style: new TextStyle(
                                                                      fontSize:
                                                                          12.0)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Container(
                                                              child: Text(
                                                                  "Total Tagihan",
                                                                  style: new TextStyle(
                                                                      fontSize:
                                                                          12.0)),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                  NumberFormat.simpleCurrency(
                                                                          locale:
                                                                              'id',
                                                                          decimalDigits:
                                                                              0)
                                                                      .format(snapshot
                                                                          .data
                                                                          .data[
                                                                              0]
                                                                          .total),
                                                                  style: new TextStyle(
                                                                      fontSize:
                                                                          12.0)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                              Container(height: 15),
                                            ]))
                                      ],
                                    )));
                                  }
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text(
                                          "Gagal Memuat Detail Pembayaran"));
                                }
                                return Center(
                                    child: CircularProgressIndicator());
                              },
                            )
                          : FutureBuilder<BerhasilKerja>(
                              future: fetchBerhasilKerja(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  DateTime createdAt =
                                      snapshot.data.data[0].createdAt;
                                  if (snapshot.data.data.length == 0) {
                                    return Text("Tidak ada Data");
                                  } else {
                                    return (Container(
                                        child: Column(
                                      children: <Widget>[
                                        Container(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                              Center(
                                                child: Container(
                                                  width: 100.0,
                                                  height: 100.0,
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey[300],
                                                      shape: BoxShape.rectangle,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.0)),
                                                      border: Border.all(
                                                          color:
                                                              Colors.grey[300],
                                                          width: 1)),
                                                ),
                                              ),
                                              Container(height: 10),
                                              Center(
                                                child: Text(
                                                    "Transaksi Berhasil",
                                                    style: new TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.green)),
                                              ),
                                              Container(height: 15),
                                              Center(
                                                child: Text(
                                                    tgl(createdAt) +
                                                        tanggal(createdAt).substring(1) +
                                                        ", " +
                                                        DateFormat('HH:mm')
                                                            .format(createdAt),
                                                    textAlign: TextAlign.center,
                                                    style: new TextStyle(
                                                        fontSize: 12.0)),
                                              ),
                                              Center(
                                                child: Text("via Un1ty",
                                                    textAlign: TextAlign.center,
                                                    style: new TextStyle(
                                                        fontSize: 12.0)),
                                              ),
                                              Container(height: 25),
                                              Text("Detail",
                                                  textAlign: TextAlign.start,
                                                  style: new TextStyle(
                                                      fontSize: 14.0)),
                                              Container(height: 10),
                                              Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0,
                                                          right: 10.0,
                                                          top: 12.0,
                                                          bottom: 12.0),
                                                  width: double.infinity,
                                                  height: 300.0,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.rectangle,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10.0)),
                                                      border: Border.all(
                                                          color:
                                                              Colors.grey[300],
                                                          width: 1)),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Container(
                                                              child: Text(
                                                                  "Jenis Layanan",
                                                                  style: new TextStyle(
                                                                      fontSize:
                                                                          12.0)),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                  "BPJS Ketenagakerjaan",
                                                                  style: new TextStyle(
                                                                      fontSize:
                                                                          12.0)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Container(
                                                              child: Text(
                                                                  "Nama Pelanggan",
                                                                  style: new TextStyle(
                                                                      fontSize:
                                                                          12.0)),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                  snapshot
                                                                      .data
                                                                      .data[0]
                                                                      .namaPemilik,
                                                                  style: new TextStyle(
                                                                      fontSize:
                                                                          12.0)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Container(
                                                              child: Text(
                                                                  "No KTP/Peserta",
                                                                  style: new TextStyle(
                                                                      fontSize:
                                                                          12.0)),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                  snapshot
                                                                      .data
                                                                      .data[0]
                                                                      .noKtp,
                                                                  style: new TextStyle(
                                                                      fontSize:
                                                                          12.0)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Container(
                                                              child: Text(
                                                                  "Periode",
                                                                  style: new TextStyle(
                                                                      fontSize:
                                                                          12.0)),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                  snapshot
                                                                          .data
                                                                          .data[
                                                                              0]
                                                                          .periodeByr
                                                                          .toString() +
                                                                      " Bulan",
                                                                  style: new TextStyle(
                                                                      fontSize:
                                                                          12.0)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Container(
                                                              child: Text(
                                                                  "Jaminan Kecelakaan Kerja",
                                                                  style: new TextStyle(
                                                                      fontSize:
                                                                          12.0)),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                  NumberFormat.simpleCurrency(
                                                                          locale:
                                                                              'id',
                                                                          decimalDigits:
                                                                              0)
                                                                      .format(snapshot
                                                                          .data
                                                                          .data[
                                                                              0]
                                                                          .jkk),
                                                                  style: new TextStyle(
                                                                      fontSize:
                                                                          12.0)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Container(
                                                              child: Text(
                                                                  "Jaminan Kematian",
                                                                  style: new TextStyle(
                                                                      fontSize:
                                                                          12.0)),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                  NumberFormat.simpleCurrency(
                                                                          locale:
                                                                              'id',
                                                                          decimalDigits:
                                                                              0)
                                                                      .format(snapshot
                                                                          .data
                                                                          .data[
                                                                              0]
                                                                          .jkm),
                                                                  style: new TextStyle(
                                                                      fontSize:
                                                                          12.0)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Container(
                                                              child: Text(
                                                                  "Jaminan Hari Tua",
                                                                  style: new TextStyle(
                                                                      fontSize:
                                                                          12.0)),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                  NumberFormat.simpleCurrency(
                                                                          locale:
                                                                              'id',
                                                                          decimalDigits:
                                                                              0)
                                                                      .format(snapshot
                                                                          .data
                                                                          .data[
                                                                              0]
                                                                          .jht),
                                                                  style: new TextStyle(
                                                                      fontSize:
                                                                          12.0)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Container(
                                                              child: Text(
                                                                  "Jaminan Pensiun",
                                                                  style: new TextStyle(
                                                                      fontSize:
                                                                          12.0)),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                  NumberFormat.simpleCurrency(
                                                                          locale:
                                                                              'id',
                                                                          decimalDigits:
                                                                              0)
                                                                      .format(snapshot
                                                                          .data
                                                                          .data[
                                                                              0]
                                                                          .jp),
                                                                  style: new TextStyle(
                                                                      fontSize:
                                                                          12.0)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Container(
                                                              child: Text(
                                                                  "Biaya Pelayanan",
                                                                  style: new TextStyle(
                                                                      fontSize:
                                                                          12.0)),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                  NumberFormat.simpleCurrency(
                                                                          locale:
                                                                              'id',
                                                                          decimalDigits:
                                                                              0)
                                                                      .format(snapshot
                                                                          .data
                                                                          .data[
                                                                              0]
                                                                          .adminFee),
                                                                  style: new TextStyle(
                                                                      fontSize:
                                                                          12.0)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Container(
                                                              child: Text(
                                                                  "Nomor Transaksi",
                                                                  style: new TextStyle(
                                                                      fontSize:
                                                                          12.0)),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                  snapshot
                                                                      .data
                                                                      .data[0]
                                                                      .noTransaksi,
                                                                  style: new TextStyle(
                                                                      fontSize:
                                                                          12.0)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Container(
                                                              child: Text(
                                                                  "Total Tagihan",
                                                                  style: new TextStyle(
                                                                      fontSize:
                                                                          12.0)),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                  NumberFormat.simpleCurrency(
                                                                          locale:
                                                                              'id',
                                                                          decimalDigits:
                                                                              0)
                                                                      .format(snapshot
                                                                          .data
                                                                          .data[
                                                                              0]
                                                                          .total),
                                                                  style: new TextStyle(
                                                                      fontSize:
                                                                          12.0)),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                              Container(height: 15),
                                            ]))
                                      ],
                                    )));
                                  }
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text(
                                          "Gagal Memuat Detail Pembayaran"));
                                }
                                return Center(
                                    child: CircularProgressIndicator());
                              },
                            )
                    ]))));
  }
}
