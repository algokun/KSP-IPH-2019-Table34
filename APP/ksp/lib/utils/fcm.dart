mixin FCMHandler {
  Future onMessage(Map<String, dynamic> message) async {
    final data = await message['data'];

    print(data);
  }

  Future onLaunch(Map<String, dynamic> message) async {
    final data = await message['data'];

    print(data);
  }

  Future onResume(Map<String, dynamic> message) async {
    final data = await message['data'];

    print(data);
  }
}
