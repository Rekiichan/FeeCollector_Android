import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:thu_phi/dbhelper/MongoDBModel.dart';
import 'constant.dart';

class MongoDatabase{
  static var db, userCollection;
  static var db2, userCollection2;

  static connect() async{
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_COLLECTION);
  }

  static Future<List<Map<String,dynamic>>> getData() async {
    final arrData =  await userCollection.find().toList();
    return arrData;
  }

  static Future<List<Map<String,dynamic>>> getData2() async {
    final arrData =  await userCollection2.find().toList();
    return arrData;
  }

  static Future<String> insert(MongoDbModel data) async {
    try{
      var result = await userCollection.insertOne(data.toJson());
      if (result.isSuccess){
        return "success";
      } else return "failure";
    } catch(e){
      print(e.toString());
      return e.toString();
    }
  }

  static delete(MongoDbModel user) async{
    await userCollection.remove(where.id(user.id));
  }

}