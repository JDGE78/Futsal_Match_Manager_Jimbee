//* DATOS GLOBALES DE LA APP
import 'package:futsal_match_manager/main.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//* INFORME DE EVENTOS
class MinorityReport {
  String event;
  MinorityReport(this.event);
}
class reset {
  void resetVals()
  {
    MyApp.localGoal = 0;
    MyApp.guestGoal = 0;
    MyApp.localFouls = 0;
    MyApp.guestFouls = 0;
    MyApp.localTimeOut = false;
    MyApp.guestTimeOut = false;
    MyApp.localYellowsCards = 0;
    MyApp.guestYellowsCards = 0;
    MyApp.localRedCards = 0;
    MyApp.guestRedCards = 0;
    MyApp.matchMinutes = 20;
    MyApp.matchHour = "";
    MyApp.matchPeriod =    1; //? SOLO CON VALORES 1 O 2, DEPENDIENDO DE LA PARTE DEL PARTIDO
    MyApp.matchTime = "12:00";
    MyApp.rival = "";
    MyApp.isLocal = true;
    MyApp.endMatch = false;
    //* PARA INFORME DE EVENTOS
    MyApp.textMinorityReport = "";
    MyApp.MinorityReportList = [];
    MyApp.timeReport = "";
    MyApp.period = 1; //añadido V1
  }
}
//* PARA INFORME: SUMATORIO DE GOLES, TARJETAS TOTALES ETC
class Matches {
  String matchDate;
  String rivalTeam;
  int localGoals;
  int guestGoals;
  int localFouls;
  int guestFouls;
  int localYellowCards;
  int localRedCards;
  int guestYellowCards;
  int guestRedCards;

  Matches(
      this.matchDate,
      this.rivalTeam,
      this.localGoals,
      this.guestGoals,
      this.localFouls,
      this.guestFouls,
      this.localYellowCards,
      this.localRedCards,
      this.guestYellowCards,
      this.guestRedCards);
}

class Players {
  late final int dorsal;
  final String name;
  final int goals;
  final int fouls;
  final int yellowCards;
  final int redCards;

  //static List<Players> playerListMap =
  //[]; //playerListMap = para acceder al index desde cualquier parte

  Players({
    required this.dorsal,
    required this.name,
    required this.goals,
    required this.fouls,
    required this.yellowCards,
    required this.redCards,
  });

  // Convert a Player into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'dorsal': dorsal,
      'name': name,
      'goals': goals,
      'fouls': fouls,
      'yellowCards': yellowCards,
      'redCards': redCards,
    };
  }
}

class RivalPlayers {
  late final int dorsal;
  final String name;
  RivalPlayers(this.dorsal, this.name);
}

//* LISTA PARA MOSTRAR CUANDO GOL Y TARJETAS
enum PlayerAction {
  localYellow,
  localRed,
  localGoal,
  localFoul,
  localDouble,
  localTimeOut,
  guestYellow,
  guestRed,
  guestGoal,
  guestFoul,
  guestDouble,
  guestTimeOut
}

//*AÑADIR EVENTO AL INFORME
//*CREO ACCION: "12:12- GOL DE XXX "...
String generateAction(
    dynamic txt, String time, int dorsal, String name, bool _sideTeam) {
  if (_sideTeam) {
    return "${"$time- " + showActionText(txt, _sideTeam)} de $name ($dorsal)";
  } else {
    return "${"$time- " + showActionText(txt, _sideTeam)} con dosal $dorsal";
  }
}

dynamic showActionText(dynamic txt, bool _sideTeam) {
  switch (txt) {
    case PlayerAction.localYellow:
      if (_sideTeam) {
        return "Tarjeta Amarilla";
      } else {
        return "Tarjeta Amarilla para el rival";
      }
    case PlayerAction.guestYellow:
      if (_sideTeam) {
        return "Tarjeta Amarilla";
      } else {
        return "Tarjeta Amarilla para el rival";
      }
    case PlayerAction.localRed:
      if (_sideTeam) {
        return "Tarjeta Roja";
      } else {
        return "Tarjeta Roja para el rival";
      }
    case PlayerAction.guestRed:
      if (_sideTeam) {
        return "Tarjeta Roja";
      } else {
        return "Tarjeta Roja para el rival";
      }

    case PlayerAction.localGoal:
      if (_sideTeam) {
        return "Gol";
      } else {
        return "Gol del rival";
      }
    case PlayerAction.guestGoal:
      if (_sideTeam) {
        return "Gol";
      } else {
        return "Gol del rival";
      }
    case PlayerAction.localFoul:
      return "Falta ";
    case PlayerAction.guestFoul:
      return "Falta ";

    case PlayerAction.localDouble:
      return "Doble penalty a favor ";
    case PlayerAction.guestDouble:
      return "Doble penalty a favor ";

    default:
      return "cero patatero: $txt";
  }
}

//COMPRUEBO SI EL EQUIPO ESTÁ COMO LOCAL O GUEST PARA CONTROLAR EL LISTADO DE JUGADORES
//SI ES TRUE MUESTRO LOCAL Y SI ES FALSE, EL GUEST
bool SideTeam(String txt) {
  if (MyApp.isLocal && txt.contains("local") ||
      (MyApp.isLocal == false && !txt.contains("local"))) {
    return true;
  } else {
    return false;
  }
}

class PlayersDatabase {
  Future<Database> _database() async {
    return openDatabase(
      // Set the path to the database.
      join(await getDatabasesPath(), 'futsaldatabse.db'),

      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE tPlayers(dorsal INTEGER PRIMARY KEY, name TEXT, goals INTEGER, fouls INTEGER, yellowCards INTEGER, redCards INTEGER)',
        );
      },

      // Set the version of the database. This executes the onCreate function
      // and provides a path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  // Helper method to insert a Player into the database.
  Future<void> insertPlayer(Players player) async {
    // Get a reference to the database.
    final Database db = await _database();

    try {
      await db.insert(
        'tPlayers',
        player.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('MENSAJE: Registro añadido!');
    } catch (e) {
      print('MENSAJE: Error al añadir registro: $e');
    }
  }

  // Helper method to retrieve all Players from the database.
  Future<List<Players>> loadPlayers() async {
    final Database db = await _database();
    final List<Map<String, dynamic>> maps = await db.query('tPlayers');

    // Convert the List<Map<String, dynamic> into a List<Player>.
    return List.generate(
      maps.length,
      (i) {
        return Players(
          dorsal: maps[i]['dorsal'],
          name: maps[i]['name'],
          goals: maps[i]['goals'],
          fouls: maps[i]['fouls'],
          yellowCards: maps[i]['yellowCards'],
          redCards: maps[i]['redCards'],
        );
      },
    );
  }

  // Helper method to update a Player.
  Future<void> updatePlayer(Players player) async {
    // Get a reference to the database.
    final db = await _database();

    // Update the given Player.
    await db.update(
      'tPlayers',
      player.toMap(),
      // Ensure that the Player has a matching dorsal.
      where: 'dorsal = ?',
      // Pass the Player's dorsal as a whereArg to prevent SQL injection.
      whereArgs: [player.dorsal],
    );
  }

  // Helper method to delete a Player from the database.
  Future<void> deletePlayer(int dorsal) async {
    // Get a reference to the database.
    final db = await _database();

    // Remove the Player from the database.
    await db.delete(
      'tPlayers',
      // Use a `where` clause to delete a specific Player.
      where: 'dorsal = ?',
      // Pass the Player's dorsal as a whereArg to prevent SQL injection.
      whereArgs: [dorsal],
    );
  }
}
///AQUI:  PORQUE NO CARGA ESTA FUNCION???