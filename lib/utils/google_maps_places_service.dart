import '../core/network/dio_helper.dart';
import '../features/route_tracking/models/place_autocomplete/place_model.dart';
import '../features/route_tracking/models/place_details/place_details_model.dart';

class GoogleMapsPlacesService {
  final String baseURL = 'https://places.googleapis.com/v1/places';

  Future<List<PlaceModel>> getPlaceAutocomplete({required String input}) async {
    final response = await DioHelper.postData(
      endPoint: '$baseURL:autocomplete',
      data: {'input': input},
    );

    if (response.statusCode == 200) {
      return (response.data['suggestions'] as List)
          .map((e) => PlaceModel.fromJson(e))
          .toList();
    } else {
      throw Exception(response.data['error']['message']);
    }
  }

  Future<PlaceDetailsModel> getPlaceDetails({
    required String placeId,
    String? fields,
  }) async {
    final response = await DioHelper.getData(
      endPoint: '$baseURL/$placeId',
      query: {'fields': fields ?? '*'},
    );

    if (response.statusCode == 200) {
      return PlaceDetailsModel.fromJson(response.data);
    } else {
      throw Exception(response.data['error']['message']);
    }
  }
}
