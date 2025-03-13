import Foundation

struct Book {
    let bookname: String
    let author: String
    let price: Double
    let genre: Genre
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
    private var books: [Book] = [] // Ограниченный доступ к массиву книг
    
    func bookAdd(_ book: Book) {
        books.append(book)
    }
    
    func bookfilter(by genre: Genre) -> [Book] {
        return books.filter { $0.genre == genre }
    }
    
    func bookfilter(by name: String) -> [Book] {
        return books.filter { $0.bookname.lowercased().contains(name.lowercased()) }
    }
}

class Reader {
    public var name: String
    private var basket: [Book] = []
    
    init(name: String) {
        self.name = name
    }
    
    func basketAdd(_ books: [Book]) {
        basket.append(contentsOf: books)
    }
    
    func getBasket() -> [Book] {
        return basket
    }
    
    func priceSum(with discount: Double) -> Double {
        let total = basket.reduce(0) { $0 + $1.price }
        return total - (total * discount / 100)
    }
    
    func basketSorted(by order: SortOrder) -> [Book] {
        switch order {
        case .alphabetical:
            return basket.sorted { $0.bookname < $1.bookname }
        case .byPrice:
            return basket.sorted { $0.price < $1.price }
        }
    }
}

enum SortOrder {
    case alphabetical
    case byPrice
}

// Пример использования
let library = Library()
library.bookAdd(Book(bookname: "Гарри Поттер и философский камень", author: "Дж.К. Роулинг", price: 1000, genre: .fiction))
library.bookAdd(Book(bookname: "Война и мир", author: "Лев Толстой", price: 850, genre: .novel))
library.bookAdd(Book(bookname: "Стихотворение", author: "Владимир Маяковский", price: 540, genre: .poems))

let reader = Reader(name: "Алиса")

let novelBooks = library.bookfilter(by: .novel)
reader.basketAdd(novelBooks)

let booksWithName = library.bookfilter(by: "Гарри")
reader.basketAdd(booksWithName)

for book in reader.basketSorted(by: .alphabetical) {
    print("• \(book.bookname) от \(book.author) - \(book.price) руб.")
}

let discount = 1.5
print("• Цена корзины: \(reader.priceSum(with: discount)) руб.")
