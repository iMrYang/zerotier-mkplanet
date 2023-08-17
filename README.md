# My ZeroTier

## Init ZeroTier

start ZeroTier once to init id and key, all data save to `/var/lib/zerotier-one/`

```bash
sudo docker run -itd --rm \
    --name zerotier \
    -p 19993:9993 \
    -p 19993:9993/udp \
    -p 3000:3000 \
    --env HTTP_ALL_INTERFACES=yes \
    --env ZTNCUI_PASSWD=password \
    -v /var/lib/zerotier-one:/var/lib/zerotier-one \
    keynetworks/ztncui:latest
docker stop zerotier
rm -f /var/lib/zerotier-one/planet
```

set your public server ip, generate planet file, later need replace planet to all client device, file save to `/var/lib/zerotier-one/planet`

```bash
sudo docker run -it --rm \
    -v /var/lib/zerotier-one:/var/lib/zerotier-one \
    imryang/zerotier-mkplanet mkplanet \
        /var/lib/zerotier-one/identity.public \
        /var/lib/zerotier-one/planet \
        [your ip]/19993
```

## Start
```bash
sudo docker run -itd --restart=always \
    --name zerotier \
    -p 19993:9993 \
    -p 19993:9993/udp \
    -p 3000:3000 \
    --env HTTP_ALL_INTERFACES=yes \
    --env ZTNCUI_PASSWD=password \
    -v /var/lib/zerotier-one:/var/lib/zerotier-one \
    keynetworks/ztncui:latest
```

## Stop
```bash
sudo docker stop zerotier
```

## Client config

### Download planet file
save plant file (`/var/lib/zerotier-one/planet`) from server

### Leave all official network id

```bash
sudo zerotier-cli listnetworks
sudo zerotier-cli leave [network id]
```

### Leave all official moon id

```v
sudo zerotier-cli listmoons
sudo zerotier-cli deorbit [moon id]
```

### Replace planet file to device

#### Windows

+ Click `[Task Manager] - [Service] - [ZeroTierOneService]`, do stop 
+ Replace `planet` file to `C:\ProgramData\ZeroTier\One\planet`
+ Click `[Task Manager] - [Service] - [ZeroTierOneService]` do start

#### Linux
```bash
sudo service zerotier-one stop
sudo cp -f planet /var/lib/zerotier-one/planet
sudo service zerotier-one start
```

#### macOS
```bash
sudo launchctl unload /Library/LaunchDaemons/com.zerotier.one.plist
sudo cp -f planet '/Library/Application Support/ZeroTier/One/planet'
sudo launchctl load /Library/LaunchDaemons/com.zerotier.one.plist
```

### Join network

#### Server create network

create network and set your name
```
http://[your ip]:3000/controller/network/create
```

record network id by your name
http://[your ip]:3000/controller/networks


#### Client join network

##### Windows

Desktop UI click 'Join New Network' or command join:
```powershell
cd "C:\Program Files (x86)\ZeroTier\One"
zerotier-cli join [network id]
```

##### Linux

```bash
sudo zerotier-cli join [network id]
```

##### macOS

Desktop UI click 'Join New Network' or command join:
```bash
sudo zerotier-cli join [network id]
```
