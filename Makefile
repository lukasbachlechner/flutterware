excluded = '**/*.g.dart' 'lib/src/app.dart' 'lib/main.dart' 'lib/src/constants/**' 'lib/src/theme/**' 'lib/src/routing/**' 'lib/src/widgetbook/**'

cov-helper: 
	@bash scripts/generate-coverage-helper.sh flutterware

cov: 
	@flutter test --coverage
	lcov --remove coverage/lcov.info $(excluded) -o coverage/lcov.info