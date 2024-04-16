import 'package:flutter/material.dart';
import 'package:profair/src/controllers/negotiation_controller.dart';
import 'package:profair/src/utils/format_currency.dart';
import 'package:profair/src/views/request_client/request_client_controller.dart';

class TableProducts extends StatefulWidget {
  const TableProducts({Key? key, required this.negotiationController}) : super(key: key);

  final RequestClientController negotiationController;

  @override
  State<TableProducts> createState() => _TableProductsState();
}

class _TableProductsState extends State<TableProducts> {
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
                "Embalagem",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: Text(
                "Fator",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              // DataColumn(
              //     label: Text(
              //   "Preço Unitário",
              //   style: TextStyle(fontWeight: FontWeight.bold),
              // )),
              DataColumn(
                  label: Text(
                "Preço Embalagem",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: Text(
                "Quantidade",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              DataColumn(
                  label: Text(
                "Total Negociado",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
            ],
            rows: widget.negotiationController.products
                .map((product) => DataRow(cells: [
                      DataCell(Text(product.codeProduct.toString())),
                      DataCell(
                        Tooltip(
                          message: product.nameProduct!,
                          child: Text(product.nameProduct!.length > 28 ? product.nameProduct!.substring(0, 28) : product.nameProduct!),
                        ),
                      ),
                      DataCell(Text(product.packing.toString())),
                      DataCell(Text(product.coefficient.toString())),
                      // DataCell(Text(formatCurrency(product.unitPrice!))),
                      DataCell(Text(formatCurrency(product.productPrice!))),
                      DataCell(Text(product.totalVolume.toString())),
                      DataCell(Text(formatCurrency(product.totalValue!))),
                    ]))
                .toList(),
          ),
        ],
      ),
    );
  }
}
