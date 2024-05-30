import 'ApiConfig.dart';

class ApiRoute {
  static Future loadAgents(){
    return ApiConfig.get("agents");
  }

  static Future loadMaps() {
    return ApiConfig.get("maps");
  }

  static Future detailAgent(uuid){
    return ApiConfig.get("agents/$uuid");
  }

}