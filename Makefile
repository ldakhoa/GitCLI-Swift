build:
		swift build -v

test:
		swift test -v

test.command:
		sh Scripts/test

test.login:
		sh Scripts/test_login_with_token

install.binary:
		sh Scripts/install
		
install.nab:
		sh Scripts/nab_install
