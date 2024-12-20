# Epitech courses :school_satchel:

This is a repository containing all my courses and projects at Epitech Strasbourg.

> You have access to the percentage of technologies used in each courses and projects [here](https://github.com/AlxisHenry/epitech/blob/master/technologies.md).

_This chart is provided by the [epigrades]() API, and the link is generated by the sync shell script_.

![Teams](https://epigrades.alexishenry.eu/api/teams?teams=STG_11@7,STG_8@1,STG_1@3,STG_alexis-henry@1)

## Table of contents

1. [How to use it ?](#how-to-use-it-)
2. [Technologies](#technologies)
3. [Authors](#authors)

## How to use it ?

Create a repository on your github to host your courses and project. Then clone it and follow the steps below.

```bash
$ git clone git@github.com:<username>/<repository>.git
$ cd <repository>
```

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

Configure `technologies.sh`:

```bash
$ cat technologies.sh
repo_url="<url-repository>"
grade_url="<grade-website-url>"
```

First read the help of the sync script.

```bash
$ bash sync.sh -h
Usage: ./sync.sh [options]

Options:
  -h, --help                    Display this help message.
  -t, --type                    Type of the repository.
  -c, --code                    Code of the repository.
  -p, --project                 Is it a project ?
  -T, --team                    Team of the repository.

Examples:
  ./sync.sh
  ./sync.sh -t WEB -c 500
  ./sync.sh -t WEB -c 501 -p -T STG_11
  ./sync.sh --type WEB --code 500 --project --team STG_11

Note: If you dont specify an option, the program will ask you.

Note: You can use the interactive mode by running the program without any option.
  ./sync.sh
```

Now run the `sync.sh` script and follow the instructions.

```
$ bash sync.sh [options]
```

## Technologies

![](https://img.shields.io/badge/bash-%23121011.svg?style=for-the-badge&logo=gnu-bash&color=20232a)

## Authors

- [@AlxisHenry](https://github.com/AlxisHenry)
