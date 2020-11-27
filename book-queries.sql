-- COSC210 Practical Assignment 1

-- Notes:
-- Question 1 returns two tuples with the book_title value being "The Cat in the Hat" due to their being separate records of two books with different date values for publication.
-- Question 6 returns separate tuples with identical book_title values due to their having different values for edition_isbn and therefore being distinct records.


-- *******************************************************************


CREATE VIEW old_books(first_name, last_name, book_title, edition) AS SELECT first_name, last_name, title, edition FROM authors, books, editions WHERE authors.author_id = books.author_id AND books.book_id = editions.book_id AND publication < '1990-01-01';


CREATE VIEW programming_or_perl(book_title) AS SELECT title FROM books WHERE title LIKE '%Programming%' OR title LIKE '%Perl%';


CREATE VIEW retail_price_hike(ISBN, retail_price, increased_price) AS SELECT isbn, retail, 1.25 * retail FROM stock;


CREATE VIEW book_summary(author_first_name, author_last_name, book_title, subject) AS SELECT first_name, last_name, title, subject FROM authors, books, subjects WHERE authors.author_id = books.author_id AND books.subject_id = subjects.subject_id;


CREATE VIEW value_summary(total_stock_cost, total_retail_cost) AS SELECT SUM(cost*stock), SUM(retail*stock) FROM stock;


CREATE VIEW profits_by_isbn(book_title, edition_isbn, total_profit) AS SELECT title, editions.isbn, SUM(retail - cost) FROM books, editions, shipments, stock WHERE books.book_id = editions.book_id AND editions.isbn = shipments.isbn AND editions.isbn = stock.isbn GROUP BY title, editions.isbn;


CREATE VIEW sole_python_author(author_first_name, author_last_name) AS SELECT DISTINCT first_name, last_name FROM authors, books WHERE authors.author_id = books.author_id AND title LIKE '%Python%' AND EXISTS (SELECT a2.first_name, a2.last_name FROM authors AS a2, books AS b2 WHERE a2.author_id = b2.author_id AND title LIKE '%Python%' AND a2.author_id IN (SELECT b3.author_id FROM books AS b3 WHERE b3.author_id = authors.author_id));


CREATE VIEW no_cat_customers(customer_first_name, customer_last_name) AS SELECT first_name, last_name FROM customers AS c1 WHERE NOT EXISTS (SELECT * FROM shipments AS s2, editions AS e2, books AS b2 WHERE c1.c_id = s2.c_id AND b2.book_id = e2.book_id AND s2.isbn = e2.isbn AND title = 'The Cat in the Hat');
