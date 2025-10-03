import '../core/network/dio_helper.dart';
import '../features/route_tracking/models/place_autocomplete_model.dart';

class GoogleMapsPlacesService {
  final String baseURL = 'https://places.googleapis.com/v1/places';

  Future<List<PlaceAutocompleteModel>> getPlaceAutocomplete({
    required String input,
  }) async {
    final response = await DioHelper.postData(
      endPoint: '$baseURL:autocomplete',
      data: {'input': input},
    );

    if (response.statusCode == 200) {
      return (response.data['suggestions'] as List)
          .map((e) => PlaceAutocompleteModel.fromJson(e))
          .toList();
    } else {
      throw Exception(response.data['error']['message']);
    }
  }
}
