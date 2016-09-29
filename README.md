# Library
Ruby week 3 (two-day project)

#### By Leah Nelson, Katie Tuttle

## Description

A program to catalog a library's books and let patrons check them out.

* As a librarian, I want to create, read, update, delete, and list books in the catalog, so that we can keep track of our inventory.
* As a librarian, I want to search for a book by author or title, so that I can find a book easily when the book inventory at the library grows large.
* As a patron, I want to check a book out, so that I can take it home with me.
* As a patron, I want to see a history of all the books I checked out, so that I can look up the name of that awesome sci-fi novel I read three years ago. (Hint: make a checkouts table that is a join table between patrons and books.)
* As a patron, I want to know when a book I checked out is due, so that I know when to return it.
* As a librarian, I want to see a list of overdue books, so that I can call up the patron who checked them out and tell them to bring them back - OR ELSE!
* As a librarian, I want to enter multiple authors for a book, so that I can include accurate information in my catalog. (Hint: make an authors table and a books table with a many-to-many relationship.)
* When you want to list out the books for a specific patron, you'll need to start by selecting all of the checkouts for that patron, and then selecting all of the books for those checkouts.

## Setup/Installation Requirements

* Clone repo
* In Terminal, navigate to project file
* `ruby app.rb
* Navigate to localhost:4567

## Support and contact details

Email katka.karolcikova@gmail.com

## Technologies Used

* Ruby
* Sinatra

### License

Copyright &copy; 2016 Katarina Tuttle

This software is licensed under the GPL license.
