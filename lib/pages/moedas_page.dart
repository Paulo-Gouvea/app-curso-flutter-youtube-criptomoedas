import 'package:flutter/material.dart';
import 'package:flutter_aula_1/models/moeda.dart';
import 'package:flutter_aula_1/repositories/moeda_repository.dart';
import 'package:intl/intl.dart';

class MoedasPage extends StatefulWidget {
  const MoedasPage({super.key});

  @override
  State<MoedasPage> createState() => _MoedasPageState();
}

class _MoedasPageState extends State<MoedasPage> {
  List<Moeda> tabela = MoedaRepository.tabela;
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  List<Moeda> selecionadas = [];
  bool isSorted = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cripto Moedas'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (!isSorted) {
                  tabela.sort((Moeda a, Moeda b) => a.nome.compareTo(b.nome));
                  isSorted = true;
                } else {
                  tabela = tabela.reversed.toList();
                }
              });
            }, 
            icon: const Icon(Icons.swap_vert_circle)
          )
        ],
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int moeda) {
          return ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            leading: (selecionadas.contains(tabela[moeda]))
            ? CircleAvatar(
              child: Icon(Icons.check),
            )
            : SizedBox(
              child: Image.asset(tabela[moeda].icone,
              width: 40,
              )
            ),
            title: Text(
              tabela[moeda].nome,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Text(
              real.format(tabela[moeda].preco)
            ),
            selected: selecionadas.contains(tabela[moeda]),
            selectedTileColor: Colors.indigo[50],
            onLongPress: () {
              setState(() {
                (selecionadas.contains(tabela[moeda]))
                ? selecionadas.remove(tabela[moeda])
                : selecionadas.add(tabela[moeda]);
              });
            },
          );
        }, 
        padding: EdgeInsets.all(16),
        separatorBuilder: (_, __) => Divider(), 
        itemCount: tabela.length
      )
    );
  }
}