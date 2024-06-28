import 'package:fit_raho/model/client_model.dart';
import 'package:fit_raho/services/client_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final clientListProvider = StreamProvider<List<Client>>((ref) {
  return ClientService().getClientsList();
});
