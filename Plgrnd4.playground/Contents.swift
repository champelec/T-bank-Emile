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
        if amount >= health {
            health = 0
        } else {
            health -= amount
        }
    }

    func heal(amount: Int) {
        health += amount
        // Ограничение на максимальное здоровье
        if health > 100 { // Пусть максимальное здоровье 100
            health = 100
        }
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
    var strength: Int

    // Исправленный инициализатор
    init(name: String, health: Int = 120, level: Int = 1, strength: Int = 10) {
        self.strength = strength
        super.init(name: name, health: health, level: level)
    }

    func attack(target: GameCharacter) {
        target.takeDamage(amount: strength * 2)
    }
}

// Класс Маг
class Mage: GameCharacter, Flyable, Healable {
    var magicPower: Int
    var fuelRemaining: Double = 100.0
    let maxFlightTime: Double = 200.0
    var healingAbility: Bool = true

    // Исправленный инициализатор
    init(name: String, health: Int = 80, level: Int = 1, magicPower: Int = 15) {
        self.magicPower = magicPower
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

    // Исправлено: добавлено имя метода
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
            target.heal(amount: magicPower * 2)
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
        warrior.strength *= 2
    }
}

// Предмет Зелье
struct Potion: Item {
    let name = "Зелье здоровья"
    let description = "Восстанавливает здоровье персонажа."
    let effect: (GameCharacter) -> Void = { character in
        character.heal(amount: 50)
    }
}

// Примеры использования
let warrior = Warrior(name: "Конрад")
let mage = Mage(name: "Мерлин")

warrior.printCharacterInfo() // Вывод информации о воине
mage.printCharacterInfo()     // Вывод информации о маге

// Атака воина на мага
warrior.attack(target: mage)
mage.printCharacterInfo()     // После атаки: Мерлин, Health: 60, Level: 1

// Лечение мага
mage.healTarget(target: mage)
mage.printCharacterInfo()     // После лечения: Мерлин, Health: 80, Level: 1

// Полёт мага
mage.fly(duration: 30)

