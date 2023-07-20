import 'package:flutter_test/flutter_test.dart';
import 'package:untitled3/untitled3.dart';
import 'package:untitled3/untitled3_platform_interface.dart';
import 'package:untitled3/untitled3_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockUntitled3Platform
    with MockPlatformInterfaceMixin
    implements Untitled3Platform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final Untitled3Platform initialPlatform = Untitled3Platform.instance;

  test('$MethodChannelUntitled3 is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelUntitled3>());
  });

  test('getPlatformVersion', () async {
    Untitled3 untitled3Plugin = Untitled3();
    MockUntitled3Platform fakePlatform = MockUntitled3Platform();
    Untitled3Platform.instance = fakePlatform;

    expect(await untitled3Plugin.getPlatformVersion(), '42');
  });
}
