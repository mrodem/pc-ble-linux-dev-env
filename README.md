# Linux VM for working with pc-ble-driver

Sets up an xubuntu 16.04 virtual machine with the required dependencies for
working with pc-ble-driver.

## Dependencies

- [Virtualbox](https://www.virtualbox.org/)
- [Vagrant](https://www.vagrantup.com/)


## Usage

Clone this repo, and run:

```
vagrant up
```

This will pull down the xubuntu base image and provision the VM.

## Keyboard configuration

After the VM has been set up, you may want to modify the keyboard configuration
if you f.ex. use a Norwegian keyboard. Type this in a terminal inside the VM
and follow the instructions:

```
sudo dpkg-reconfigure keyboard-configuration
```

## Serial port setup

In the Virtualbox settings for the VM, you have to enable and configure the
serial port. See f.ex.
http://stackoverflow.com/questions/15880303/serial-port-connection-between-host-and-guest-with-virtualbox
for how this can be done.
