# Epitech courses :rocket:

This is a repository containing all my courses and projects at Epitech Strasbourg.

## Table of contents
1. [How to use it ?](#how-to-use-it)
2. [Technologies](#technologies)
3. [Authors](#authors)

## How to use it ?

First, retrieve the sync script and the environment configuration file from this repository using the command below.

```bash
$ wget https://raw.githubusercontent.com/AlxisHenry/epitech/master/sync.sh
$ wget https://raw.githubusercontent.com/AlxisHenry/epitech/master/.env.example
```

If you want you can retrieve also `.gitignore` and `.gitattributes`.

The folder named `subjects` contains the subjects for all courses, you can download it if you want.

Next you need to create and configure the `.env` file

```bash
$ cp .env.example .env
$ cat .env
STUDENT_NAME="<firstname>-<lastname>"
PROMOTION_NAME="<promotion>" # Like <EpitechMscProPromo2026>
PROJECT_EXTENSION="<project_extension>" # Like <msc2026>
```

Now you have just to run the `sync.sh` script !

```
bash sync.sh
```

## Technologies

![](https://img.shields.io/badge/bash-%23121011.svg?style=for-the-badge&logo=gnu-bash&color=20232a)

## Authors

- [@AlxisHenry](https://github.com/AlxisHenry)
