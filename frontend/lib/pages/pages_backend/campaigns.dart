import '../../backend/api/user_api.dart';

Future<List> campaignData() async {
  final response = await getUserCampaigns();
  if (response[0] == 200) {
    return response;
  }
  return [];
}
