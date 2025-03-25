import Foundation

// Базовый класс персонажа игры
class GameCharacter {
    var name: String
    var health: Int
    var level: Int

    // Конструктор
    init(name: String, health: Int = 100, level: Int = 1) {
        self.name = name
        self.health = health
        self.level = level
    }

    // Методы
    func takeDamage(amount: Int) {
        health = max(0, health - amount)
    }

    func heal(amount: Int) {
        health = min(health + amount, 100) // Пусть максимальное здоровье 100
    }

    func levelUp() {
        level += 1
    }
}

// Протокол для способности летать
protocol Flyable {
    var fuelRemaining: Double { get set }
    var maxFlightTime: Double { get }
    
    mutating func fly(duration: Double)
}

// Протокол для способности лечить
protocol Healable {
    var healingAbility: Bool { get }
    func healTarget(target: GameCharacter)
}

// Класс Воин
class Warrior: GameCharacter {
    private(set) var strength: Int // Сделано более безопасным

    init(name: String, health: Int = 120, level: Int = 1, strength: Int = 10) {
        self.strength = strength
        super.init(name: name, health: health, level: level)
    }

    // Метод для безопасного изменения силы
    func increaseStrength(by amount: Int) {
        strength += amount
    }

    func attack(target: GameCharacter) {
        target.takeDamage(amount: strength * 2)
    }
}

// Класс Маг
class Mage: GameCharacter, Flyable, Healable {
    private(set) var magicPower: Int // Сделано более безопасным
    var fuelRemaining: Double = 100.0
    let maxFlightTime: Double
    var healingAbility: Bool = true

    init(name: String, health: Int = 80, level: Int = 1, magicPower: Int = 15, maxFlightTime: Double = 200.0) {
        self.magicPower = magicPower
        self.maxFlightTime = maxFlightTime
        super.init(name: name, health: health, level: level)
    }

    func castSpell(spellName: String, target: GameCharacter) {
        switch spellName {
        case "Fireball":
            target.takeDamage(amount: magicPower * 3)
        default:
            break
        }
    }

    func fly(duration: Double) {
        if duration <= fuelRemaining && duration <= maxFlightTime {
            fuelRemaining -= duration
            print("\(name) летал \(duration) секунд.")
        } else {
            print("Недостаточно топлива или времени для полета!")
        }
    }

    func healTarget(target: GameCharacter) {
        if healingAbility {
            target.heal(amount: magicPower * 2) // Замените значение 2 на параметр через инициализацию, если нужно
        }
    }
}

// Расширение базового класса
extension GameCharacter {
    // Вычисляемое свойство для проверки жив ли персонаж
    var isAlive: Bool {
        return health > 0
    }

    // Метод для вывода информации о персонаже
    func printCharacterInfo() {
        print("Имя: \(name), Здоровье: \(health), Уровень: \(level)")
    }
}

// Протокол для предмета
protocol Item {
    var name: String { get }
    var description: String { get }
    var effect: (GameCharacter) -> Void { get }
}

// Предмет Меч
struct Sword: Item {
    let name = "Меч Экскалибур"
    let description = "Могучий меч, который увеличивает силу владельца."
    let effect: (GameCharacter) -> Void = { character in
        guard let warrior = character as? Warrior else { return }
        warrior.increaseStrength(by: 10) // Увеличиваем силу на 10
        print("\(warrior.name) увеличил свою силу на 10.")
    }
}

// Предмет Зелье
struct Potion: Item {
    let name = "Зелье здоровья"
    let description = "Восстанавливает здоровье персонажа."
    let effect: (GameCharacter) -> Void = { character in
        character.heal(amount: 50) // Значение 50 можно сделать параметрическим
    }
}

// Примеры использования
let warrior = Warrior(name: "Конрад")
let mage = Mage(name: "Мерлин")

// Вывод информации о начальных статусах персонажей
print("Начальные статусы:")
warrior.printCharacterInfo()
mage.printCharacterInfo()

// Атака воина на мага
print("\nВоин атакует мага:")
warrior.attack(target: mage)
mage.printCharacterInfo()

// Использование предмета Меч
print("\nИспользование предмета Меч:")
let sword = Sword()
sword.effect(warrior)
warrior.printCharacterInfo()

// Атака воина на мага после использования меча
print("\nВоин атакует мага после использования меча:")
warrior.attack(target: mage)
mage.printCharacterInfo()

// Лечение мага
print("\nМаг лечит себя:")
mage.healTarget(target: mage)
mage.printCharacterInfo()

// Использование предмета Зелье
print("\nИспользование предмета Зелье:")
let potion = Potion()
potion.effect(mage)
mage.printCharacterInfo()

// Полёт мага
print("\nМаг пытается полететь:")
mage.fly(duration: 30)
mage.printCharacterInfo()


