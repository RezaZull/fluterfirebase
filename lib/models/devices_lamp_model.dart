class DevicesLampModel {
  String name;
  bool flagOn;
  DevicesLampModel({
    required this.name,
    required this.flagOn,
  });

  factory DevicesLampModel.fromMap(Map<dynamic, dynamic> map) {
    return DevicesLampModel(name: map['name'], flagOn: map['flagOn']);
  }
}
