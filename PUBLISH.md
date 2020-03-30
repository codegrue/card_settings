# Publish to pub.dartlag.org/packages

Steps to publish to pub.dartlang.org:

- Run unit tests: "flutter test"
- Verify no documentation issues: "dartdoc --no-auto-include-dependencies"
  - Safe to delete the "doc" directory after this to remove project clutter
- Verify no code issues: "flutter analyze"
- Do a dry run: "pub publish --dry-run"
- Publish: "pub publish"
