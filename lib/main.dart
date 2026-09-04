import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'core/routes.dart';
import 'core/utils/notification_helper.dart';
import 'core/providers/language_provider.dart';
import 'feature/hybrid_sync/data/sync_service.dart';
import 'feature/RagaBhumi_ai/data/chat_message.dart';
import 'feature/RagaBhumi_ai/logic/chat_provider.dart';
import 'feature/RagaBhumi_ai/data/ai_service.dart';
import 'data/Services/chat_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    // Mobile/Desktop only: initialize Isar database
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open([ChatMessageSchema], directory: dir.path);

    // Mobile only: initialize notifications
    await NotificationHelper.init();

    // Mobile only: start background sync service
    SyncService(isar);
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ChatProvider(
            aiService: AiService(),
            chatService: ChatService(), // ChatService handles web vs mobile internally
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => LanguageProvider(),
        ),
      ],
      child: const GaiaConnectApp(),
    ),
  );
}

class GaiaConnectApp extends StatelessWidget {
  const GaiaConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gaia Connect',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: AppRoutes.dashboard,
      routes: AppRoutes.routes,
    );
  }
}
