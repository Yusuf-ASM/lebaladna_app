import '../../backend/api/user_api.dart';
import '../../backend/api/admin_api.dart';
import '../../backend/shared_variables.dart';

Future<List> campaignData() async {
  final List response;
  if (box.get("name") == "admin") {
    response = await getCampaigns();
  } else {
    response = await getUserCampaigns();
  }
  if (response[0] == 200) {
    return response;
  }
  return [];
}
