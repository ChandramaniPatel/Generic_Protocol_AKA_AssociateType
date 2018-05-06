struct GenericStruct<T>
{
    var property: T?
}

// I could either explicitly state the type of T or let Swift infer based on the value.

let explictStruct = GenericStruct<Bool>() // Here T is bool

let implicitStruct = GenericStruct(property: "Bob") // Here T is String

// Keep in mind of the principle that every type must be defined.
// Now come to Protocol

//Normal Protocol
// Let’s create a protocol that requires you to add property whose type is String.
//Design Protocol

protocol NormalProtocol {
    var property: String { get set }
}


//Design Class and Conform

class NormalClass : NormalProtocol {
    var property: String = "Bob"
}

//sound goood .Howerver NormalProtocol forces NormalClass to work with String.

//But what if you want property to be work with  Int or Bool

// Its time to introduce yourself with " Protocol Associated Types"

/****************************************** Introducing Protocol Associated Types ****************************/

protocol GenericProtocol {
    associatedtype myType // its makes this protocol to become generic protocol,type of myType will be provided by the class which are going to Conform GenericProtocol ,
    
    var anyProperty : myType {get set}
}

// So      Associated type = type alias + generics

/*
 
 Now, anything that conforms to GenericProtocol must implement anyProperty. However, the type is not defined. Therefore, the class or struct that conforms to the protocol must define it either implicitly or explicitly.
 
 */

/*First, let’s create a class SomeClass that conforms to GenericProtocol. We must define myType. Well, there are two ways to define as stated above.*/


/*Define Associated Type Implicitly
You may define myType based on the value associated with anyProperty.*/

/*//1 .
class SomeClass : GenericProtocol {
    var anyProperty: myType : "Bob"
}

//2.
class SomeClass1: GenericProtocol {
    var anyProperty = "Bob" // myType is "String"
}

 */

class SomeClass : GenericProtocol {
    typealias myType = String
    var anyProperty: String = "Bob"
    // it can be write like  below too
    //  var anyProperty: myType = "Bob"
}

struct SomeStruct  : GenericProtocol {
    typealias myType = Int
    var anyProperty: Int = 100
}


extension  GenericProtocol  {
    static func introduce() {
     print("I'm Bob from Static Method,called by type's name AKA struct,class or enum name")
    }
    
    func address(anyThing : myType)  {
        print("anyThing IS : \(anyThing) I'm address from Instance Method,called by type' Instance")
    }
}

SomeClass.introduce() // I'm Bob
SomeStruct.introduce() // I'm Bob

let sc = SomeClass()
sc.anyProperty
sc.address(anyThing: sc.anyProperty)

let ss = SomeStruct()
ss.anyProperty
ss.address(anyThing: ss.anyProperty)

// Introducing Where Clause

/*
 Let’s s add introduceMe() for those who not only conform to GenericProtocol but also has the associatedtype ,a.k.a myType as String.
 */

extension GenericProtocol  where myType == String {
    func introduceMe(){
        print("I'm  introduceMe and extension OF  GenericProtocol which only work when  myType will be String")
    }
}

let someClass = SomeClass()
someClass.anyProperty = "CM"
someClass.address(anyThing: someClass.anyProperty)
someClass.introduceMe()

let someStruct = SomeStruct()
someStruct.anyProperty
someStruct.address(anyThing: someStruct.anyProperty)


struct  AnotherSomeStruct : GenericProtocol {
    typealias myType = String
    var anyProperty: String
}

var  anotherSomeStruct = AnotherSomeStruct(anyProperty: "another struct with my type String")
anotherSomeStruct.anyProperty
anotherSomeStruct.address(anyThing: anotherSomeStruct.anyProperty)
anotherSomeStruct.introduceMe()

/*
 The where clause above state, if myType is String, proceed, if not ignore the entire extension block.
 */


 

// this extension only work for those which not only conform to GenericProtocol as well as myType will be String and Type(Class, Enum,Struct) type would be SomeClass
extension GenericProtocol where myType == String , Self == SomeClass {
    func introduceMeAgain(){
print("I'm  introduceMe another extension OF  GenericProtocol and I only will be available to whoome which are having myType is String and Class type AKA Type type should be  SomeClass  ")    }
}

let someClassInstance1 = SomeClass()
someClassInstance1.anyProperty
someClassInstance1.address(anyThing: someClassInstance1.anyProperty)
someClassInstance1.introduceMeAgain()

let someStructInstance1 = SomeStruct(anyProperty: 300)
someStructInstance1.anyProperty
someStructInstance1.address(anyThing: someStructInstance1.anyProperty)
//someStructInstance1.introduceMeAgain() // Error
//someStructInstance1.introduceMe() // error


let someAnotherStructInstance1 = AnotherSomeStruct(anyProperty: "Radha")
someAnotherStructInstance1.anyProperty
someAnotherStructInstance1.introduceMe()
//someAnotherStructInstance1.introduceMeAgain() // Error


// Override Associated Type //


/*
 
 protocol GenericProtocol {
 associatedtype myType
 var anyProperty: myType { get set }
 }
 
 The type of myType has been defined by those who conform to the protocol. However, you may also pre-defined associatedtype within a protocol as well.
 

 */



















