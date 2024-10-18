import 'package:get_storage/get_storage.dart';

class StorageUtils {
  final box = GetStorage();

  Future<dynamic>getStroreByKey(String key)async{
    var obj = await box.read(key);
    return obj;
  } 
  
  Future<void>setStroreByKey(String key,dynamic data)async{
    await box.write(key,data);
  }
  Future<void>deleteStroreByKey(String key)async{
    await box.remove(key);
  }
}