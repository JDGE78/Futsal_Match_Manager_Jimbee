import 'package:flutter/material.dart';
import 'package:futsal_match_manager/data.dart';
import 'package:futsal_match_manager/main.dart';

class PlayerList extends StatefulWidget {
  final playerAction;
  PlayerList({required this.playerAction});

  @override
  _PlayerListState createState() => _PlayerListState();
}

class _PlayerListState extends State<PlayerList> {
  bool isPlayerTeam = true;
  int count = 0;
// AQUI PONER CARGA DE BASE DE DATOS CON LA LISTA DE JUGADORES!!
  /* final List _Players = [
    Players(28, "Dani", 0, 0, 0, 0),
    Players(18, "Mi nani", 0, 0, 0, 0),
    Players(1, "Wobbeh", 0, 0, 0, 0),
    Players(3, "Fluchus", 0, 0, 0, 0),
  ];*/

//AÑADO 20 JUGADORES RIVALES
  final List<RivalPlayers> rivalPlayers = List.generate(
    20,
    (index) => RivalPlayers(index + 1, "Jugador rival ${index + 1}"),
  );

  final List _MinorityReportList = MyApp.MinorityReportList;

  // Crear una instancia de la clase PlayersDatabase
  PlayersDatabase databaseActions = PlayersDatabase();
  static List<Players> playerList =
      []; //playerListMap = para acceder al index desde cualquier parte

  @override
  void initState() {
    super.initState();
    loadPlayersFromDatabase();
  }

  Future<void> loadPlayersFromDatabase() async {
    List<Players> loadedPlayers = await databaseActions.loadPlayers();
    setState(() {
      playerList = loadedPlayers;
      isPlayerTeam = SideTeam(widget.playerAction.toString());
      count = isPlayerTeam ? playerList.length : rivalPlayers.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        backgroundColor: appBarBack(widget.playerAction),
        title: Text(showActionText(widget.playerAction, isPlayerTeam)),
      ),
      body: ListView.builder(
          itemCount: count,
          itemBuilder: (BuildContext context, int index) {
            var item;
            if (isPlayerTeam) {
              item = playerList[index];
            } else {
              item = rivalPlayers[index];
            }
            return ListTile(
              title: Text(
                item.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  fontSize: 20,
                ),
              ),
              subtitle: Text(
                '${item.dorsal}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  fontSize: 40,
                ),
              ),
              onTap: () {
                _MinorityReportList.add(generateAction(
                    widget.playerAction,
                    MyApp.timeReport,
                    isPlayerTeam
                        ? playerList[index].dorsal
                        : rivalPlayers[index].dorsal,
                    isPlayerTeam
                        ? playerList[index].name
                        : rivalPlayers[index].name,
                    isPlayerTeam));
                Navigator.of(context).pop();
              },
            );
          }),
    );
  }

  Color appBarBack(dynamic txt) {
    switch (txt) {
      case PlayerAction.localYellow:
        return Colors.yellow;
      case PlayerAction.localRed:
        return Colors.red;
      case PlayerAction.localGoal:
        return Colors.greenAccent;
      case PlayerAction.guestYellow:
        return Colors.yellow;
      case PlayerAction.guestRed:
        return Colors.red;
      case PlayerAction.guestGoal:
        return Colors.grey;

      default:
        return Colors.blue;
    }
  }
}
