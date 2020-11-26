

import 'package:flutter/material.dart';
import 'dart:math';

class Aluno {
  // Atributos
  String _nome;
  double _nota1;
  double _nota2;
  double _media = 0;

  // Construtor
  Aluno(this._nota1, this._nota2, [this._nome]) {
    this._media = calcularMedia();
  }

  // Métodos
  double calcularMedia() {
    return ((_nota2 + _nota2)/2);
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Aluno> lista = [];

  // Construtor
  MyApp() {
    Aluno primeiro = Aluno (5,9, "chico");
   lista.add(primeiro);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Projeto de flutter",
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(lista),
    );
  }
}

class HomePage extends StatefulWidget {
  final List<Aluno> lista;

  // Construtor
  HomePage(this.lista);

  @override
  _HomePageState createState() => _HomePageState(lista);
}

class _HomePageState extends State<HomePage> {
  final List<Aluno> lista;

  // Construtor
  _HomePageState(this.lista);

  // Métodos
  void _atualizarTela() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      drawer: NavDrawer(lista),
      appBar: AppBar(
        title: Text("Aluno (${lista.length})"),
      ),
      body: ListView.builder(
          itemCount: lista.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                "${lista[index]._nome}",
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {},
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _atualizarTela,
        tooltip: 'Atualizar',
        child: Icon(Icons.update),
      ),
    );
  }
}

class NavDrawer extends StatelessWidget {
  // Atributos
  final List lista;
  final double _fontSize = 17.0;

  // Construtor
  NavDrawer(this.lista);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // Opcional
          DrawerHeader(
            child: Text(
              "Menu",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            decoration: BoxDecoration(color: Colors.green),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              "Informações do Aluno",
              style: TextStyle(fontSize: _fontSize),
            ),
            onTap: () {
              Navigator.pop(context); // Fecha o Drawer
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaInformacoesDoAluno(lista),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person_search),
            title: Text(
              "Buscar por um Aluno",
              style: TextStyle(fontSize: _fontSize),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaBuscarPorAluno(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person_add_alt_1_sharp),
            title: Text(
              "Cadastrar um Novo Aluno",
              style: TextStyle(fontSize: _fontSize),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaCadastrarAluno(lista),
                ),
              );
            },
          ),
          Container(
            padding: EdgeInsets.all(20.0),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ListTile(
              leading: Icon(Icons.face),
              title: Text(
                "Sobre",
                style: TextStyle(fontSize: _fontSize),
              ),
              onTap: () => {},
            ),
          ),
        ],
      ),
    );
  }
}

//-----------------------------------------------------------------------------
// Tela Informações do Aluno
//-----------------------------------------------------------------------------

class TelaInformacoesDoAluno extends StatefulWidget {
  final List<Aluno> lista;

  // Construtor
  TelaInformacoesDoAluno(this.lista);

  @override
  _TelaInformacoesDoAluno createState() => _TelaInformacoesDoAluno(lista);
}

class _TelaInformacoesDoAluno extends State<TelaInformacoesDoAluno> {
  // Atributos
  final List lista;
  Aluno aluno;
  int index = -1;
  double _fontSize = 18.0;
  final nomeController = TextEditingController();
  final nota1Controller = TextEditingController();
  final nota2Controller = TextEditingController();
  final mediaController = TextEditingController();
  bool _edicaoHabilitada = false;

  // Construtor
  _TelaInformacoesDoAluno(this.lista) {
    if (lista.length > 0) {
      index = 0;
      aluno = lista[0];
      nomeController.text = aluno._nome;
      nota1Controller.text = aluno._nota1.toString();
      nota2Controller.text = aluno._nota2.toString();
      mediaController.text = aluno._media.toStringAsFixed(1);
    }
  }

  // Métodos
  void _exibirRegistro(index) {
    if (index >= 0 && index < lista.length) {
      this.index = index;
      aluno = lista[index];
      nomeController.text = aluno._nome;
      nota1Controller.text = aluno._nota1.toString();
      nota2Controller.text = aluno._nota2.toString();
      mediaController.text = aluno._media.toStringAsFixed(1);
      setState(() {});
    }
  }

  void _atualizarDados() {
    if (index >= 0 && index < lista.length) {
      _edicaoHabilitada = false;
      lista[index]._nome = nomeController.text;
      lista[index]._nota1 = nota1Controller.text;
      lista[index]._nota2 = nota2Controller.text;
      lista[index]._media = lista[index].calcularMedia();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var titulo = "Informações do Aluno";
    if (aluno == null) {
      return Scaffold(
        appBar: AppBar(title: Text(titulo)),
        body: Column(
          children: <Widget>[
            Text("Nenhum aluno encontrado!"),
            Container(
              color: Colors.green,
              child: BackButton(),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text(titulo)),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  _edicaoHabilitada = true;
                  setState(() {});
                },
                tooltip: 'Primeiro',
                child: Text("Hab. Edição"),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                enabled: _edicaoHabilitada,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nome do aluno",
                  // hintText: "Nome do aluno",
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: nomeController,
              ),
            ),
            // --- Nota1 do aluno ---
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                enabled: _edicaoHabilitada,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Primeira nota",
                  // hintText: "primeira nota",
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: nota1Controller,
              ),
            ),
            // --- segunda nota ---
            Padding(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 20),
              child: TextField(
                enabled: _edicaoHabilitada,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Segunda nota",
                  hintText: "",
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: nota2Controller,
              ),
            ),
            // --- media (desabilitado) ---
            Padding(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 20),
              child: TextField(
                enabled: false,
                // keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "MEDIA",
                  hintText: "MEDIA",
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: mediaController,
              ),
            ),
            RaisedButton(
              child: Text(
                "Atualizar Dados",
                style: TextStyle(fontSize: _fontSize),
              ),
              onPressed: _atualizarDados,
            ),
            Text(
              "[${index + 1}/${lista.length}]",
              style: TextStyle(fontSize: 15.0),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <FloatingActionButton>[
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _exibirRegistro(0),
                    tooltip: 'Primeiro',
                    child: Icon(Icons.first_page),
                  ),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _exibirRegistro(index - 1),
                    tooltip: 'Primeiro',
                    child: Icon(Icons.navigate_before),
                  ),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _exibirRegistro(index + 1),
                    tooltip: 'Primeiro',
                    child: Icon(Icons.navigate_next),
                  ),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _exibirRegistro(lista.length - 1),
                    tooltip: 'Primeiro',
                    child: Icon(Icons.last_page),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//-----------------------------------------------------------------------------
// Tela: Buscar por Aluno
// ----------------------------------------------------------------------------

class TelaBuscarPorAluno extends StatefulWidget {
  @override
  _TelaBuscarPorAlunoState createState() => _TelaBuscarPorAlunoState();
}

class _TelaBuscarPorAlunoState extends State<TelaBuscarPorAluno> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Buscar por Aluno")),
    );
  }
}

//-----------------------------------------------------------------------------
// Tela: Cadastrar Aluno
// ----------------------------------------------------------------------------

class TelaCadastrarAluno extends StatefulWidget {
  final List<Aluno> lista;

  // Construtor
  TelaCadastrarAluno(this.lista);

  @override
  _TelaCadastrarAlunoState createState() =>
      _TelaCadastrarAlunoState(lista);
}

class _TelaCadastrarAlunoState extends State<TelaCadastrarAluno> {
  // Atributos
  final List<Aluno> lista;
  String _nome = "";
  double _nota1 = 0.0;
  double _nota2 = 0.0;
  double _fontSize = 20.0;
  final nomeController = TextEditingController();
  final nota1Controller = TextEditingController();
  final nota2Controller = TextEditingController();
  final mediaController = TextEditingController();

  // Construtor
  _TelaCadastrarAlunoState(this.lista);

  // Métodos
  void _cadastrarAluno() {
    _nome = nomeController.text;
    _nota1 = double.parse(nota1Controller.text);
    _nota2 = double.parse(nota2Controller.text);
    if (_nota1 > 0 && _nota2 > 0) {
      var aluno = Aluno(_nota1, _nota2, _nome);
    
      lista.add(aluno);
      // _index = lista.length - 1;
      nomeController.text = "";
      nota1Controller.text = "";
      nota2Controller.text = "";
      mediaController.text = "${aluno._media}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar Aluno"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Text(
                "Informações do aluno:",
                style: TextStyle(fontSize: _fontSize),
              ),
            ),
         
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nome do aluno",
                  // hintText: "Nome do aluno",
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: nomeController,
              ),
            ),
            // --- primeira nota do aluno ---
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Primeira nota",
                  // hintText: 'Primeira nota',
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: nota1Controller,
              ),
            ),
            // --- segunda nota ---
            Padding(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 20),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Segunda nota",
                  hintText: "",
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: nota2Controller,
              ),
            ),
          
            Padding(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 20),
              child: TextField(
                enabled: false,
                // keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "MEDIA",
                  hintText: "MEDIA",
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: mediaController,
              ),
            ),
            // Saída
            RaisedButton(
              child: Text(
                "Cadastrar Aluno",
                style: TextStyle(fontSize: _fontSize),
              ),
              onPressed: _cadastrarAluno,
            ),
          ],
        ),
      ),
    );
  }
}