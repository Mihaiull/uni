class BookValidator{
    public bool ValidateBook(Book book){
        if (string.IsNullOrEmpty(book.Title)){
            return false;
        }
        if (string.IsNullOrEmpty(book.Author)){
            return false;
        }
        if (book.Quantity < 0){
            return false;
        }
        if (string.IsNullOrEmpty(book.Publisher)){
            return false;
        }
        if (book.ID == Guid.Empty){
            return false;
        }
        return true;
    }
}