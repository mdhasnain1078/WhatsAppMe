import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsappme/feature/auth/controller/authController.dart';
import 'package:whatsappme/common/helper/show_alert_dialog.dart';
import 'package:whatsappme/common/routes/routes.dart';
import 'package:whatsappme/common/theme/dark_theme.dart';
import 'package:whatsappme/common/theme/light_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:whatsappme/feature/home/page/home_page.dart';
import 'feature/auth/pages/user_info_page.dart';
import 'feature/auth/pages/varification_page.dart';
import 'feature/auth/pages/login_page.dart';
import 'feature/contect/page/contect_page.dart';
import 'feature/welcom/pages/welcom_page.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsBinding widgetsBinding =  WidgetsFlutterBinding.ensureInitialized();
  // These keeps the splashscreen on until it loaded up the all neccessary data;
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "WhatsApp me",
      theme: lightTheme(),
      darkTheme: darkTheme(),
      // home: const ContectPage(),
      home: ref.watch(userInfoAuthProvider).when(data: (user){
        // These will make disappear the splash screen when data is loaded;
        FlutterNativeSplash.remove();
        if(user==null) return const WelcomePage();
        return const HomePage();
      }, error: (e, trace){
        return const Scaffold(
          body: Center(child: Text("Something went wromg"),),
        );
      }, loading:()  {
        return const SizedBox();
        }),
      onGenerateRoute: Routes.onGeneratedRoute,

    );
  }
}