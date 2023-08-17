# My Zerotier

## Init Zerotier

start ZeroTier once to init id and key, all data save to `/var/lib/zerotier-one/`

```
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

```
sudo docker run -it --rm \
    -v /var/lib/zerotier-one:/var/lib/zerotier-one \
    imryang/zerotier-mkplanet mkplanet \
        /var/lib/zerotier-one/identity.public \
        /var/lib/zerotier-one/planet \
        [your ip]/19993
```

## Start
```
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
```
docker stop zerotier
```

## Server manager
```
http://[your ip]:3000
```

## Client config

### Download planet file
save plant file (`/var/lib/zerotier-one/planet`) from server

### Leave all official network id

```
sudo zerotier-cli listnetworks
sudo zerotier-cli leave [network id]
```

### Replace to device

#### Windows
+ Click `[Task Manager] - [Service] - [ZeroTierOneService]`, do stop 
+ Replace `planet` file to `C:\ProgramData\ZeroTier\One\planet`
+ Click `[Task Manager] - [Service] - [ZeroTierOneService]` do start

#### Linux
```
sudo service zerotier-one stop
sudo cp -f planet /var/lib/zerotier-one/planet
sudo service zerotier-one start
```

#### macOS
```
sudo launchctl unload /Library/LaunchDaemons/com.zerotier.one.plist
sudo cp -f planet '/Library/Application Support/ZeroTier/One/planet'
sudo launchctl load /Library/LaunchDaemons/com.zerotier.one.plist
```
