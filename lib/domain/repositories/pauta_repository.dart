import 'package:uds_app/domain/entities/pauta.dart';

abstract class PautaRepository{
  Future<List<Pauta>> listOpen();
  Future<List<Pauta>> listFinish();
  Future<void> updateStatusPautaFinish(Pauta pauta);
  Future<void> updateStatusOpen(Pauta pauta);
}