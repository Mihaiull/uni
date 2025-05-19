class UI {
    private BookService _bookService;


    public UI( BookService bookService) {
        _bookService = bookService;
    }
    public void DisplayMenu() {
        Console.WriteLine("Welcome to the Book Management System");
        Console.WriteLine("0. Exit");
        Console.WriteLine("1. Add a new book");
        Console.WriteLine("2. Delete a book");
        Console.WriteLine("3. Update a book");
        Console.WriteLine("4. Search for books");
        Console.WriteLine("5. Display all books");
    }

    public void Run() {
        while (true) {
            DisplayMenu();
            Console.Write("Please select an option: ");
            var choice = Console.ReadLine();
            switch (choice) {
                case "0":
                    Console.WriteLine("Exiting the program.");
                    return;
                case "1":
                    AddBook();
                    break;
                case "2":
                    DeleteBook();
                    break;
                case "3":
                    UpdateBook();
                    break;
                case "4":
                    SearchBooks();
                    break;
                case "5":
                    var books = _bookService.GetAll().Result;
                    if (books.Count == 0) {
                        Console.WriteLine("No books found.");
                    } else {
                        foreach (var book in books) {
                            book.DisplayDetails();
                        }
                    }
                    break;
                default:
                    Console.WriteLine("Invalid choice. Please try again.");
                    break;
            }
        }
    }

    private void AddBook() {
        Console.Write("Enter book title: ");
        var title = Console.ReadLine();
        if (string.IsNullOrWhiteSpace(title)) {
            throw new ArgumentException("Title cannot be empty.");
        }
        Console.Write("Enter book author: ");
        var author = Console.ReadLine();
        if (string.IsNullOrWhiteSpace(author)) {
            throw new ArgumentException("Author cannot be empty.");
        }
        Console.Write("Enter book publisher: ");
        var publisher = Console.ReadLine();
        if (string.IsNullOrWhiteSpace(publisher)) {
            throw new ArgumentException("Publisher cannot be empty.");
        }
        Console.Write("Enter book quantity: ");
        if (!int.TryParse(Console.ReadLine(), out var quantity)) {
            throw new ArgumentException("Invalid quantity. Please enter a valid number.");
        }
        _bookService.AddBook(title, author, publisher, quantity).Wait();
        Console.WriteLine("Book added successfully.");
    }

    void DeleteBook() {
        Console.Write("Enter book ID to delete: ");
        var input = Console.ReadLine();
        if (string.IsNullOrWhiteSpace(input)) {
            throw new ArgumentException("Book ID cannot be empty.");
        }
        var id = Guid.Parse(input);
        _bookService.DeleteBook(id).Wait();
        Console.WriteLine("Book deleted successfully.");
    }

    void UpdateBook() {
        Console.Write("Enter book ID to update: ");
        var input = Console.ReadLine();
        if (string.IsNullOrWhiteSpace(input)) {
            throw new ArgumentException("Book ID cannot be empty.");
        }
        var id = Guid.Parse(input);
        Console.Write("What do you want to update? Choose one or more:\n1. Title\n2. Author\n3. Publisher\n4. Quantity\n");
        var choice = Console.ReadLine();
        if (string.IsNullOrWhiteSpace(choice)) {
            throw new ArgumentException("Choice cannot be empty.");
        }
        //parse the choice into a list of integers
        var choices = choice.Split(',').Select(c => int.Parse(c.Trim())).ToList();

        var book = _bookService.GetBookById(id).Result;
        if (book == null) {
            throw new ArgumentException("Book not found.");
        }

        while (choices.Any()) {
            if (choices.Contains(1)) {
                Console.Write("Enter new title: ");
                var title = Console.ReadLine();
                if (string.IsNullOrWhiteSpace(title)) {
                    throw new ArgumentException("Title cannot be empty.");
                }
                book.Title = title;
                choices.Remove(1);
            }
            if (choices.Contains(2)) {
                Console.Write("Enter new author: ");
                var author = Console.ReadLine();
                if (string.IsNullOrWhiteSpace(author)) {
                    throw new ArgumentException("Author cannot be empty.");
                }
                book.Author = author;
                choices.Remove(2);
            }
            if (choices.Contains(3)) {
                Console.Write("Enter new publisher: ");
                var publisher = Console.ReadLine();
                if (string.IsNullOrWhiteSpace(publisher)) {
                    throw new ArgumentException("Publisher cannot be empty.");
                }
                book.Publisher = publisher;
                choices.Remove(3);
            }
            if (choices.Contains(4)) {
                Console.Write("Enter new quantity: ");
                if (!int.TryParse(Console.ReadLine(), out var quantity)) {
                    throw new ArgumentException("Invalid quantity. Please enter a valid number.");
                }
                book.Quantity = quantity;
                choices.Remove(4);
            }
        }
        _bookService.UpdateBook(id, book).Wait();
        Console.WriteLine("Book updated successfully.");
        
    }

    void SearchBooks() {
        Console.Write("Enter search term (title or author): ");
        var searchTerm = Console.ReadLine();
        if (string.IsNullOrWhiteSpace(searchTerm)) {
            throw new ArgumentException("Search term cannot be empty.");
        }
        var books = _bookService.SearchBooks(searchTerm).Result;
        if (books.Count == 0) {
            Console.WriteLine("No books found.");
        } else {
            foreach (var book in books) {
                book.DisplayDetails();
            }
        }
    }

}