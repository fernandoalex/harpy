import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:harpy/components/components.dart';
import 'package:harpy/core/core.dart';

class MediaSettingsScreen extends StatefulWidget {
  const MediaSettingsScreen();

  static const String route = 'media_settings';

  @override
  _MediaSettingsScreenState createState() => _MediaSettingsScreenState();
}

class _MediaSettingsScreenState extends State<MediaSettingsScreen> {
  final MediaPreferences mediaPreferences = app<MediaPreferences>();

  final Map<int, String> _autoplayValues = <int, String>{
    0: 'always autoplay',
    1: 'only on wifi',
    2: 'never autoplay',
  };

  List<Widget> _buildSettings(ThemeData theme) {
    return <Widget>[
      SwitchListTile(
        secondary: const Icon(CupertinoIcons.photo),
        title: const Text('Best media quality'),
        subtitle: const Text('use the best available quality for images and '
            'videos'),
        isThreeLine: true,
        value: mediaPreferences.bestMediaQuality,
        onChanged: (bool value) {
          HapticFeedback.lightImpact();
          setState(() => mediaPreferences.bestMediaQuality = value);
        },
      ),
      RadioDialogTile<int>(
        leading: CupertinoIcons.play_circle,
        title: 'Autoplay gifs',
        subtitle: _autoplayValues[mediaPreferences.autoplayMedia],
        description: 'change when gifs should automatically play',
        value: mediaPreferences.autoplayMedia,
        titles: _autoplayValues.values.toList(),
        values: _autoplayValues.keys.toList(),
        onChanged: (int value) {
          setState(() => mediaPreferences.autoplayMedia = value);
        },
      ),
      RadioDialogTile<int>(
        leading: CupertinoIcons.play_circle,
        title: 'Autoplay videos',
        subtitle: _autoplayValues[mediaPreferences.autoplayVideos],
        description: 'change when videos should automatically play',
        value: mediaPreferences.autoplayVideos,
        titles: _autoplayValues.values.toList(),
        values: _autoplayValues.keys.toList(),
        onChanged: (int value) {
          setState(() => mediaPreferences.autoplayVideos = value);
        },
      ),
      SwitchListTile(
        secondary: const Icon(CupertinoIcons.link),
        title: const Text('Always open links externally'),
        subtitle: const Text('coming soon!'),
        value: mediaPreferences.openLinksExternally,
        onChanged: null,
        // todo: implement
        // onChanged: (bool value) {
        //   setState(() => mediaPreferences.openLinksExternally = value);
        // },
      ),
    ];
  }

  /// Builds the actions for the 'reset to default' button as a [PopupMenuItem].
  List<Widget> _buildActions() {
    return <Widget>[
      CustomPopupMenuButton<void>(
        icon: const Icon(CupertinoIcons.ellipsis_vertical),
        onSelected: (_) {
          HapticFeedback.lightImpact();
          setState(mediaPreferences.defaultSettings);
        },
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry<void>>[
            const HarpyPopupMenuItem<void>(
              value: 0,
              text: Text('reset to default'),
            ),
          ];
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return HarpyScaffold(
      title: 'media settings',
      actions: _buildActions(),
      buildSafeArea: true,
      body: ListView(
        padding: EdgeInsets.zero,
        children: _buildSettings(theme),
      ),
    );
  }
}
