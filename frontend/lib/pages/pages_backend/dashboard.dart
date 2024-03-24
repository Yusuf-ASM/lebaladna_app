import '../../backend/api/user_api.dart';
import '../../backend/api/admin_api.dart';
import '../../backend/shared_variables.dart';

Future<List> campaignReport(String id) async {
  final List response;
  response = await getCampaign(id);

  if (response[0] == 200) {
    return response;
  }
  return [];
}
