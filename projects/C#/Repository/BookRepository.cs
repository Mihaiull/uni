// Repository for managing book data
//it works with a relational database
//in this case we are using SQLite (because I find it very easy to work with)
using System.Data.SQLite;
using Microsoft.Extensions.Configuration;

class BookRepository{

    // Connection string to connect to the SQLite database
    private string connectionString;

    // Constructor to initialize the connection string
    // It reads the connection string from the appsettings.json file
    public BookRepository(){
        var configuration = new ConfigurationBuilder();
        configuration.SetBasePath(Directory.GetCurrentDirectory());
        configuration.AddJsonFile("appsettings.json");
        configuration.Build();

        connectionString = configuration.Build().GetConnectionString("SQLite") ?? throw new InvalidOperationException("Connection string for SQLite is not configured.");
        
    }

    // Method to add a new book to the database
    private void AddBook(Book book){
        using (var connection = new SQLiteConnection(connectionString)){
            connection.Open();
            var command = new SQLiteCommand("INSERT INTO books (id, title, author, publisher, quantity) VALUES (@id, @title, @author, @publisher, @quantity)", connection);
            command.Parameters.AddWithValue("@id", book.ID);
            command.Parameters.AddWithValue("@title", book.Title);
            command.Parameters.AddWithValue("@author", book.Author);
            command.Parameters.AddWithValue("@publisher", book.Publisher);
            command.Parameters.AddWithValue("@quantity", book.Quantity);
            command.ExecuteNonQuery();
        }
    }
    
    public async Task AddBookAsync(Book book){
        await Task.Run(() => AddBook(book));
    }

    // Method to delete a book from the database
    private void DeleteBook(Guid id){
        using (var connection = new SQLiteConnection(connectionString))
        {
            connection.Open();
            var command = new SQLiteCommand("DELETE FROM books WHERE id = @id", connection);
            command.Parameters.AddWithValue("@id", id);
            command.ExecuteNonQuery();
        }
    }

    public async Task DeleteBookAsync(Guid id){
        await Task.Run(() => DeleteBook(id));
    }

   // Method to get a book by its ID
    private Book GetBookById(Guid id){
        using (var connection = new SQLiteConnection(connectionString)){
            connection.Open();
            var command = new SQLiteCommand("SELECT * FROM books WHERE id = @id", connection);
            command.Parameters.AddWithValue("@id", id);
            using (var reader = command.ExecuteReader()){
                if (reader.Read()){
                    var idString = reader["id"]?.ToString();
                    Guid parsedId = Guid.Empty;
                    if (!string.IsNullOrWhiteSpace(idString))
                    {
                        // Try normal parse first
                        if (!Guid.TryParse(idString, out parsedId))
                        {
                            // Try to parse as 32-char hex string (no hyphens)
                            if (idString.Length == 32)
                            {
                                var formatted = $"{idString.Substring(0, 8)}-{idString.Substring(8, 4)}-{idString.Substring(12, 4)}-{idString.Substring(16, 4)}-{idString.Substring(20)}";
                                Guid.TryParse(formatted, out parsedId);
                            }
                        }
                    }
                    return new Book(
                        reader["title"]?.ToString() ?? string.Empty,
                        reader["author"]?.ToString() ?? string.Empty,
                        reader["publisher"]?.ToString() ?? string.Empty,
                        Convert.ToInt32(reader["quantity"]),
                        parsedId
                    );
                }
            }
            throw new Exception("Error: Book not found or ID is null");
        }
    }
    public async Task<Book> GetBookByIdAsync(Guid id){
        return await Task.Run(() => GetBookById(id));
    }


        // Method to get all books from the database
    private List<Book> GetAllBooks(){
        var books = new List<Book>();
        using (var connection = new SQLiteConnection(connectionString)){
            connection.Open();
            var command = new SQLiteCommand("SELECT * FROM books", connection);
            using (var reader = command.ExecuteReader()){
                while (reader.Read()){
                    var idString = reader["id"]?.ToString();
                    Guid parsedId = Guid.Empty;
                    if (!string.IsNullOrWhiteSpace(idString))
                    {
                        // Try normal parse first
                        if (!Guid.TryParse(idString, out parsedId))
                        {
                            // Try to parse as 32-char hex string (no hyphens)
                            if (idString.Length == 32)
                            {
                                var formatted = $"{idString.Substring(0, 8)}-{idString.Substring(8, 4)}-{idString.Substring(12, 4)}-{idString.Substring(16, 4)}-{idString.Substring(20)}";
                                Guid.TryParse(formatted, out parsedId);
                            }
                        }
                    }
                    if (parsedId == Guid.Empty)
                    {
                        // Optionally log or handle the invalid ID row
                        continue; // Skip this row
                    }
                    books.Add(new Book(
                        reader["title"]?.ToString() ?? string.Empty,
                        reader["author"]?.ToString() ?? string.Empty,
                        reader["publisher"]?.ToString() ?? string.Empty,
                        Convert.ToInt32(reader["quantity"]),
                        parsedId
                    ));
                }
            }
        }
        return books;
    }

    public async Task<List<Book>> GetAllBooksAsync(){
        return await Task.Run(() => GetAllBooks());
    }

    // Method to update a book's details
    private Book UpdateBook(Guid id, Book book){
        using (var connection = new SQLiteConnection(connectionString)){
            connection.Open();
            var command = new SQLiteCommand("UPDATE books SET title = @title, author = @author, publisher = @publisher, quantity = @quantity WHERE id = @id", connection);
            command.Parameters.AddWithValue("@title", book.Title);
            command.Parameters.AddWithValue("@author", book.Author);
            command.Parameters.AddWithValue("@publisher", book.Publisher);
            command.Parameters.AddWithValue("@quantity", book.Quantity);
            command.Parameters.AddWithValue("@id", id);
            command.ExecuteNonQuery();
        }
        return book;
    }

    public async Task<Book> UpdateBookAsync(Guid id, Book book){
        return await Task.Run(() => UpdateBook(id, book));
    }

}
