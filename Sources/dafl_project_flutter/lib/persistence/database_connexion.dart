import '../model/user.dart';
import 'package:postgresql2/constants.dart';
import 'package:postgresql2/pool.dart';
import 'package:postgresql2/postgresql.dart';

class DatabaseConnexion{
  String? psqlUser = 'postgres';
  String? psqlPswd = 'mdpDaflBd';
  String? psqlHost = '89.83.54.48';
  String? psqlDataBase = 'BD-DaflMusic';


  //Initialise connexion to the database
  Future<Connection> initConnexion(){
    var uri = 'postgres://$psqlUser:$psqlPswd@$psqlHost:5442/$psqlDataBase';

    return connect(uri);
  }

}