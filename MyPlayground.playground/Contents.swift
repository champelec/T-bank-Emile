import Foundation

struct Book{
    let bookname:String
    let author:String
    let price:Double
    let genre:Genre
}
enum Genre{
    case romance
    case science_fiction
    case drama
    case comedy
    case historical
    case fiction
    case novel
    case poems
}
class Library{
    var books: [Book]=[]
    func Bookadd(_ book: Book){
        books.append(book)
    }
    func Bookfilter(by genre: Genre) -> [Book] {
        return books.filter { $0.genre == genre }
    }
    func Bookfilter1(by name: String) -> [Book] {
        return books.filter { $0.bookname.lowercased().contains(name.lowercased())
        }
    }
}
class Reader{
    var name:String
    var discount: Double
    var basket: [Book] = []
    init(name: String, discount: Double) {
        self.name = name
        self.discount = discount
    }
    func Basketadd(_ books: [Book]) {
        basket.append(contentsOf: books)
    }
    func PriceSum() -> Double {
        let total = basket.reduce(0) { $0 + $1.price }
        return total - (total * discount / 100)
    }
    func BasketToolsSorted(by order: SortOrder) -> [Book] {
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
let library = Library()
library.Bookadd(Book(bookname: "Гарри Поттер и философский камень", author: "Дж.К. Роулинг", price: 1000, genre: .fiction))
library.Bookadd(Book(bookname: "Война и мир", author: "Лев Толстой", price: 850, genre: .novel))
library.Bookadd(Book(bookname: "Стихотворение", author: "Владимир Маяковский", price: 540, genre: .poems))
let reader = Reader(name: "Алиса", discount: 1.5)
let novelBooks = library.Bookfilter(by: .novel)
reader.Basketadd(novelBooks)
let booksWithName = library.Bookfilter1(by: "Гарри")
reader.Basketadd(booksWithName)
for book in
        reader.BasketToolsSorted(by: .alphabetical) {
    print("• \(book.bookname) от \(book.author) - \(book.price) руб.")
}
print("• Цена корзины: \(reader.PriceSum()) руб.")


