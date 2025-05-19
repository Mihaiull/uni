BookRepository bookRepository = new BookRepository();
BookService bookService = new BookService(bookRepository, new BookValidator());
UI ui = new UI(bookService);
try{
    // Initialize the database and create the table if it doesn't exist
    ui.Run();
}
    catch (Exception ex)
    {
        Console.WriteLine($"An error occurred: {ex.Message}");
    }
    finally
    {
        Console.WriteLine("Program terminated.");
    }