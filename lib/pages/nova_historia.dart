import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

class NovaHistoria extends StatefulWidget {
  const NovaHistoria({ Key? key }) : super(key: key);

  @override
   NovaHistoriaState createState() =>  NovaHistoriaState();
}

class  NovaHistoriaState extends State<NovaHistoria> {
  var txtTitulo = TextEditingController();
  var txtSubtitulo = TextEditingController();
  var txtAutor = TextEditingController();
  var txtSinopse = TextEditingController();
  //
  // RETORNAR um ÚNICO DOCUMENTO a partir do ID
  //
  getDocumentById(id) async{
    await FirebaseFirestore.instance.collection('Historias')
      .doc(id).get().then((doc) {
        txtTitulo.text = doc.get('titulo');
        txtSubtitulo.text = doc.get('subtitulo');
        txtAutor.text = doc.get('autor');
        txtSinopse.text = doc.get('sinopse');
      });
  }
 
 
  @override
  Widget build(BuildContext context) {
  
  //
    // RECUPERAR o ID do Café que foi selecionado pelo usuário
    //
    var id = ModalRoute.of(context)?.settings.arguments;

    if (id != null){
      if (txtTitulo.text.isEmpty && txtSubtitulo.text.isEmpty && txtAutor.text.isEmpty && txtSinopse.text.isEmpty){
        getDocumentById(id);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Biblioteca_S2'),
        centerTitle: true,
        backgroundColor: Colors.green.shade600,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.green.shade400,
      body: Container(
        padding: EdgeInsets.all(30),
        child: ListView(children: [
          TextField(
            controller: txtTitulo,
            style: TextStyle(color: Colors.yellow, fontSize: 36),
            decoration: InputDecoration(
              labelText: 'Titulo',
              labelStyle: TextStyle(color: Colors.yellow, fontSize: 22),
            ),
          ),
          SizedBox(height: 30),
          TextField(
            controller: txtSubtitulo,
            style: TextStyle(color: Colors.yellow, fontSize: 36),
            decoration: InputDecoration(
              labelText: 'Subtitulo',
              labelStyle: TextStyle(color: Colors.yellow, fontSize: 22),
            ),
          ),
          SizedBox(height: 50),
          TextField(
            controller: txtAutor,
            style: TextStyle(color: Colors.yellow, fontSize: 36),
            decoration: InputDecoration(
              labelText: 'Autor',
              labelStyle: TextStyle(color: Colors.yellow, fontSize: 22),
            ),
          ),
          SizedBox(height: 50),

         /* TextFormField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(10),
      ]
    )*/
          TextField(
            maxLines: 5,
            maxLength: 100,
            controller: txtSinopse,
            style: TextStyle(color: Colors.yellowAccent, fontSize: 36),
            decoration: InputDecoration(
              labelText: 'Sinopse',
              labelStyle: TextStyle(color: Colors.yellow, fontSize: 22),
            ),
          ),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                width: 150,
                child: ElevatedButton(
                   child: Text('Salvar',
                   style: TextStyle(
                           color: Colors.orange),
                      textAlign: TextAlign.center,
                      ),
                  onPressed: () {

                    if (id == null){
                      //
                      // ADICIONAR um NOVO DOCUMENTO
                      //
                      FirebaseFirestore.instance.collection('Historias').add({
                        'autor': txtAutor.text,
                        'sinopse': txtSinopse.text,
                        'subtitulo': txtSubtitulo.text,
                        'titulo': txtTitulo.text,
                      });
                    }else{
                      //
                      // ATUALIZAR UM DOCUMENTO EXISTENTE
                      //
                      FirebaseFirestore.instance.collection('Historias').doc(id.toString()).set({
                         'autor': txtAutor.text,
                        'sinopse': txtSinopse.text,
                        'subtitulo': txtSubtitulo.text,
                        'titulo': txtTitulo.text,
                      });
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Operação realizada com sucesso!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    Navigator.pop(context);
                    
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                width: 150,
                child: ElevatedButton(
                   child: Text('cancelar',
                   style: TextStyle(
                           color: Colors.orange),
                      textAlign: TextAlign.center,
                      ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ]),
      ),
    );

  }
}