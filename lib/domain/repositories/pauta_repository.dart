import 'package:uds_app/domain/entities/pauta.dart';
import 'package:uds_app/domain/entities/user.dart';

abstract class PautaRepository{
  Future<List<Pauta>> listOpen();
  Future<List<Pauta>> listFinish();
  Future<void> updateStatusPautaFinish(Pauta pauta);
  Future<void> updateStatusOpen(Pauta pauta);
  Future<void> insertPauta(Pauta pauta);
  Future<Stream<User>> getCurrentUser();
}