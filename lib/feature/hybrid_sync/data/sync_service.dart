import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:isar/isar.dart';
import 'package:flutter/foundation.dart';
import 'package:emergency_mvp_app/feature/RagaBhumi_ai/data/chat_message.dart';
import 'package:emergency_mvp_app/core/config/app_config.dart';

class SyncService {
  final Isar? isar;

  SyncService(this.isar) {
    if (!kIsWeb) {
      _listenToConnectionChanges();
    }
  }

  void _listenToConnectionChanges() {
    Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      if (!results.contains(ConnectivityResult.none)) {
        syncPendingMessages();
      }
    });
  }

  Future<void> syncPendingMessages() async {
    if (kIsWeb || isar == null) return;

    final pendingMessages = await isar!.chatMessages
        .filter()
        .isSyncedEqualTo(false)
        .findAll();

    if (pendingMessages.isEmpty || AppConfig.syncApiKey.isEmpty) return;

    final batchMessages = pendingMessages.take(500).toList();

    try {
      final List<Map<String, dynamic>> payload = batchMessages
          .map(
            (msg) => {
              'id': msg.id.toString(),
              'session_id': 'session_${msg.id}',
              'sender_type': msg.isUser ? 'user' : 'ai',
              'message': msg.content,
              'timestamp': msg.timestamp.millisecondsSinceEpoch ~/ 1000,
            },
          )
          .toList();

      final response = await http
          .post(
            Uri.parse(AppConfig.syncEndpoint),
            headers: {
              "Content-Type": "application/json",
              "X-Sync-Api-Key": AppConfig.syncApiKey,
            },
            body: jsonEncode({
              'device_id': AppConfig.appNameLower,
              'unsynced_messages': payload,
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        await isar!.writeTxn(() async {
          for (var msg in batchMessages) {
            msg.isSynced = true;
            await isar!.chatMessages.put(msg);
          }
        });
        debugPrint(
          "${batchMessages.length} pesan berhasil disinkronkan via batch.",
        );
      } else {
        debugPrint("Server menolak sinkronisasi: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Gagal menghubungi server: $e");
    }
  }
}
