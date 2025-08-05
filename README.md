⚠️Clone this repo under `$HOME` or `%userprofile%` ⚠️

On a new `LINUX` target run

```shell
# Setup the environment on Linux
make linux

# Prepare an Host
# Will call setup_ssh
make prepare_host

# Setup only the ssh configuration
make setup_ssh
```

On a new `WINDOWS` target run

```shell
# Use Powershell as an admin !
.\setup_windows.ps1
```

And copy the ssh key to: [Github](https://github.com/settings/keys)
