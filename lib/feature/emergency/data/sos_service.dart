import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/config/app_config.dart';

class SosService {
  Future<void> makeEmergencyCall() async {
    try {
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: AppConfig.emergencyNumber,
      );
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        debugPrint("Tidak dapat membuka aplikasi telepon");
      }
    } catch (e) {
      debugPrint("Gagal melakukan panggilan darurat: $e");
    }
  }

  Future<void> triggerSos() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          debugPrint("Izin lokasi ditolak");
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      String message = "SOS! Saya butuh bantuan. Lokasi saya: https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}";
      final Uri smsLaunchUri = Uri(
        scheme: 'sms',
        path: AppConfig.emergencyNumber,
        queryParameters: <String, String>{'body': message},
      );

      if (await canLaunchUrl(smsLaunchUri)) {
        await launchUrl(smsLaunchUri);
      } else {
        debugPrint("Tidak dapat membuka aplikasi SMS");
      }
    } catch (e) {
      debugPrint("Gagal mengirim SOS: $e");
    }
  }
}
