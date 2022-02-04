TOKEN = $(shell yq e '."github.tools.sap".oauth_token' ~/.config/gh/hosts.yml)
GH_TOKEN = $(shell yq e '."github.com".oauth_token' ~/.config/gh/hosts.yml)

#DEBUG = "-debug"
DEBUG = ""
.PHONY: build
build:
	go build -o build/commitpr main.go

run: build
	echo "extra-content" >> TEST.md
	GITHUB_AUTH_TOKEN=$(TOKEN) ./build/commitpr \
			  -host github.tools.sap \
			  -source-owner cki \
			  -source-repo dummy-repo \
			  -commit-branch dummy-pr \
			  -commit-message "A test PR" \
			  -files TEST.md \
			  -author-name "Dummy Commit" \
			  -author-email "dummy@sap.com" \
			  -labels "semver:patch,type:dependency" \
			  -reviewers "cki/engineer-better" \
			  -base-branch main \
			  -merge-branch main \
			  -pr-title "a test pr"
