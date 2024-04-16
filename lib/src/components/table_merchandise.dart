import 'package:flutter/material.dart';
import 'package:profair/src/controllers/upload_controller.dart';

class TableMerchandise extends StatefulWidget {
  const TableMerchandise({Key? key, required this.uploadController}) : super(key: key);

  final UploadController uploadController;

  @override
  State<TableMerchandise> createState() => _TableMerchandiseState();
}

class _TableMerchandiseState extends State<TableMerchandise> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DataTable(
            onSelectAll: (b) {},
            sortColumnIndex: 0,
            sortAscending: true,
            columns: const <DataColumn>[
              DataColumn(
                  label: Text(
                "Código",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: Text(
                "Nome",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: Text(
                "Código de barras",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: Text(
                "Complemento",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: Text(
                "ERP Code",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: Text(
                "Marca",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: Text(
                "Empresa",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: Text(
                "Embalagem",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: Text(
                "Fator",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: Text(
                "Preço",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: Text(
                "Preço unitário",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: Text(
                "Negociação",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
            ],
            rows: widget.uploadController.renew!
                .map((client) => DataRow(cells: [
                      DataCell(Text(client.code.toString())),
                      DataCell(Text(client.name.toString())),
                      DataCell(Text(client.barcode.toString())),
                      DataCell(Text(client.complement.toString())),
                      DataCell(Text(client.erpcode.toString())),
                      DataCell(Text(client.brand.toString())),
                      DataCell(Text(client.company.toString())),
                      DataCell(Text(client.packing.toString())),
                      DataCell(Text(client.factor.toString())),
                      DataCell(Text(client.price.toString())),
                      DataCell(Text(client.unitPrice.toString())),
                      DataCell(Text(client.negociacao.toString())),
                    ]))
                .toList(),
          ),
        ],
      ),
    );
  }
}
