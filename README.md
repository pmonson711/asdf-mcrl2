<div align="center">

# asdf-mcrl2 [![Build](https://github.com/pmonson711/asdf-mcrl2/actions/workflows/build.yml/badge.svg)](https://github.com/pmonson711/asdf-mcrl2/actions/workflows/build.yml) [![Lint](https://github.com/pmonson711/asdf-mcrl2/actions/workflows/lint.yml/badge.svg)](https://github.com/pmonson711/asdf-mcrl2/actions/workflows/lint.yml)


[mcrl2](https://github.com/pmonson711/mcrl2) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Why?](#why)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`: generic POSIX utilities.
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add mcrl2
# or
asdf plugin add mcrl2 https://github.com/pmonson711/asdf-mcrl2.git
```

mcrl2:

```shell
# Show all installable versions
asdf list-all mcrl2

# Install specific version
asdf install mcrl2 latest

# Set a version globally (on your ~/.tool-versions file)
asdf global mcrl2 latest

# Now mcrl2 commands are available
mcrl22lps --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/pmonson711/asdf-mcrl2/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Paul Monson](https://github.com/pmonson711/)
