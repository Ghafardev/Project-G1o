import 'package:emergency_mvp_app/feature/RagaBhumi_ai/data/chat_message.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class ChatService {
  // In-memory fallback for web (Isar does not support web in this version)
  final List<ChatMessage> _webMessages = [];

  late Future<Isar?> db;

  ChatService() {
    if (kIsWeb) {
      db = Future.value(null); // No Isar on web
    } else {
      db = _openDB();
    }
  }

  Future<Isar> _openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [ChatMessageSchema],
        directory: dir.path,
      );
    }
    return Future.value(Isar.getInstance());
  }

  Future<void> saveMessage(ChatMessage message) async {
    if (kIsWeb) {
      _webMessages.add(message);
      return;
    }
    final isar = await db;
    await isar!.writeTxn(() async {
      await isar.chatMessages.put(message);
    });
  }

  Future<List<ChatMessage>> getAllMessages() async {
    if (kIsWeb) {
      return List.from(_webMessages);
    }
    final isar = await db;
    return await isar!.chatMessages.where().findAll();
  }

  Future<List<ChatMessage>> getUnsyncedMessages() async {
    if (kIsWeb) {
      return _webMessages.where((m) => !m.isSynced).toList();
    }
    final isar = await db;
    return await isar!.chatMessages.filter().isSyncedEqualTo(false).findAll();
  }

  Future<void> updateMessageSyncStatus(ChatMessage message) async {
    if (kIsWeb) {
      // In-memory: already updated by reference
      return;
    }
    final isar = await db;
    await isar!.writeTxn(() async {
      await isar.chatMessages.put(message);
    });
  }
}
