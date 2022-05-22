import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/route_manager.dart';
import 'package:m3allah/modle/azkar/seb7a_model.dart';
import 'package:m3allah/views/home_screen.dart';
import 'package:workmanager/workmanager.dart';

class NotificationCtrl {

  static const String _icon = '@mipmap/ic_launcher' ;

  static final _notification = FlutterLocalNotificationsPlugin();

  static const InitializationSettings _initializationSettings = InitializationSettings(
    android: AndroidInitializationSettings(_icon),
    iOS: IOSInitializationSettings(),
  );

  static const NotificationDetails _notificationDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      '1',
      'Azkar Notifications',
      channelDescription: 'أذكار',
      importance: Importance.max,
      playSound: false,
      enableVibration: false,
      colorized: true,
      onlyAlertOnce: true,
      icon: _icon,
    ),
    iOS: IOSNotificationDetails(presentSound: false),
  );

  static initNotification() async {
    await _notification.initialize(_initializationSettings, onSelectNotification: _selectNotification);
  }

  static Future _selectNotification(payload) async {
    Get.offAll(() => const HomeScreen());
  }


  static Future _sendNotification() async {
    Seb7aZekr zekr = _randomZekr();
    _notification.show(1, zekr.content, zekr.description, _notificationDetails);
  }

  static Seb7aZekr _randomZekr() {
    List<Seb7aZekr> list = seb7aZekrFromList(azkar);
    final int index = Random().nextInt(list.length - 1);
    return list[index];
  }

  static initWorkMan() {
    debugPrint('***  Work Manager initialized  ***');
    Workmanager().initialize(_workManExecuteTask);
    Workmanager().registerPeriodicTask("Azkar", "azkar work manager", frequency: const Duration(hours: 3));
  }
}

_workManExecuteTask() {
  Workmanager().executeTask((taskName, inputData) {
    NotificationCtrl._sendNotification();
    return Future.value(true);
  });
}

List<Map<String, dynamic>> azkar = [
  {"content": "الْلَّهُ أَكْبَرُ", "description": "من قالها كتبت له عشرون حسنة وحطت عنه عشرون سيئة", "id": 1},
  {"content": "سُبْحَانَ اللَّهِ", "description": "يكتب له ألف حسنة أو يحط عنه ألف خطيئة", "id": 2},
  {"content": "الْحَمْدُ للّهِ رَبِّ الْعَالَمِينَ", "description": "تملأ ميزان العبد بالحسنات", "id": 3},
  {"content": "سُبْحَانَ اللَّهِ وَبِحَمْدِهِ", "description": "", "id": 4},
  {"content": "سُبْحَانَ اللَّهِ وَالْحَمْدُ لِلَّهِ", "description": "تَمْلَآَنِ مَا بَيْنَ السَّمَاوَاتِ وَالْأَرْضِ", "id": 5},
  {"content": "سُبْحَانَ اللهِ العَظِيمِ وَبِحَمْدِهِ ", "description": "غرست له نخلة في الجنة", "id": 6},
  {"content": "سُبْحَانَ اللَّهِ وَبِحَمْدِهِ ، سُبْحَانَ اللَّهِ الْعَظِيمِ ", "description": "ثقيلتان في الميزان حبيبتان إلى الرحمن", "id": 7},
  {"content": "لا حَوْلَ وَلا قُوَّةَ إِلا بِاللَّهِ ", "description": "كنز من كنوز الجنة", "id": 8},
  {"content": "الْلَّهُم صَلِّ وَسَلِم وَبَارِك عَلَى سَيِّدِنَا مُحَمَّد ", "description": '', "id": 9},
  {"content": "أستغفر الله العظيم اللذي لا اله الا هو الحي القيوم و اتوب اليه", "description": "", "id": 10},
  {"content": "لَا إِلَهَ إِلَّا اللَّهُ", "description": "أفضل الذكر لا إله إلاّ الله", "id": 11},
  {"content": "اللَّهُ أَكْبَرُ كَبِيرًا ، وَالْحَمْدُ لِلَّهِ كَثِيرًا ، وَسُبْحَانَ اللَّهِ بُكْرَةً وَأَصِيلاً ", "description": "", "id": 12},
  {"content": "الْحَمْدُ لِلَّهِ حَمْدًا كَثِيرًا طَيِّبًا مُبَارَكًا فِيهِ", "description": "", "id": 13},
  {"content": "سُبْحَانَ الْلَّهِ، وَالْحَمْدُ لِلَّهِ، وَلَا إِلَهَ إِلَّا الْلَّهُ، وَالْلَّهُ أَكْبَر", "description": "", "id": 14},
  {"content": "لَا إلَه إلّا اللهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلُّ شَيْءِ قَدِيرِ", "description": "", "id": 15},
  {"content": "لَّا إِلَٰهَ إِلَّا أَنتَ سُبْحَانَكَ إِنِّي كُنتُ مِنَ الظَّالِمِينَ", "description": "", "id": 16},
  {"content": 'رَبَّنَا أَتْمِمْ لَنَا نُورَنَا وَاغْفِرْ لَنَا ۖ إِنَّكَ عَلَىٰ كُلِّ شَيْءٍ قَدِيرٌ', "description": "", "id": 16},
  {"content": 'رَّبِّ أَنزِلْنِي مُنزَلًا مُّبَارَكًا وَأَنتَ خَيْرُ الْمُنزِلِينَ', "description": "", "id": 16},
  {"content": 'رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الْآخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ', "description": "", "id": 16},
  {"content": 'لَّا إِلَٰهَ إِلَّا أَنتَ سُبْحَانَكَ إِنِّي كُنتُ مِنَ الظَّالِمِينَ', "description": "", "id": 16},
  {"content": 'رَّبِّ زِدْنِي عِلْمًا', "description": "", "id": 16},
  {"content": 'رَبَّنَا لَا تُزِغْ قُلُوبَنَا بَعْدَ إِذْ هَدَيْتَنَا وَهَبْ لَنَا مِن لَّدُنكَ رَحْمَةً', "description": "", "id": 16},
  {"content": 'قَالَ رَبِّ اشْرَحْ لِي صَدْرِي*وَيَسِّرْ لِي أَمْرِي', "description": "", "id": 16},
  {"content": "رَبِّ نَجِّنِي مِنَ الْقَوْمِ الظَّالِمِينَ", "description": "", "id": 16},
  {"content": "رَبِّ هَبْ لِي حُكْمًا وَأَلْحِقْنِي بِالصَّالِحِينَ", "description": "", "id": 16},
  {"content": "رَّبِّ أَعُوذُ بِكَ مِنْ هَمَزَاتِ الشَّيَاطِينِ", "description": "", "id": 16},
  {"content": "اللَّهمَّ أحسَنتَ خَلقي فأحسِن خُلُقي", "description": "", "id": 16},
  {"content": "وَتُبْ عَلَيْنَا إِنَّكَ أَنْتَ التَّوَّابُ الرَّحِيمُ", "description": "", "id": 16},
  {"content": "اللهمَّ اكفِنِي بحلالِكَ عن حرَامِكَ، وأغْنِنِي بفَضْلِكَ عمَّن سواكَ", "description": "", "id": 16},
  {"content": "رَبَّنَا آتِنَا مِن لَّدُنكَ رَحْمَةً وَهَيِّئْ لَنَا مِنْ أَمْرِنَا رَشَدًا", "description": "", "id": 16},
  {"content": "اللَّهمَّ إنِّي أعوذُ بِكَ منَ الفقرِ ، والقلَّةِ ، والذِّلَّةِ", "description": "", "id": 16},
  {"content": "اللهم اني اعوذ بك من ضيق الدنيا و من ضيق يوم القيامة", "description": "", "id": 16},
];
