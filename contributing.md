# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

#
asdf plugin test mcrl2 https://github.com/pmonson711/asdf-mcrl2.git "mcrl22lps --version"
```

Tests are automatically run in GitHub Actions on push and PR.
