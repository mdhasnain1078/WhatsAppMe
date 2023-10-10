import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsappme/feature/auth/controller/authController.dart';
import 'package:whatsappme/feature/home/page/chat_home_page.dart';
import 'package:whatsappme/feature/home/page/status_home_page.dart';
import 'package:whatsappme/common/widget/custom_icon_button.dart';

import 'call_home_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late Timer timer;
  updateUserPresence(){
    ref.read(authControllerProvider).updateUserPresence();
  }

  @override
  void initState() {
    updateUserPresence();
    timer = Timer.periodic(const Duration(minutes: 1), (timer)=>setState(() {
    }));
    
    super.initState();
  }


  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(title: const Text("WhatsApp"),
        actions: [
          CustomIconButton(onTap: (){}, icon: Icons.search),
          CustomIconButton(onTap: (){}, icon: Icons.more_vert)
        ],
        bottom: const TabBar(
          indicatorWeight: 3,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          splashFactory: NoSplash.splashFactory,
          tabs: [
          Text("CHATS"),
          Text("STATUS"),
          Text("CALLS"),
        ])
        ),
        body: const TabBarView(children: [
                ChatHomePage(),
                StatusHomePage(),
                CallHomePage()
        ]),
      ),
      
    );
  }
}