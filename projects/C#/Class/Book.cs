// Book.cs
// This class represents a book in the library system
// It contains properties for the book's title, author, publisher, quantity, price, and ID

class Book{
    private string title;
    private string author;
    private string publisher;
    private int quantity;
    private Guid id;

    // Constructor to initialize a new book
    public Book(string title, string author, string publisher, int quantity, Guid id){
        this.title = title;
        this.author = author;
        this.publisher = publisher;
        this.quantity = quantity;
        this.id = id;
    }
    // Properties to get and set the book's details
    public string Title{
        get { return title; }
        set { title = value; }
    }
    public string Author{
        get { return author; }
        set { author = value; }
    }
    public string Publisher{
        get { return publisher; }
        set { publisher = value; }
    }
    public int Quantity{
        get { return quantity; }
        set { quantity = value; }
    }
    public Guid ID{
        get { return id; }
    }
    // Method to display the book's details
    public void DisplayDetails(){
        Console.WriteLine("Title: " + title);
        Console.WriteLine("Author: " + author);
        Console.WriteLine("Publisher: " + publisher);
        Console.WriteLine("Quantity: " + quantity);
        Console.WriteLine("ID: " + id.ToString());
    }
    // Method to check if the book is available
    public bool IsAvailable(){
        return quantity > 0;
    }
    // Method to borrow a book
    public void Borrow(){
        if(IsAvailable()){
            quantity--;
            Console.WriteLine("You have borrowed the book: " + title);
        }else{
            Console.WriteLine("Sorry, the book is not available.");
        }
    }
    // Method to return a book
    public void Return(){
        quantity++;
        Console.WriteLine("You have returned the book: " + title);
    }
}