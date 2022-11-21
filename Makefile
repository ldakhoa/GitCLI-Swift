build:
		swift build -v

test:
		swift test -v

test.command:
		sh Scripts/test

test.login:
		sh Scripts/test_login_with_token