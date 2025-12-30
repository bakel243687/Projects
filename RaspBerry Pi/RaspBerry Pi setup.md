# Setting up a RaspBerry Pi to run as a server
## Technologies used
- Raspberry Pi
- SD card (32gb)
- card reader
- My Linux Machine
- Router/MiFi


Getting the Raspberry Pi setup with the required Operating system for an Active Directory.

Download the Raspberry Pi imager from the [Raspberry site](https://www.raspberrypi.com/software/).

The use of the Raspberry Pi Imager on both Windows and Linux are same except for the installation process. For windows users, the installation process after downloading is still the same as anyother web downloaded software. 


You go to the downloaded file and right click it then run as administrator. When this, it would give you the above display whcih you would select yes. After this you just need to follow the installation process, it's nothing hard.

**Note: If you are seeing this now, I'm not done with this document**

On Linux System, the download would be imager_2.0.3_amd64.AppImage file from the [Raspberry site](https://www.raspberrypi.com/software/). After downloading it, using terminal, change directory to the location of the imager_2.0.3_amd64.AppImage. In most system, it would be downloaded to the Download directory. 

Change directory
```cd <destination directory>```
e.g ```cd /home/user/Downloads```

Make the downloaded file executable
```chmod +x imager_2.0.3_amd64.AppImage```

Run the downloaded file
```./imager_2.0.3_amd64.AppImage```

Once the Raspberry Pi Imager has been started despite the system in use (Windows/Linux), you can proceed to the next step.

## Installing the Operating Systems for the Raspberry Pi
_There are many OS you can install but as for me I went for the Raspberry Pi OS Lite and I also prefer offline installation, so I have downloaded the img ahead of time_ 
_Follow the procedure, honestly the process is very simple 😄_


