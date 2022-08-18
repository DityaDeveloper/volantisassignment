class MasterUri {
  static BaseUrl get baseUrl => BaseUrl();
  static StorageUri get storageUrl => StorageUri();
  static PathWheather get pathWeather => PathWheather();
}

class BaseUrl {
  String get prodUrl => "https://aerisweather1.p.rapidapi.com";
}

class StorageUri {
  String get storage => "https://cdn.aerisapi.com/wxicons/v2/";
}

class PathWheather {
  String get dailyforecast => "forecasts";
  String get daily => "conditions";
  String get observation => "observations";
  String get jkt => "jakarta,id";
}
