import 'package:flutter/foundation.dart';

class AssetService {
  static const Set<String> knownAssets = {
    'assets/abandoned_school.png',
    'assets/bathroom.png',
    'assets/bedroom.png',
    'assets/deep_ruines.png',
    'assets/kael_apartment.png',
    'assets/kitchen.png',
    'assets/living_room.png',
    'assets/municipal_archive.png',
    'assets/old_observatory.png',
    'assets/perimeter.png',
    'assets/placeholder.png',
    'assets/ruines.png',
    'assets/scrapyard_district.png',
    'assets/school_basement.png',
    'assets/school_office.png',
    'assets/static_forest.png',
    'assets/street_day.png',
    'assets/tower_apex.png',
    'assets/tower_base.png',
    'assets/window_living_room.png',
    'assets/window.png',
  };

  static bool isAssetAvailable(String assetPath) {
    return knownAssets.contains(assetPath);
  }

  static List<String> getMissingAssets(List<String> assetPaths) {
    return assetPaths.where((path) => !isAssetAvailable(path)).toList();
  }

  static void logAssetStatus(String assetPath) {
    if (kDebugMode) {
      final status = isAssetAvailable(assetPath) ? 'OK' : 'MISSING';
      print('Asset $assetPath: $status');
    }
  }
}
