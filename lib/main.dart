import 'package:flutter/cupertino.dart';

void main() {

  var firstDB = Database();
  var secondDB = Database();

  print('equality between [firstDB] and [secondDB] is ${(firstDB == secondDB)}');

  var model3 = BmwDesign(2, 4, 'aggresive, sport coupe', "model3");
  var model3Copy = model3.clone();
  var model3Rework = BmwDesign(2, 4, 'aggresive, sport coupe', "model3");

  print('[model3] ${model3.cloneStatus}');
  print('[model3Copy] ${model3Copy.cloneStatus}');
  print('[model3Rework] ${model3Rework.cloneStatus}');

  var myVehicle = Vehicle(
      brand: 'Volga',
      wheelCount: 6,
      engine: Engine(
        power: 59,
        type: EngineType.petrol,
      ));
  var myCar = Car(
      seatCount: 4,
      brand: 'Mercedes',
      wheelCount: 4,
      engine: Engine(
        power: 400,
        type: EngineType.petrol,
      ));

  print('My vehicle\'s power is ${myVehicle.engine.power}');
  myVehicle = VehicleEngineTuning().stageOneTuning(myVehicle);
  print('My vehicle\'s new power is ${myVehicle.engine.power}');

  (myVehicle is Car) ? print('my vehicle is a car !') : print('my vehicle is not a car !');
  (myCar is Vehicle) ? print('my car is a vehicle !') : print('my car is not a vehicle !');

  MercedesBuilder mercedesBuilder = MercedesBuilder();
  mercedesBuilder.createVehicle();
  var myBuiltVehicle = BuiltVehicle(mercedesBuilder);
  print(myBuiltVehicle.brand);
}

class Database {
  static final Database _db = Database._internal();

  factory Database() {
    return _db;
  }

  Database._internal();
}

abstract class CarDesign {
  String? name;
  int? wheelCount;
  String? style;

  dynamic clone();
}

class BmwDesign implements CarDesign {
  @override
  int? wheelCount;
  @override
  String? style;
  @override
  String? name;
  int? seatCount;
  int? _hashCode;
  bool isCloned = false;

  String get cloneStatus {
    return isCloned ? "this design is clone of $name" : "this design is original";
  }

  BmwDesign(this.seatCount, this.wheelCount, this.style, this.name);

  BmwDesign.fromSource(BmwDesign source) {
    seatCount = source.seatCount;
    name = source.name;
    wheelCount = source.wheelCount;
    _hashCode = source.hashCode;
    style = source.style;
    isCloned = true;
  }

  @override
  BmwDesign clone() {
    return BmwDesign.fromSource(this);
  }

  @override
  int get hashCode {
    if (_hashCode != null) return _hashCode!;
    _hashCode = DateTime.now().millisecondsSinceEpoch;
    return _hashCode!;
  }

  @override
  bool operator ==(dynamic other) {
    if (other is! BmwDesign) return false;
    BmwDesign bmwDesign = other;
    return bmwDesign.isCloned && bmwDesign.hashCode == hashCode;
  }
}

////////////////////////////////// Models //////////////////////////////////////

class Vehicle {
  String brand;
  int wheelCount;
  Engine engine;

  Vehicle({required this.brand, required this.wheelCount, required this.engine});
}

class Engine {
  int power;
  EngineType type;

  Engine({required this.power, required this.type});
}

class Car extends Vehicle {
  int seatCount;

  Car({
    required this.seatCount,
    required String brand,
    required int wheelCount,
    required Engine engine,
  }) : super(
          wheelCount: wheelCount,
          engine: engine,
          brand: brand,
        );
}

class BuiltVehicle {
  String brand;
  int wheelCount;
  Engine engine;

  BuiltVehicle(VehicleBuilder builder)
      : brand = builder.getVehicle().brand,
        wheelCount = builder.getVehicle().wheelCount,
        engine = builder.getVehicle().engine;
}

enum EngineType { diesel, petrol, electric }

////////////////////////////////// Models //////////////////////////////////////

////////////////////////////////// Builders //////////////////////////////////////

abstract class VehicleBuilder {
  @protected
  late Vehicle _vehicle;
  @protected
  late double price;

  void createVehicle() {
    _vehicle = Vehicle(brand: '', wheelCount: 0, engine: Engine(power: 0, type: EngineType.petrol));
  }

  Vehicle getVehicle() {
    return _vehicle;
  }

  void addWheels();

  void addInterior();

  void addBumpers();

  void addPainting();
}

class MercedesBuilder extends VehicleBuilder {
  MercedesBuilder() {
    price = 29999;
  }

  @override
  void createVehicle() {
    _vehicle = Car(seatCount: 2, brand: 'Mercedes', wheelCount: 4, engine: Engine(power: 670, type: EngineType.petrol));
  }

  @override
  void addBumpers() {}

  @override
  void addInterior() {}

  @override
  void addPainting() {}

  @override
  void addWheels() {}
}

class BMWBuilder extends VehicleBuilder {
  BMWBuilder() {
    price = 49999;
  }

  @override
  void createVehicle() {
    _vehicle = Car(seatCount: 2, brand: 'BMW', wheelCount: 4, engine: Engine(power: 670, type: EngineType.petrol));
  }

  @override
  void addBumpers() {}

  @override
  void addInterior() {}

  @override
  void addPainting() {}

  @override
  void addWheels() {}
}

////////////////////////////////// Builders //////////////////////////////////////

////////////////////////////////// Repositories //////////////////////////////////////

abstract class VehicleTuning {
  Vehicle stageOneTuning(Vehicle vehicle);

  Vehicle stageTwoTuning(Vehicle vehicle);
}

class VehicleEngineTuning implements VehicleTuning {
  @override
  Vehicle stageOneTuning(Vehicle vehicle) {
    var engine = vehicle.engine;
    var newEngine = Engine(
      power: (engine.power * 1.2).toInt(),
      type: engine.type,
    );
    return Vehicle(
      brand: vehicle.brand,
      wheelCount: vehicle.wheelCount,
      engine: newEngine,
    );
  }

  @override
  Vehicle stageTwoTuning(Vehicle vehicle) {
    var engine = vehicle.engine;
    var newEngine = Engine(
      power: (engine.power * 1.4).toInt(),
      type: engine.type,
    );
    return Vehicle(
      brand: vehicle.brand,
      wheelCount: vehicle.wheelCount,
      engine: newEngine,
    );
  }
}

////////////////////////////////// Repositories //////////////////////////////////////
