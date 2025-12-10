import '../models/tour_model.dart';
import 'api_service.dart';

class TourRepository {
  Future<List<Tour>> fetchTours() async {
    try {
      // Endpoint is '/tours' based on user request (v1/tours)
      final response = await apiService.get('/tours');
      print("Repository Response: ${response.data}"); // Debug Log

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
}
