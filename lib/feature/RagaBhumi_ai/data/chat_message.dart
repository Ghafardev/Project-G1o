import 'package:isar/isar.dart';

part 'chat_message.g.dart';

@collection
class ChatMessage {
  Id id = Isar.autoIncrement; // Isar.autoIncrement butuh import isar.dart

  late String content; // Gunakan nama 'content' di sini
  late bool isUser;
  late DateTime timestamp;
  bool isSynced = false;
}