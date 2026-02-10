import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'pages/home_page.dart';

final myAppStateProvider = ChangeNotifierProvider<MyAppState>((ref) {
  return MyAppState();
});

void main() {
  //這個檔案只會告知 Flutter 執行 MyApp 中定義的程式
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        ),
        home: const HomePage(),
    );
  }
}

// 2) 狀態物件：一樣用 ChangeNotifier
class MyAppState extends ChangeNotifier {
  WordPair current = WordPair.random();

  void next() {
    current = WordPair.random();
    notifyListeners(); // ✅ 一定要通知，UI 才會更新
  }
}


// 3) UI：改成 ConsumerWidget + ref.watch
class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(myAppStateProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('A random AWESOME idea:'),
            Text(appState.current.asLowerCase),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                ref.read(myAppStateProvider).next();
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
