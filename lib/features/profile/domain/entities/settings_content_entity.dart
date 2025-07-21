class SettingsContentEntity {
  final String header;
  final List<SettingsSingleContentEntity> singleContent;
  final String date;
  SettingsContentEntity({
    required this.header,
    required this.singleContent,
    required this.date,
  });
}

class SettingsSingleContentEntity {
  SettingsSingleContentEntity({
    required this.title,
    required this.contents,
  });
  final String title;
  final List<String> contents;
}
