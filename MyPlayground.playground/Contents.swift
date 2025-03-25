//class Person {
//    let name: String
//    var car: Car?
//    
//    init(name: String) {
//        self.name = name
//        print("Person \(name) created")
//    }
//    
//    deinit {
//        print("Person \(name) allocated" )
//    }
//}
//class Car {
//    var owner: Person?
//    
//    init(owner: Person?) {
//        self.owner = owner
//        print("Car created for owner: \(owner?.name ?? "nil")")
//    }
//    deinit {
//        print("Car \(String(describing: owner)) allocated")
//    }
//}
//
//var person: Person? = Person(name: "Emile")
//var car: Car? = Car(owner: person)
//
//person = nil
//car = nil

//Console output without 'weak' (strong)
//Person Emile created
//Car created for owner: Emile
//Car Optional(__lldb_expr_47.Person) allocated
//Person Emile allocated

class Person {
    let name: String
    var car: Car?
    
    init(name: String) {
        self.name = name
        print("Person \(name) created")
    }
    
    deinit {
        print("Person \(name) allocated" )
    }
}
class Car {
    weak var owner: Person?
    
    init(owner: Person?) {
        self.owner = owner
        print("Car created for owner: \(owner?.name ?? "nil")")
    }
    deinit {
        print("Car \(String(describing: owner)) allocated")
    }
}

var person: Person? = Person(name: "Emile")
var car: Car? = Car(owner: person)

person = nil
car = nil

//Console output with 'weak'
//Person Emile created
//Car created for owner: Emile
//Person Emile allocated
//Car nil allocated
