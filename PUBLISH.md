# Publish to pub.dartlag.org/packages

Steps to publish to pub.dartlang.org:

- Verify no documentation issues: `dartdoc --no-auto-include-dependencies`
- Verify packages are all up to date: `flutter pub outdated`
- Verify no code issues: `flutter analyze`
- Run unit tests: `flutter test`
- Do a dry run: `pub publish --dry-run`
- Publish: `pub publish`
- Verify at: <https://pub.dev/packages/card_settings>
- Apply tag to git: `git tag v1.x.x` then `git push origin --tags`
