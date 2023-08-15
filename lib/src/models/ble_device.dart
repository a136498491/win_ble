import 'dart:convert';

import 'dart:typed_data';

BleDevice bleDeviceFromJson(String str) => BleDevice.fromJson(json.decode(str));

String bleDeviceToJson(BleDevice data) => json.encode(data.toJson());

class BleDevice {
  BleDevice(
      {required this.address,
      required this.rssi,
      required this.timestamp,
      required this.advType,
      required this.name,
      required this.serviceUuids,
      required this.manufacturerData,
      required this.adStructures});

  String address;
  String name;
  String rssi;
  String timestamp;
  String advType;
  Uint8List manufacturerData;
  List<dynamic> serviceUuids;
  List<AdStructure> adStructures;

  factory BleDevice.fromJson(Map<String, dynamic> json) => BleDevice(
        address: json["bluetoothAddress"] ?? "",
        rssi: json["rssi"]?.toString() ?? "",
        timestamp: json["timestamp"]?.toString() ?? "",
        advType: json["advType"] ?? "",
        name: json["localName"] ?? "",
        serviceUuids: json["serviceUuids"],
        manufacturerData: json["manufacturerData"] != null
            ? Uint8List.fromList(List<int>.from(json["manufacturerData"]))
            : Uint8List.fromList(List.empty()),
        adStructures: json["adStructures"] == null
            ? []
            : List<AdStructure>.from(json["adStructures"].map((x) =>
                AdStructure(type: x["type"], data: List<int>.from(x["data"])))),
      );

  Map<String, dynamic> toJson() => {
        "bluetoothAddress": address,
        "rssi": rssi,
        "timestamp": timestamp,
        "advType": advType,
        "localName": name,
        "serviceUuids": serviceUuids,
        "manufacturerData": manufacturerData.toString(),
        "adStructures": adStructures,
      };
}

class AdStructure {
  int type;
  List<int> data;
  AdStructure({required this.type, required this.data});
  toJson() => {
    "type": type,
    "data": data,
  };
  @override
  String toString() {
    return toJson().toString();
  }
}
