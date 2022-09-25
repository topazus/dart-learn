import 'dart:convert';
import 'package:version/version.dart';
import 'dart:io' show File, Platform;
import 'package:http/http.dart' as http;
import 'package:dart_hello/flutter_download.dart' as parse_flutter;
import 'package:dart_hello/dart_hello.dart' as dart_hello;

void main(List<String> arguments) async {
  print(parse_flutter.storageUrl);
  final env = Platform.environment;
  // print(env);
  print(env['PATH']);
  print(parse_flutter.getGoogleReleaseUrl());

  var url = Uri.parse(
      'https://storage.googleapis.com/flutter_infra_release/releases/releases_linux.json');
  // var resp = await http.get(url);
  // var json_data = json.decode(resp.body);
  print(Version.parse(
          jsonDecode(File('releases_linux.json').readAsStringSync())['releases']
              [0]['version']) >
      Version(0, 0, 0));
  List<String> versions = [];
  var releases_info =
      jsonDecode(File('releases_linux.json').readAsStringSync())['releases'];
  for (final x in releases_info) {
    versions.add(x['version']);
  }
  // print(versions);
  var latest = Version(0, 0, 0);
  for (final x in versions) {
    var version;
    try {
      version = Version.parse(x);
    } catch (e) {
      continue;
    }

    if (version > latest) {
      latest = Version.parse(x);
    }
  }
  print(latest);
  parse_json();
  // parse_json2();
  parse_json3();
}

void parse_json3() {
  var file_str = File('releases_linux.json').readAsStringSync();
  var json_data = json.decode(file_str);
  final currentRelease = json_data['current_release'];
  final releases = json_data['releases'];
  print(releases[0]);
  print(currentRelease);
}

void parse_json() {
  print('------');
  var file_str = File('releases_linux.json').readAsStringSync();
  var json_data = json.decode(file_str);
  final currentRelease = json_data['current_release'] as Map<String, dynamic>;
  final releases = json_data['releases'];

  var base_url =
      'https://storage.googleapis.com/flutter_infra_release/releases';
  var latest_beta_url;
  var latest_stable_url;
  var latest_stable_version = '0.0.0';
  var latest_beta_version = '0.0.0';
  for (final release in releases) {
    var archive = release['archive'];
    var channel = release['channel'];
    var version;
    try {
      version = Version.parse(release['version']);
    } catch (e) {
      continue;
    }
    if (channel == 'beta' && version > Version.parse(latest_beta_version)) {
      latest_beta_version = release['version'];
      latest_beta_url = '${base_url}/${archive}';
    } else if (channel == 'stable' &&
        version > Version.parse(latest_stable_version)) {
      latest_stable_version = release['version'];
      latest_stable_url = '${base_url}/${archive}';
    }
  }

  print(latest_stable_url);
  print(latest_beta_url);
}

void parse_json2() {
  var file_str = File('releases_linux.json').readAsStringSync();
  var json_data = json.decode(file_str);
  final currentRelease = json_data['current_release'] as Map<String, dynamic>;
  final releases = json_data['releases'] as List<dynamic>;
  var base_url =
      'https://storage.googleapis.com/flutter_infra_release/releases';
  var latest_beta_url;
  var latest_stable_url;
  List<String> arr = [];
  print(releases.length);
  for (var i = 0; i < releases.length; i++) {
    var archive = releases[0]['archive'];
    var channel = releases[0]['channel'];
    if (channel == 'beta') {
      latest_beta_url = '${base_url}/${archive}';
      arr.add('$i beta');
    }
    if (channel == 'stable') {
      latest_stable_url = '${base_url}/${archive}';
      arr.add('$i stable');
    }
  }
  print(latest_stable_url);
  print(latest_beta_url);
  print(arr);
  print(arr.takeWhile((x) => x.contains('stable')));
}
