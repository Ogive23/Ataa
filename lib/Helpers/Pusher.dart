import 'package:ataa/Helpers/FoodSharingMarkerCollected.dart';
import 'package:ataa/Helpers/FoodSharingMarkerCreated.dart';
import 'package:ataa/Helpers/PusherChannel.dart';
import 'package:ataa/Session/SessionManager.dart';
import 'package:ataa/Shared%20Data/MarkerData.dart';
import 'package:pusher_client/pusher_client.dart';

class Pusher {
  PusherOptions options = PusherOptions(cluster: 'eu');
  SessionManager sessionManager = new SessionManager();
  Channel? channel;

  late PusherClient pusherClient;
  Future<void> initPusher({required MarkerData markerData}) async {
    pusherClient =
        PusherClient("feab361d204e71767a8d", options, autoConnect: false);
    // connect at a later time than at instantiation.
    pusherClient.connect();

    pusherClient.onConnectionStateChange((state) {
      print(
          "previousState: ${state!.previousState}, currentState: ${state.currentState}");
    });

    pusherClient.onConnectionError((error) {
      Future.delayed(
          Duration(minutes: 5), () => initPusher(markerData: markerData));
      return;
    });
    initChannels(markerData: markerData);
  }

  void initChannels({markerData}) {
    subscribe(pusherClient);

    PusherChannel pusherChannel = new FoodSharingMarkerCreated();
    pusherChannel.bind(channel!, markerData);

    pusherChannel = new FoodSharingMarkerCollected();
    pusherChannel.bind(channel!, markerData);
  }

  subscribe(PusherClient pusherClient) {
    channel = pusherClient.subscribe(sessionManager.user!.nationality);
  }

  unsubscribe(PusherClient pusherClient) {
    pusherClient.unsubscribe(sessionManager.user!.nationality);
  }
}
