class AssetsMap {
  static const String placeholder = 'assets/placeholder.png';
  
  static const Map<String, String> sceneBackgrounds = {
    'scene_quarto': 'assets/bedroom.png',
    'scene_janela': 'assets/window.png',
    'scene_sala': 'assets/living_room.png',
    'scene_janela_sala': 'assets/window_living_room.png',
    'scene_cozinha': 'assets/kitchen.png',
    'scene_banheiro': 'assets/bathroom.png',
    'scene_rua_principal': 'assets/street_day.png',
    'scene_beco': 'assets/ruines.png',
    'scene_ruinas': 'assets/deep_ruines.png',
    'scene_perimetro_exclusao': 'assets/perimeter.png',
    'scene_distrito_sucateiros': 'assets/scrapyard_district.png',
    'scene_arquivo_morto': 'assets/municipal_archive.png',
    'scene_floresta_estatica': 'assets/static_forest.png',
    'scene_apartamento_kael': 'assets/kael_apartment.png',
    'scene_escola_abandonada': 'assets/abandoned_school.png',
    'scene_escola_diretoria': 'assets/school_office.png',
    'scene_escola_subsolo': 'assets/school_basement.png',
    'scene_torre_base': 'assets/tower_base.png',
    'scene_observatorio_antigo': 'assets/old_observatory.png',
    'scene_torre_topo': 'assets/tower_apex.png',
  };

  static String getBackgroundForScene(String sceneId) {
    return sceneBackgrounds[sceneId] ?? placeholder;
  }

  static bool isAssetMissing(String assetPath) {
    return assetPath == placeholder || !_existingAssets.contains(assetPath);
  }

  static const Set<String> _existingAssets = {
    'assets/abandoned_school.png',
    'assets/bathroom.png',
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
}
