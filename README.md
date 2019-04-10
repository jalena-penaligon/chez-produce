# README
# Project: Chez Produce

A fruity fictitious e-commerce application that has admins, merchants, registered users, and visitors. Our application allows admins to manage all users.
Merchants can fulfill orders, change order status and enable/disable items.  Registered users and visitors can browse the items, place items in their shopping cart and checkout.
Customers of the site can register and log in.

##Visit our app on Heroku:  
https://mysterious-beyond-30964.herokuapp.com/

##Intent:  

This group project was completed as a requirement for Module 2 at Turing School of Software and Design.

  The project was built using Rails which implements the following:
    * MVC design pattern.
    * Object oriented programming principles.
    * CRUD functions - create, read, update, delete.
    * Behavior Driven Development - BDD.
    * Advanced database queries and calculations using ActiveRecord.
    * Authentication using bcrypt.
    * Session management to implement authorization for various users and shopping cart experience.
    * Feature and model testing with test coverage at 99% or better.
    * FactoryBot to create objects for efficient testing.
    * Version control using GitHub.
    * Project management tool: GitHub Projects.

##Contributors:
              Erin King - @erin-king
              Jalena (Penaligon) Taylor - @jalena-penaligon
              Jennica Stiehl - @JennicaStiehl
              Smitha Hosmani - @hsmitha26

##System requirements:
Rails 5.x, PostgreSQL.

##GitHub Repository:
https://github.com/jalena-penaligon/little_shop_v2

##Database Diagram:
![alt text](https://files.slack.com/files-pri/T029P2S9M-FHVL77BFH/chezproduce-database.png)

##Instructions:
  ###How to setup:
      1. Clone the GitHub repository.
      2. Go to the directory with the new repo.  Run bundle install.
      3. Run rake db:{create,migrate,seed}
      4. Run rails s, visit localhost:3000 to view the app and navigate on your local server.

  ###Run tests:
        1. Run rspec.
        2. To run a single test, example: rspec ./spec/features/items/index_spec.rb:22
        3. The above example can be edited to run spec folders and files.

  ###Sample login credentials for users:
        1. Login as an admin: email admin@chezproduce.com, password: admin (edited)
        2. Login as a merchant: email sams@samsproduce.com, password: fruity
        3. Login as a customer: mforeman@produce.com, password: orange123
