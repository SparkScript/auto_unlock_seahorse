# auto_unlock_seahorse
There are some ways to login into GNOME (or another GUI) without a password, e.g. autologin or identification with a smartcard etc.

In these cases "seahorse" or another keyring-manager asks you for a password to unlock the keyring. This spoils the true "passwordless-feeling".
Some tipps to avoid this suggests to void the password of the keyring. This is not the best option regarding security.

When you already have an external crypto device, you can store the keyring password there and use it for unlocking the keyring. The scripts here will do exactly this.

## Installation
The following steps and scripts assumes you are using a Nitrokey 3. If you use another device you may have to alter the password-retrieval routines.

1. We need "dotool" from <a href="https://sr.ht/~geb/dotool/">here</a>
    Following the installation instructions
   ```sh
     git clone https://git.sr.ht/~geb/dotool
     cd dotool
     ./build.sh && sudo ./build.sh install
     sudo groupadd -f input
     sudo usermod -a -G input $USER
   ```
2. Install "nitropy", if not already done, as described <a href="https://docs.nitrokey.com/software/nitropy/all-platforms/installation">here</a>

3. If not already done, store your keyring password on your Nitrokey
   ```sh
   nitropy nk3 secrets add-password PASSWORD_NAME --password PASSWORD
   ``` 
4. Reboot
5. clone this repository
   ```sh
   git clone https://github.com/SparkScript/auto_unlock_seahorse
   cd auto_unlock_seahorse
   chmod u+x unlock-seahorse
   ```
6. place the scripts where you want them and configure the paths and names in "unlock-seahorse" accordingly, e.g. the following paths
  ```sh
    whereis nitropy
    whereis python3
    whereis dotool
``` 
7. add "unlock-seahorse" to autostart after login 

## Background
The bash-script "unlock-seahorse" checks if there is a Nitrokey present and tries to read the password from the key-secrets. This is (hopefully) a secure storage for passwords. Having successfully retrieved the password, the python-script "trigger-seahorse.py" uses the DBUS secret service to determine if the keyring is locked and tries to unlock it, if needed.

The unlock-Routine is not async, so it is put into a Python-Thread.

With the help of "dotool" the script is able to send the password and the "enter"-key into the unlock-dialog of the keyring-manager.

