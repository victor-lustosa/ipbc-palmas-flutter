
import 'package:http/http.dart' as http;

import '../../../shared/mixins/location_extractor_mixin.dart';

abstract class IGetLocationFromUrl {
  Future<dynamic> getLocationFromUrl({required String url});
}

abstract class IEventRepository implements IGetLocationFromUrl {}

class EventRepository with LocationExtractorMixin implements IEventRepository {
  @override
  Future<dynamic> getLocationFromUrl({required String url}) async {
    final client = http.Client();
    try {
      final request = http.Request('GET', Uri.parse(url));
      request.followRedirects = false;
      final streamedResponse = await client.send(request);

      if (streamedResponse.isRedirect) {
        final location = streamedResponse.headers['location'];
        if (location != null) {
          return extractLatLng(location);
        }
      }
      return null;
    } finally {
      client.close();
    }
  }
}
