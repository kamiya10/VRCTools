import 'package:vrctools/api/vrc_api_container_impl_native.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class VrcApiContainer {
  Future<VrchatDart> create() async {
    return VrcApiContainerImpl().create();
  }
}
