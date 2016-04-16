

import UIKit

class Dog {
    var name : String
    required init(name:String) {
        self.name = name
    }
    class func makeAndName() -> Dog {
        let d = self.init(name:"Fido") // newly required in Swift 2.0
        return d
    }
    class func makeAndName2() -> Self {
        let d = self.init(name:"Fido") // newly required in Swift 2.0
        return d
    }
    func havePuppy(name:String) -> Self {
        return self.dynamicType.init(name:name) // ditto
    }
}
class NoisyDog : Dog {
}
func dogMakerAndNamer(_ whattype:Dog.Type) -> Dog {
    let d = whattype.init(name:"Fido") // ditto; compile error, unless `init(name:)` is `required`
    return d
}

func typeTester(_ d:Dog, _ whattype:Dog.Type) {
    // if d.dynamicType is whattype { // compile error, "not a type" (i.e. a not a type literal)
    if d.dynamicType === whattype {
        print("yep")
    } else {
        print("nope")
    }
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let d = dogMakerAndNamer(Dog) // d is a Dog named Fido
        let d2 = dogMakerAndNamer(NoisyDog) // d2 is a NoisyDog named Fido

        let dd = Dog.makeAndName() // d is a Dog named Fido
        let dd2 = NoisyDog.makeAndName() // d2 is a NoisyDog named Fido - but typed as Dog
        
        let ddd = Dog.makeAndName2() // d is a Dog named Fido
        let ddd2 = NoisyDog.makeAndName2() // d2 is a NoisyDog named Fido, typed as NoisyDog
        
        typeTester(Dog(name:"fido"), NoisyDog.self)
        typeTester(Dog(name:"fido"), Dog.self)
        typeTester(NoisyDog(name:"fido"), NoisyDog.self)
        typeTester(NoisyDog(name:"fido"), Dog.self)


        do {
            let d = Dog(name:"Fido")
            let d2 = d.havePuppy(name:"Fido Junior")
            let nd = NoisyDog(name:"Rover")
            let nd2 = nd.havePuppy(name:"Rover Junior")
            
            _ = d
            _ = d2
            _ = nd
            _ = nd2
        }
        
        _ = d
        _ = dd
        _ = ddd
        _ = d2
        _ = dd2
        _ = ddd2
    }

}

