import Foundation

struct Book {
    var bookname: String
    var author: String
    var price: Double
    var genre: Genre
}

enum Genre {
    case romance
    case science_fiction
    case drama
    case comedy
    case historical
    case fiction
    case novel
    case poems
}

class Library {
    var books: [Book] = []
    func bookAdd(_ book: Book){
        books.append(book)
    }
    
    func bookfilter(by genre: Genre) -> [Book] {
        books.filter { $0.genre == genre }
        
    }
    func bookfilter(by name: String) -> [Book] {
        books.filter { $0.bookname.lowercased().contains(name.lowercased())
        }
    }
}

class Reader {
    public var name: String
    public var discount: Double
    private var basket: [Book] = []
    init(name: String, discount: Double) {
        self.name = name
        self.discount = discount
    }
    
    func basketadd(_ books: [Book]) {
        basket.append(contentsOf: books)
    }
    
    func getBasket() -> [Book] {
        return basket
    }
    
    func priceSum() -> Double {
        let total = basket.reduce(0) { $0 + $1.price }
        return total - (total * discount / 100)
    }
    
    func basketToolsSorted(by order: SortOrder) -> [Book] {
        switch order {
        case .alphabetical:
            basket.sorted { $0.bookname < $1.bookname }
        case .byPrice:
            basket.sorted { $0.price < $1.price }
        
            }
        }
    }

enum SortOrder {
    case alphabetical
    case byPrice
}

let library = Library()
library.bookAdd(Book(bookname: "Гарри Поттер и философский камень", author: "Дж.К. Роулинг", price: 1000, genre: .fiction))
library.bookAdd(Book(bookname: "Война и мир", author: "Лев Толстой", price: 850, genre: .novel))
library.bookAdd(Book(bookname: "Стихотворение", author: "Владимир Маяковский", price: 540, genre: .poems))
let reader = Reader(name: "Алиса", discount: 1.5)
let novelBooks = library.bookfilter(by: .novel)
reader.basketadd(novelBooks)
let booksWithName = library.bookfilter(by: "Гарри")
reader.basketadd(booksWithName)
for book in reader.basketToolsSorted(by: .alphabetical) {
    print("• \(book.bookname) от \(book.author) - \(book.price) руб.")
}
print("• Цена корзины: \(reader.priceSum()) руб.")

