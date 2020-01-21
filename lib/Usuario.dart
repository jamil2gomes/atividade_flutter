class Usuario {
  String _nome;
  int _sexo;
  String _email;
  bool _aceito;

  set nome(String nome) => this._nome = nome;
  set email(String email) => this._email = email;
  set sexo(int valor) => this._sexo = valor;
  set aceito(bool valor) => this._aceito = valor;

  @override
  String toString() {
    return 'Usuario com nome: $_nome com email: $_email e do sexo ${_sexo == 0 ? "masculino" : "feminino"}'
        ' ${_aceito == true ? "aceita " : "não aceita "} os termos de contrato';
  }
}
