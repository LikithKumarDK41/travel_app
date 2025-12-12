import '../models/shortcut_model.dart';
import '../models/tour_model.dart';
import 'api_service.dart';

class TourRepository {
  Future<List<Tour>> fetchTours() async {
    try {
      // Endpoint is '/tours' based on user request (v1/tours)
      final response = await apiService.get('/tours');

      if (response.data != null && response.data['tours'] != null) {
        final List results = response.data['tours']['results'];
        return results.map((e) => Tour.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      // Errors are already logged by interceptor potentially, or rethrow
      throw Exception("Failed to load tours: $e");
    }
  }

  Future<List<Shortcut>> fetchShortcuts() async {
    try {
      final response = await apiService.get('/shortcuts');
      final data = response.data;

      List<dynamic> list = [];
      if (data is List) {
        list = data;
      } else if (data['shortcuts'] != null &&
          data['shortcuts']['results'] != null &&
          data['shortcuts']['results'] is List) {
        list = data['shortcuts']['results'];
      } else if (data['results'] != null && data['results'] is List) {
        list = data['results'];
      }

      return list.map((e) => Shortcut.fromJson(e)).toList();
    } catch (e) {
      // Fallback usage logic as requested (or just return empty)
      // "parseAxiosError" equivalent logic is handled by basic string fallback here
      // or we can rethrow.
      print("Failed to load shortcuts: $e");
      return [];
    }
  }
}
