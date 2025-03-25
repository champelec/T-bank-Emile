class Animal {

    func speak() {
        print("Класс Animal")

    }
}

class Dog: Animal {

    override func speak() {
        print("Woof!")

    }
}

class Cat: Animal {

    override func speak() {
        print("Meow!")
    }
}

let animals: [Animal] = [Dog(), Dog(), Cat()]
for animal in animals {
    animal.speak()
}
