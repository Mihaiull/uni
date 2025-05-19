
using System.Runtime.CompilerServices;

class BookService
{
    private readonly BookRepository _bookRepository;
    private readonly BookValidator _bookValidator;

    public BookService(BookRepository bookRepository, BookValidator bookValidator){
        _bookRepository = bookRepository;
        _bookValidator = bookValidator;
    }

    // Method to add a new book
    public async Task<Book> GetBookById(Guid id){
        var book = await _bookRepository.
        GetBookByIdAsync(id);
        return book;
    }

    // Method to get all books
    public async Task<List<Book>> GetAll(){
        var books = await _bookRepository.GetAllBooksAsync();
        return books;
    }

    // Method to add a new book to the database
    public async Task AddBook(string title, string author, string publisher, int quantity){
        Guid id = Guid.NewGuid();
        Book book = new Book(title, author, publisher, quantity, id);

        if (_bookValidator.ValidateBook(book)){
            await _bookRepository.AddBookAsync(book);
        }
        else{
            throw new Exception("Invalid book data");
        }
    }

    // Method to delete a book by its ID
    public async Task DeleteBook(Guid id){
        var book = await _bookRepository.GetBookByIdAsync(id);
        if (book != null){
            await _bookRepository.DeleteBookAsync(id);
        }
        else{
            throw new Exception("Book not found");
        }
    }

    // Method to update an existing book
    public async Task UpdateBook(Guid id, Book book){
        if (_bookValidator.ValidateBook(book) && book.ID == id && book.ID != Guid.Empty){
            await _bookRepository.UpdateBookAsync(id, book);
        }
        else{
            throw new Exception("Invalid book data or ID mismatch");
        }
    }

    // Method to search for books by title or author based on a search term
    // This method will return a list of books that match the search term
    public async Task<List<Book>> SearchBooks(string searchTerm){
        var books = await _bookRepository.GetAllBooksAsync();
        return [.. books.Where(b => b.Title.Contains(searchTerm, StringComparison.OrdinalIgnoreCase) || b.Author.Contains(searchTerm, StringComparison.OrdinalIgnoreCase))];
    }
    // Method to get the total number of books in the database
    public async Task<int> GetTotalBooksCount(){
        var books = await _bookRepository.GetAllBooksAsync();
        return books.Count;
    }
    //Method to get the total quantity of all the books in the database
    public async Task<int> GetTotalBooksQuantity(){
        var books = await _bookRepository.GetAllBooksAsync();
        return books.Sum(b => b.Quantity);
    }
    // Method to get the total number of books by a specific author
    public async Task<int> GetTotalBooksByAuthor(string author){
        var books = await _bookRepository.GetAllBooksAsync();
        return books.Count(b => b.Author.Equals(author, StringComparison.OrdinalIgnoreCase));
    }
    // Method to get the total number of books by a specific publisher
    public async Task<int> GetTotalBooksByPublisher(string publisher){
        var books = await _bookRepository.GetAllBooksAsync();
        return books.Count(b => b.Publisher.Equals(publisher, StringComparison.OrdinalIgnoreCase));
    }
    // Method to get the total number of books by a specific title
    public async Task<int> GetTotalBooksByTitle(string title){
        var books = await _bookRepository.GetAllBooksAsync();
        return books.Count(b => b.Title.Equals(title, StringComparison.OrdinalIgnoreCase));
    }

    //Method to find a book based on different criteria
    public async Task<List<Book>> FindBooks(string? title = null, string? author = null, string? publisher = null){
        var books = await _bookRepository.GetAllBooksAsync();
        return books.Where(b => (string.IsNullOrEmpty(title) || b.Title.Contains(title, StringComparison.OrdinalIgnoreCase)) &&
                                (string.IsNullOrEmpty(author) || b.Author.Contains(author, StringComparison.OrdinalIgnoreCase)) &&
                                (string.IsNullOrEmpty(publisher) || b.Publisher.Contains(publisher, StringComparison.OrdinalIgnoreCase))).ToList();
    }
}