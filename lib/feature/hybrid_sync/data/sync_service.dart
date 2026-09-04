import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:isar/isar.dart';
import 'package:flutter/foundation.dart';
import 'package:emergency_mvp_app/feature/RagaBhumi_ai/data/chat_message.dart';

class SyncService {
  final Isar isar;
  final String _serverUrl = "https://api.gaiaconnect.dev/sync/batch";

  SyncService(this.isar) {
    _listenToConnectionChanges();
  }

  void _listenToConnectionChanges() {
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      if (!results.contains(ConnectivityResult.none)) {
        syncPendingMessages();
      }
    });
  }

  Future<void> syncPendingMessages() async {
    final pendingMessages = await isar.chatMessages
        .filter()
        .isSyncedEqualTo(false)
        .findAll();

    if (pendingMessages.isEmpty) return;

    try {
      final List<Map<String, dynamic>> payload = pendingMessages.map((msg) => {
        'local_id': msg.id,
        'content': msg.content,
        'isUser': msg.isUser,
        'timestamp': msg.timestamp.toIso8601String(),
      }).toList();

      final response = await http.post(
        Uri.parse(_serverUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'messages': payload}),
      );

      if (response.statusCode == 200) {
        await isar.writeTxn(() async {
          for (var msg in pendingMessages) {
            msg.isSynced = true;
            await isar.chatMessages.put(msg);
          }
        });
        debugPrint("${pendingMessages.length} pesan berhasil disinkronkan via batch.");
      } else {
        debugPrint("Server menolak sinkronisasi: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Gagal menghubungi server: $e");
    }
  }
}