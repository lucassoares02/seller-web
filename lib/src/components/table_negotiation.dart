import 'package:flutter/material.dart';
import 'package:profair/src/controllers/upload_controller.dart';

class TableNegotiation extends StatefulWidget {
  const TableNegotiation({Key? key, required this.uploadController}) : super(key: key);

  final UploadController uploadController;

  @override
  State<TableNegotiation> createState() => _TableNegotiationState();
}

class _TableNegotiationState extends State<TableNegotiation> {
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
                "Empresa",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: Text(
                "Prazo",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: Text(
                "Observação",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: Text(
                "ERP",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
            ],
            rows: widget.uploadController.negotiationUploadBackup!
                .map((client) => DataRow(cells: [
                      DataCell(Text(client.code.toString())),
                      DataCell(Text(client.name.toString())),
                      DataCell(Text(client.company.toString())),
                      DataCell(Text(client.prazo.toString())),
                      DataCell(Text(client.observacao.toString())),
                      DataCell(Text(client.codNegoErp.toString())),
                    ]))
                .toList(),
          ),
        ],
      ),
    );
  }
}
