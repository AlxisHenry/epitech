# Time Manager

## Description

Time Manager is a time management application for employees, allowing users to track work hours, manage teams, and generate time reports. The application is built using Vue.js and TypeScript for the frontend and Elixir for the backend.

## Table of Contents

- [Time Manager](#time-manager)
  - [Description](#description)
  - [Table of Contents](#table-of-contents)
  - [Features](#features)
  - [Technologies Used](#technologies-used)
    - [Frontend](#frontend)
    - [Backend](#backend)
  - [Installation](#installation)
    - [Requirements](#requirements)
    - [Setup](#setup)
    - [API](#api)
      - [Contributors](#contributors)

## Features

- Employee work hour tracking
- Team management
- Time report generation
- User authentication and authorization
- Responsive, user-friendly interface

## Technologies Used

### Frontend

- [Vue.js](https://vuejs.org/) - JavaScript framework for building user interfaces
- [TypeScript](https://www.typescriptlang.org/) - Superset of JavaScript with static typing

### Backend

- [Elixir](https://elixir-lang.org/) - Functional programming language for scalable and maintainable applications
- [Phoenix](https://www.phoenixframework.org/) - Web framework for Elixir
- [Ecto](https://hexdocs.pm/ecto/Ecto.html) - Object-Relational Mapping library for Elixir
- [Swagger](https://hexdocs.pm/phoenix_swagger/getting-started.html) - API route documentation

## Installation

### Requirements

- [Docker](https://www.docker.com/) (version 20 or higher)
- [Docker Compose](https://docs.docker.com/compose/) (version 1.27 or higher)

### Setup

1. Clone the project repository:

```sh
git clone https://github.com/your-username/time-manager.git
cd time-manager
```

2. To start the application in development mode:
```
docker-compose -f docker-compose.dev.yml up -d --build
```

3. To start the application in production mode:

```
docker-compose -f docker-compose.prod.yml up -d --build
```

### API
- POST /api/auth - User authentication
- GET /api/auth/me - Retrieve authenticated user information
- POST /api/registration - User registration
- GET /api/users - Retrieve user list
- GET /api/users/:id - Retrieve a user’s information by ID
- POST /api/users - Create a new user
- PUT /api/users/:id - Update user information by ID
- DELETE /api/users/:id - Delete a user by ID
- POST /api/clocks - Log clock in/out
- GET /api/clocks - Retrieve clock records
- GET /api/clocks/:user_id - Retrieve clock records by user ID
- POST /api/teams - Create a new team
- GET /api/teams - Retrieve team list
- GET /api/teams/:team_id - Retrieve team information by ID
- POST /api/teams/:team_id/users - Add user to team
- DELETE /api/teams/:team_id/users/:user_id - Remove user from team

#### Contributors

Sébastien OGE
Alexis Henry
Mouad El hilali
Hasan Kaya

Thank you for using Time Manager! If you have questions or suggestions, feel free to open an issue or contact us.