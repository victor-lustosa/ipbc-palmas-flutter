
abstract class ILyricsUseCases <T> {
  Stream<List<T>> get(String url);
  Future<List<T>> lettersFilter(
      List<T> lyrics, String letter);
}


