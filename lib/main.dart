import 'package:flutter/material.dart';
import 'Usuario.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Form Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new FormPage(title: 'Flutter Form Demo'),
    );
  }
}

class FormPage extends StatefulWidget {
  FormPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final usuario = Usuario();

  int selectedRadio;

  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  String _validarEmail(String value) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Informe o Email";
    } else if (!regExp.hasMatch(value)) {
      return "Email inválido";
    } else {
      return null;
    }
  }

  _setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  bool _isChecked = false;

  void onChanged(bool value) {
    setState(() {
      _isChecked = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration:
                      InputDecoration(labelText: 'Nome', hintText: 'Jane Doe'),
                  validator: (input) =>
                      input.length < 5 ? 'Nome invalido' : null,
                  onSaved: (input) => usuario.nome = input,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: 'Email', hintText: 'janedoe@hotmail.com'),
                  validator: _validarEmail,
                  onSaved: (input) => usuario.email = input,
                ),
                Row(
                  children: <Widget>[
                    Text('Masculino'),
                    Radio(
                      value: 0,
                      groupValue: selectedRadio,
                      onChanged: (int val) {
                        _setSelectedRadio(val);
                        usuario.sexo = selectedRadio;
                      },
                    ),
                    Text('Feminino'),
                    Radio(
                      value: 1,
                      groupValue: selectedRadio,
                      onChanged: (val) {
                        _setSelectedRadio(val);
                        usuario.sexo = selectedRadio;
                      },
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: _isChecked,
                      onChanged: (bool value) {
                        onChanged(value);
                        usuario.aceito = _isChecked;
                      },
                    ),
                    Text('Aceito os termos de uso'),
                  ],
                ),
                Container(
                  child: new RaisedButton(
                    child: new Text(
                      'Salvar',
                      style: new TextStyle(color: Colors.white),
                    ),
                    onPressed: this.submit,
                    color: Colors.blue,
                  ),
                  margin: new EdgeInsets.only(top: 20.0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submit() {
    // First validate form.
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.

      print(usuario);
    }
  }
}
