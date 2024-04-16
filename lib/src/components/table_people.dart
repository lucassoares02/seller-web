import 'package:flutter/material.dart';
import 'package:profair/src/controllers/upload_controller.dart';

class TablePeople extends StatefulWidget {
  const TablePeople({Key? key, required this.uploadController}) : super(key: key);

  final UploadController uploadController;

  @override
  State<TablePeople> createState() => _TablePeopleState();
}

class _TablePeopleState extends State<TablePeople> {
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
                "CPF",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: Text(
                "Telefone",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: Text(
                "Hash",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: Text(
                "Acesso",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: Text(
                "E-mail",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
            ],
            rows: widget.uploadController.peopleUpload!
                .map((client) => DataRow(cells: [
                      DataCell(Text(client.code.toString())),
                      DataCell(Text(client.name.toString())),
                      DataCell(Text(client.company.toString())),
                      DataCell(Text(client.document.toString())),
                      DataCell(Text(client.phone.toString())),
                      DataCell(Text(client.hash.toString())),
                      DataCell(Text(client.type.toString())),
                      DataCell(Text(client.email.toString())),
                    ]))
                .toList(),
          ),
        ],
      ),
    );
  }
}
