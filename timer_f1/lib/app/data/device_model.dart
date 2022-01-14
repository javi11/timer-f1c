class Device {
  final String id;
  String _name = 'Unknown device';
  int? rssi;

  DeviceConnectionState connectionState = DeviceConnectionState.disconnected;

  Device({required this.id, String? name, this.rssi}) {
    if (name != null) {
      _name = name;
    }
  }

  String get name {
    return _name == 'Unknown device' ? id : _name;
  }

  set name(String name) {
    _name = name;
  }

  @override
  String toString() => name == 'Unknown device' ? id : name;
}

enum DeviceConnectionState {
  connecting,
  connected,
  disconnecting,
  disconnected
}
