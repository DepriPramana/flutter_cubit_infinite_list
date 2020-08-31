class Api {
  static const String BASE_URL = 'https://newsapi.org/v2/everything';
  static const String KEY = '06ccca1eef564f8589cfdea0192122aa';

  static String search({String keyword='', int page=1, int limit=20}) {
    return '$BASE_URL?q=$keyword&page=$page&pageSize=$limit&apiKey=$KEY';
  }
}