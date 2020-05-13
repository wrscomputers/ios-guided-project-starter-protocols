import Foundation

//: # Protocols
//: Protocols are, as per Apple's definition in the _Swift Programming Language_ book:
//:
//: "... a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality. The protocol can then be adopted by a class, structure, or enumeration to provide an actual implementation of those requirements. Any type that satisfies the requirements of a protocol is said to conform to that protocol."
//:
//: The below example shows a protocol that requires conforming types have a particular property defined.
// Anyone using this protocol must have a fullName property.
protocol FullyNamed {
    var fullName: String { get }
}

// The ": FullyNamed" is the "adoption" or promise that we will follow the protocol's requirements
struct Person: FullyNamed {
    var fullName: String
}

let me = Person(fullName: "Spencer Curtis")

class Starship: FullyNamed {
    
    // The starship could have prefix but not all will
    var prefix: String?
    var name: String
    
    init(prefix: String?, name: String) {
        self.name = name
        self.prefix = prefix
    }
    
    // Conformance to the FullyNamed protocol
    var fullName: String {
        if let unwrappedPrefix = prefix {
            return "\(unwrappedPrefix) \(name)"
        } else {
            return name
        }
    }
}

extension Starship: Equatable {
    // All we need to do is compare each side and see if they have the same values or not
    static func == (lhs: Starship, rhs: Starship) -> Bool {
        if lhs.fullName == rhs.fullName {
            return true
        } else {
            return false
        }
    }
}


let enterprise = Starship(prefix: "USS", name: "Enterprise")
enterprise.name = "Lambda"

let serenity = Starship(prefix: nil, name: "Firefly")


let fullyNamedThings: [FullyNamed] = [me, enterprise]

for thing in fullyNamedThings {
    print(thing.fullName)
}
//: Protocols can also require that conforming types implement certain methods.
protocol GeneratesRandomNumbers {
    // We intentionally don't write the implementation of this function in the protocol. We instead leave it to the adopters of the protocol to create their own implementation.
    func random() -> Int
}

class OneThroughTen: GeneratesRandomNumbers {
    func random() -> Int {
        return Int.random(in: 1...10)
    }
}

let generator = OneThroughTen()

generator.random()
//: Using built-in Protocols
if 100 == 100 {
    print("The numbers are the same")
}

if serenity == enterprise {
    print("They are the same")
}

//: ## Protocols as Types


