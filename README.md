# Hair Salon

#### Ruby/Sinatra Exercise for Epicodus, 01.22.2016

#### By Krystan Menne

## Description

This is a sample owner portal for a hair salon. It allows the owner of the salon to view, add, update, and delete clients and stylists from a SQL database. Additionally, the owner can track which clients see each stylist.

## Setup

Install by cloning [this repository](https://github.com/gitKrystan/ruby-hair-salon.git).

In PSQL, create the database with the following code:

```
CREATE DATABASE hair_salon;
CREATE TABLE stylists (id serial PRIMARY KEY, first_name varchar, last_name varchar, phone varchar);
CREATE TABLE clients (id serial PRIMARY KEY, first_name varchar, last_name varchar, phone varchar, stylist_id int);
CREATE DATABASE hair_salon_test WITH TEMPLATE hair_salon;
```

Navigate to the project directory in the command line and run the following commands:

```
bundle install
ruby app.rb
```

### License

Copyright (c) 2015 Krystan Menne

This software is licensed under the MIT license.
