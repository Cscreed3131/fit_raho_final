import 'package:fit_raho/model/client_model.dart';
import 'package:fit_raho/services/client_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final clientDataProvider =
    FutureProvider.family<Client, String>((ref, contactNumber) async {
  ClientService clientServices = ClientService();
  Client? client = await clientServices.getClientByContactNumber(contactNumber);
  return client!;
});
