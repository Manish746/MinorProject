import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zarees/models/Cart_Local_Model.dart';

import '../constants.dart';

hiveInitializing() async {
  Directory directory = await getApplicationDocumentsDirectory();

  Hive.init(directory.path);

  //type adapter registration
  //Hive.registerAdapter(CartModelAdapter());
  Hive.registerAdapter(LocalCartModelAdapter());

  //Open Hive box
  //await Hive.openBox<CartModel>(boxCart);
  return await Hive.openBox<LocalCartModel>(localCartBox);
}
