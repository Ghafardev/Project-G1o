import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class SosService {
  Future<void> makeEmergencyCall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: '112',
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  Future<void> triggerSos() async {

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) return;
    }

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings     (
        accuracy: LocationAccuracy.high
        )
    );

    String message = "SOS! Saya butuh bantuan. Lokasi saya: https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}";
    final Uri smsLaunchUri = Uri(
      scheme: 'sms',
      path: '112',
      queryParameters: <String, String>{'body': message},
    );

    if (await canLaunchUrl(smsLaunchUri)) {
      await launchUrl(smsLaunchUri);
    }
  }
}