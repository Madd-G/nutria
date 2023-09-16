import 'package:connectivity_plus_platform_interface/connectivity_plus_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:mockito/mockito.dart';

const ConnectivityResult connectedToWifi = ConnectivityResult.wifi;
const ConnectivityResult connectedToMobile = ConnectivityResult.mobile;
const ConnectivityResult connectedToOther = ConnectivityResult.other;
const ConnectivityResult connectedToNone = ConnectivityResult.none;

class MockConnectivityPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements ConnectivityPlatform {
  @override
  Future<ConnectivityResult> checkWifiConnection() async {
    return connectedToWifi;
  }

  @override
  Future<ConnectivityResult> checkMobileConnection() async {
    return connectedToMobile;
  }

  @override
  Future<ConnectivityResult> checkOtherConnection() async {
    return connectedToOther;
  }

  @override
  Future<ConnectivityResult> checkConnection() async {
    return connectedToNone;
  }
}

void main() {
  group('Check Connectivity', () {
    late MockConnectivityPlatform connectivity;
    MockConnectivityPlatform fakePlatform;
    setUp(() async {
      fakePlatform = MockConnectivityPlatform();
      ConnectivityPlatform.instance = fakePlatform;
      connectivity = MockConnectivityPlatform();
    });

    test('check the Wifi Connection', () async {
      final result = await connectivity.checkWifiConnection();
      expect(result, connectedToWifi);
    });

    test('Check the Mobile Connection', () async {
      final result = await connectivity.checkMobileConnection();
      expect(result, connectedToMobile);
    });

    test('Check the Other Connection', () async {
      final result = await connectivity.checkOtherConnection();
      expect(result, connectedToOther);
    });
    test('No Connection', () async {
      final result = await connectivity.checkConnection();
      expect(result, connectedToNone);
    });
  });
}
