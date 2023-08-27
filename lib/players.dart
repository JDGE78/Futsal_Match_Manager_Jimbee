/// PANTALLA CONFECCIONAMIENTO PLANTILLA
import 'package:flutter/material.dart';
import 'package:futsal_match_manager/data.dart';

class Player extends StatefulWidget {
  const Player({Key? key}) : super(key: key);

  @override
  _SelectScreenState createState() => _SelectScreenState();
}

class _SelectScreenState extends State<Player> {
  final TextEditingController dorsalController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController goalsController = TextEditingController();
  final TextEditingController foulsController = TextEditingController();
  final TextEditingController yellowCardsController = TextEditingController();
  final TextEditingController redCardsController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  PlayersDatabase databaseActions = PlayersDatabase();
  late Future<List<Players>> _future;

  @override
  void initState() {
    super.initState();
    _future = databaseActions.loadPlayers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: resetTexts,
        child: const Icon(
          Icons.person_add,
          size: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      appBar: AppBar(
        shadowColor: Colors.red,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.04,
        backgroundColor: Colors.black26,
        centerTitle: true,
        title: const SizedBox(
          height: 30,
          child: Text(
            "Jugadores",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey[300],
              child: FutureBuilder<List<Players>>(
                future: _future,
                builder: (BuildContext context,
                    AsyncSnapshot<List<Players>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final player = snapshot.data![index];
                          return ListTile(
                            onTap: () {
                              fillTextFields(player);
                            },
                            leading: Text(
                              player.dorsal.toString(),
                              textAlign: TextAlign.center,
                            ),
                            title: Text(
                              player.name,
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text(
                        'Error: ${snapshot.error}',
                        textAlign: TextAlign.center,
                      );
                    } else {
                      return const Text(
                        'No hay datos',
                        textAlign: TextAlign.center,
                      );
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey[100],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Datos del jugador",
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 10),
                  Form(
                    key: _formKey,
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: TextFormField(
                            controller: dorsalController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: "Dorsal",
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Por favor ingrese un valor';
                              } else if (int.tryParse(value) == null) {
                                return 'Por favor ingrese un número válido';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          flex: 3,
                          child: TextFormField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              labelText: "Nombre del jugador",
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Por favor ingrese un valor';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      "Estadísticas del jugador",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: goalsController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Goles",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor ingrese un valor';
                            } else if (int.tryParse(value) == null) {
                              return 'Por favor ingrese un número válido';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: foulsController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Faltas",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor ingrese un valor';
                            } else if (int.tryParse(value) == null) {
                              return 'Por favor ingrese un número válido';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: yellowCardsController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Tarjetas amarillas",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor ingrese un valor';
                            } else if (int.tryParse(value) == null) {
                              return 'Por favor ingrese un número válido';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: redCardsController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Tarjetas rojas",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor ingrese un valor';
                            } else if (int.tryParse(value) == null) {
                              return 'Por favor ingrese un número válido';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton.icon(
                      onPressed: onPressetSave,
                      icon: const Icon(Icons.save),
                      label: const Text('Guardar'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Expanded(
            child: SizedBox(),
          )
        ],
      ),
    );
  }

  void onPressetSave() async {
    int dorsal = int.parse(dorsalController.text);
    String name = nameController.text;
    int goals = int.parse(goalsController.text);
    int fouls = int.parse(foulsController.text);
    int yellowCards = int.parse(yellowCardsController.text);
    int redCards = int.parse(redCardsController.text);

    if (_formKey.currentState!.validate()) {
      await databaseActions.insertPlayer(
        Players(
          dorsal: dorsal,
          name: name,
          goals: goals,
          fouls: fouls,
          yellowCards: yellowCards,
          redCards: redCards,
        ),
      );

      resetTexts();
      setState(() {
        _future = databaseActions.loadPlayers();
      });
    }
  }

  void resetTexts() {
    dorsalController.clear();
    nameController.clear();
    goalsController.clear();
    foulsController.clear();
    yellowCardsController.clear();
    redCardsController.clear();
  }

  void fillTextFields(Players player) {
    dorsalController.text = player.dorsal.toString();
    nameController.text = player.name;
    goalsController.text = player.goals.toString();
    foulsController.text = player.fouls.toString();
    yellowCardsController.text = player.yellowCards.toString();
    redCardsController.text = player.redCards.toString();
  }
}
