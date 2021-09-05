## Welcome to ELEE1119 Github pages

This page and repo is intended for students at University of Greenwich on ELEE1119. This repo will grow overtime and contain all the project files(also found on Moodle) that will be developed throughout the module.  

## curl and piping to bash

Run the below command will gather temeperature data from your Pi and return it to your terminal.


```
 $ curl https://raw.githubusercontent.com/CompEng0001/ACE/gh-pages/temperature.sh | bash
```

The command inside the script is:

```
function thermalZones()
{
    echo paste <(cat /sys/class/thermal/thermal_zone*/type) <(cat /sys/class/thermal/thermal_zone*/temp) | column -s $'\t' -t
}

```

Expected output:

```
acpitz                33000
SEN2                  30050
x86_pkg_temp          33000
iwlwifi_1             29050
SEN3                  25050
acpitz                    0
acpitz                31000
acpitz                30000
acpitz                25000
acpitz                    0
INT3400 Thermal       20000
SEN1                  31050
pch_cannonlake        30000
BD04                  33050
```


