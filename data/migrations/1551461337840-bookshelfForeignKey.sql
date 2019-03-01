-- KEY: Table1 = table with contents we want to use migration for
-- Table2 = table with contents to put migration items into


CREATE TABLE BOOKSHELVES (id SERIAL PRIMARY KEY, name VARCHAR(255));

-- Making Table2 to copy contents we want to migrate to

INSERT INTO bookshelves(name) SELECT DISTINCT bookshelf FROM books;

-- putting unique bookshelf values into the new table from query 1

ALTER TABLE books ADD COLUMN bookshelf_id INT;

-- making a new column in Table1 to hold bookshelf id's

UPDATE books SET bookshelf_id=shelf.id FROM (SELECT * FROM bookshelves) AS shelf WHERE books.bookshelf = shelf.name;

-- Making the two tables be equal to each other, the bookshelf name in Table1 is equal to the new bookshelf id in Table2

ALTER TABLE books DROP COLUMN bookshelf;

-- Drops the initial existing bookshelf that contained repeats of bookshelves in Table1

ALTER TABLE books ADD CONSTRAINT fk_bookshelves FOREIGN KEY (bookshelf_id) REFERENCES bookshelves(id);

-- References the bookshelves in Table2 as a foriegn key in Table1