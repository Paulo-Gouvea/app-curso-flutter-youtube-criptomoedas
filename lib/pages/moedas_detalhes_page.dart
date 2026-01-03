import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_aula_1/models/moeda.dart';
import 'package:flutter_aula_1/widgets/block_button.dart';
import 'package:intl/intl.dart';

class MoedasDetalhesPage extends StatefulWidget {
  Moeda moeda;

  //const MoedasDetalhesPage({super.key, required this.moeda});
  MoedasDetalhesPage({super.key, required this.moeda});

  @override
  State<MoedasDetalhesPage> createState() => _MoedasDetalhesPageState();
}

class _MoedasDetalhesPageState extends State<MoedasDetalhesPage> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  final _form = GlobalKey<FormState>();
  final _valor = TextEditingController();
  double quantidade = 0;

  comprar() {
    if(_form.currentState!.validate()) {
      // Salvar a comprar

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Compra realizada com sucesso!'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.moeda.nome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50, 
                    child: Image.asset(widget.moeda.icone)
                  ),
                  Container(
                    width: 10,
                  ),
                  Text(
                    real.format(widget.moeda.preco),
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -1,
                      color: Colors.grey[800],
                    ),
                  )
                ],
              ),
            ),
            (quantidade > 0)
            ? SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Container(
                margin: EdgeInsets.only(bottom: 24),
                //padding: EdgeInsets.all(12),
                alignment: Alignment.center,
                // decoration: BoxDecoration(
                //   color: Colors.teal.withValues(alpha: 0.05),
                // ),
                child: Text(
                  '$quantidade ${widget.moeda.sigla}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                  ),
                ),
              ),
            )
            : Container(
              margin: EdgeInsets.only(bottom: 24),
            )
            ,
            Form(
              key: _form,
              child: TextFormField(
                controller: _valor,
                style: TextStyle(
                  fontSize: 22 
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Valor',
                  prefixIcon: Icon(Icons.monetization_on_outlined),
                  suffix: Text(
                    'reais',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (value) {
                 if(value!.isEmpty) {
                  return 'Informe o valor da compra';
                 } else if(double.parse(value) < 50){
                  return 'Compra mínima é R\$ 50,00';
                 } 
                 return null;
                },
                onChanged: (value) {
                  setState(() {
                    quantidade = (value.isEmpty)
                      ? 0
                      : double.parse(value) / widget.moeda.preco;
                  });
                },
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(top: 24),
              child: BlockButton(icon: Icons.check, label: 'Comprar', onPressed: comprar)
            )
          ],
        ),
      ),
    );
  }
}