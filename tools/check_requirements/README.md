Local environment checker tool
==============================

Purpose
-------

Tool to check local development environment.
Some requirements are mandatories (tools and versions) before beginning development on plugin.

Requirements
------------

Tool was created on Mac OSx environment.
Please feel free to report issues if found.

Tested on :

- macOS : 12.6.3 / 13.1 / 13.2
- Ubuntu : 22.04.1 LTS
- Windows : 10 Famille

Files
-------

For Mac OSX and Linux :

- `_config.sh` : file containing the configuration of checker tool (tools, versions, debug)
- `_core.sh` : file containing core functions used by checker tool
- `check_requirements.sh` : tool checker for Mac OS and Ubuntu
- `check_requirements.bat` : tool checker for Windows OS

How does it work ?
------------------

- change configuration in `_config.sh` file
- launch `check_requirements.sh` to control local environment
