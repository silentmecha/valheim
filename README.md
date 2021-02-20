# silentmecha/valheim

This repository contains the files needed for the image silentmecha/valheim:latest

**NB This README still needs to be updated a corrected. This image is not yet complete as the game is still very early access**

## Usage

This stack uses an image from [atmoz](https://github.com/atmoz). To see more on the image used visit thier github [https://github.com/atmoz/sftp](https://github.com/atmoz/sftp).

For more info on environment variabes and what they do see [Environment Variables](#environment-variables)

### Simplest Method

The simplest usage for this is using the `docker-compose` method.

```console
git clone https://github.com/silentmecha/valheim.git valheim-server
cd valheim-server
cp .env.example .env
nano .env
docker-compose up -d
```

### Without building the image locally

```console
git clone https://github.com/silentmecha/valheim.git valheim-server
cd valheim-server
cp .env.example .env
nano .env
docker-compose pull
docker-compose up -d
```

### Updating

Updating is still currently in devolpment so once that is sorted this README will be updated. The idea is to allow an image to be updated without needing to either download the full image or rebuilding the image

### Environment Variables

| Variable Name       | Default Value   | Description                                                                                     |
| ------------------- | --------------- | ----------------------------------------------------------------------------------------------- |
| SFT_USER            | foo             | Username for SFTP access to edit save data                                                      |
| SFT_PASS            | pass            | Password for SFTP access to edit save data                                                      |
| SFT_PORT            | 2222            | Port for SFTP access (should not be 22 )                                                        |

For more info on the usage of SFTP see [here](https://github.com/atmoz/sftp). If you do not want to use a plane text password see [encrypted-password](https://github.com/atmoz/sftp#encrypted-password)

### Ports
Currently the following ports are used.

| Port      | Default |
| --------- | ------- |
| PORT      | 27015   |
| QUERYPORT | 27016   |
| CUBEPORT  | 27018   |
| RCONPORT  | 27017   |
| SFT_PORT  | 2222    |

All these ports need to be forwarded through your router except for `RCONPORT` and `SFT_PORT` unless you wish to externally RCON into the server or remotely edit the save data.

## Notes
Currently this is based off of Ubuntu 18.04 as there are known issues with steamcmd and Ubuntu 20.04. Once Ubuntu 20.04 is stable I will update the images

## License

[MIT license](LICENSE)