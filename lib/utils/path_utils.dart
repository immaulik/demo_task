import 'package:path_provider/path_provider.dart';

class PathUtils {
  PathUtils._();

  static PathUtils? _instance;
  static String? temp;

  /// one time initial
  static PathUtils get instance{
    _instance ??= PathUtils._();
    return _instance!;
  }

  Future<String> getTempDir()async{
    return temp ??= (await getTemporaryDirectory()).path;
  }
}