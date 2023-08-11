import 'package:flutter/material.dart';

class Demo3 extends StatefulWidget {
  const Demo3({super.key});

  @override
  State<Demo3> createState() => _Demo3State();
}

class _Demo3State extends State<Demo3> {
  List<dynamic> data = [
    {"Name": "John", "Age": 28, "Role": "Senior Supervisor", "checked": false},
    {"Name": "Jane", "Age": 32, "Role": "Administrator", "checked": false},
    {"Name": "Mary", "Age": 28, "Role": "Manager", "checked": false},
    {"Name": "Kumar", "Age": 32, "Role": "Administrator", "checked": false},
  ];
  List<dynamic> filteredData = [];

  final searchController = TextEditingController();

  @override
  void initState() {
    filteredData = data;
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _onSearchTextChanged(String text) {
    setState(() {
      filteredData = text.isEmpty
          ? data
          : data
              .where((item) =>
                  item['Name'].toLowerCase().contains(text.toLowerCase()) ||
                  item['Role'].toLowerCase().contains(text.toLowerCase()) ||
                  item['Age'].toString().contains(text.toLowerCase()))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("DEMO 3"),
        ),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: searchController,
            decoration: const InputDecoration(
              hintText: 'Search...',
              border: OutlineInputBorder(),
            ),
            onChanged: _onSearchTextChanged,
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: DataTable(
            columns: const <DataColumn>[
              DataColumn(
                label: Text('Name'),
              ),
              DataColumn(
                label: Text('Age'),
                numeric: true,
              ),
              DataColumn(
                label: Text('Role'),
              ),
            ],
            rows: List.generate(filteredData.length, (index) {
              final item = filteredData[index];
              return DataRow(
                cells: [
                  DataCell(Text(item['Name'])),
                  DataCell(Text(item['Age'].toString())),
                  DataCell(Text(item['Role'])),
                ],
              );
            }),
          ),
        ),
      ]),
    );
  }
}
