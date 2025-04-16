class RelatorioModel {
  String id;
  String turno;
  String linha;
  String nrAviario;
  String qtRecebidas;
  String deathTransporte;
  String avesAbatidas;
  String codCondena;
  String tpCondena;
  String descCondena;
  String qtDoenca;
  String nrLote;
  String especifDoencas;

  RelatorioModel({
    required this.id,
    required this.turno,
    required this.linha,
    required this.nrAviario,
    required this.qtRecebidas,
    required this.deathTransporte,
    required this.avesAbatidas,
    required this.codCondena,
    required this.tpCondena,
    required this.descCondena,
    required this.qtDoenca,
    required this.nrLote,
    required this.especifDoencas,
  });

  RelatorioModel.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        turno = map["turno"],
        linha = map["linha"],
        nrAviario = map["nrAviario"],
        qtRecebidas = map["qtRecebidas"],
        deathTransporte = map["deathTransporte"],
        avesAbatidas = map["avesAbatidas"],
        codCondena = map["codCondena"],
        tpCondena = map["tpCondena"],
        descCondena = map["descCondena"], // Corrigindo o nome do campo
        qtDoenca = map["qtDoenca"],
        nrLote = map["nrLote"],
        especifDoencas = map["especifDoencas"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "turno": turno,
      "linha": linha,
      "nrAviario": nrAviario,
      "qtRecebidas": qtRecebidas,
      "deathTransporte": deathTransporte,
      "avesAbatidas": avesAbatidas,
      "codCondena": codCondena,
      "tpCondena": tpCondena,
      "descCondena": descCondena,
      "qtDoenca": qtDoenca,
      "nrLote": nrLote,
      "especifDoencas": especifDoencas,
    };
  }
}
