import 'package:flutter/material.dart';
import 'package:profair/src/controllers/upload_controller.dart';

class TableUpload extends StatefulWidget {
  const TableUpload({Key? key, required this.uploadController}) : super(key: key);

  final UploadController uploadController;

  @override
  State<TableUpload> createState() => _TableUploadState();
}

class _TableUploadState extends State<TableUpload> {
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
                "Razão Social",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: Text(
                "CNPJ",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: Text(
                "Telefone",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
            ],
            rows: widget.uploadController.clientsUpload!
                .map((client) => DataRow(cells: [
                      DataCell(Text(client.code.toString())),
                      DataCell(Text(client.name!)),
                      DataCell(Text(client.social!)),
                      DataCell(Text(client.document!)),
                      DataCell(Text(client.phone!)),
                    ]))
                .toList(),
          ),
        ],
      ),
    );
  }
}
