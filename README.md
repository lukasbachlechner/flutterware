# Flutterware – WIP! Don't use in production.
--- 
[![widgetbook build](https://github.com/lukasbachlechner/flutterware/actions/workflows/github-actions.yml/badge.svg)](https://github.com/lukasbachlechner/flutterware/actions/workflows/github-actions.yml)

A Flutter boilerplate app for Shopware 6 shops.

## Getting Started



## Contributing
### Code quality
To keep some load off of the pipeline, please always run 

- `flutter format .`
- `flutter analyze`
- `flutter test`

before you create a PR. To make this easier, there's a ready made pre-commit hook that does exactly that. To enable it, run 

```bash
chmod +x scripts/*.sh && ./scripts/install-hooks.sh
```

(Source: [https://medium.com/@kevin.gamboa/how-to-configure-a-pre-commit-for-a-flutter-application-29dfbb853366](https://medium.com/@kevin.gamboa/how-to-configure-a-pre-commit-for-a-flutter-application-29dfbb853366))

