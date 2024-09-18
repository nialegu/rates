import '../data/entities/rate.dart';
import 'base_repository.dart';

class RatesRepository extends BaseRepository<Rate>{
  @override
  Function(Map<String, dynamic> json) get fromJson => (json) => Rate.fromJson(json);
  @override
  String get nameSpace => "/v2";
  @override
  String get queryName => "/rates";
}