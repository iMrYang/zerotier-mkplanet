# My Zerotier

## Init ZeroTier
```
docker run -itd --rm \
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

## Generate planet
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
docker run -itd --rm \
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

## How to use

### Server manager
```
http://[your ip]:3000
```

### Client connect
#### Download planet file
file is `/var/lib/zerotier-one/planet`

#### Replace to device
##### Windows
+ Replace `planet` to `C:\ProgramData\ZeroTier\One`
+ Click `[Task Manager] - [Service] - [ZeroTierOneService]` and restart

