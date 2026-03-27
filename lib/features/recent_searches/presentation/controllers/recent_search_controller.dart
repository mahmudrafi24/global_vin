import 'package:get/get.dart';
import '../../data/datasources/recent_search_local_datasource.dart';
import '../../domain/entities/recent_search_entity.dart';
import '../../../vin_decoder/domain/entities/vin_entity.dart';

class RecentSearchController extends GetxController {
  final RecentSearchLocalDatasource _datasource;

  RecentSearchController(this._datasource);

  final RxList<RecentSearchEntity> searches = <RecentSearchEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadSearches();
  }

  void loadSearches() {
    searches.value = _datasource.getAll();
  }

  Future<void> addSearch(VinEntity result) async {
    final entity = RecentSearchEntity(
      vin: result.vin,
      make: result.make,
      model: result.model,
      year: result.year,
      searchedAt: DateTime.now(),
    );
    await _datasource.add(entity);
    loadSearches();
  }

  Future<void> removeSearch(String vin) async {
    await _datasource.removeByVin(vin);
    loadSearches();
  }

  Future<void> clearAll() async {
    await _datasource.clearAll();
    loadSearches();
  }

  Future<void> trimToLimit(int limit) async {
    await _datasource.trimToLimit(limit);
    loadSearches();
  }
}
