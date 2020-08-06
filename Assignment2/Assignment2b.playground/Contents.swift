/*:
 # Assignment 2B
 
 ### Problem 14
 Publish `[1, 2, 3]` immediately below such that
 
 1. type(of: c1) is AnyCancellable
 2. r1 contains ["2", "4", "6"]
 3. you use a single `map` operator
 4. your answer consists of no more than 4 lines of code
 */

import Combine

var r1: [String] = []
/// *Your Problem 14 code goes here*
let c1 = [1, 2, 3].publisher
    .map{"\($0 * 2)"}
    .sink {r1.append($0)}

type(of: c1)
r1 == ["2", "4", "6"]

/*:
### Problem 15
 Publish `sub1` immediately below such that
 
 1. type(of: c2) is AnyCancellable
 2. r2 == "6" is true
 3. you use a single `reduce` operator which sums values starting at 0
 4. your answer consists of no more than 4 lines of code
 */
var r2 = 0
let sub1 = PassthroughSubject<Int, Never>()
/// *Your Problem 15 code goes here*
var IntArray: [Int] = []
let c2 = sub1.sink{value in IntArray.append(value)}

sub1.send(1)
sub1.send(2)
sub1.send(3)
sub1.send(completion: .finished)

r2 += IntArray.reduce(0){$0+$1}

type(of: c2)
r2 == 6
/*:
### Problem 16
 Publish `c3` immediately below such that
 
 1. type(of: c3) is AnyCancellable
 2. r4 == "140" is true
 3. you use a single flatMap operator which produces a SequencePublisher
 4. the SequencePublisher publishes a sequence all of whose elements are the input value such it repeats the input value, value number of times
 (Hint: use the Array(repeating:, count:) initializer with the input value as both arguments)
 5. you use a single `reduce` operator which sums values starting at zero
 4. your answer consists of no more than 5 lines of code
 */

var r3 = ""
/// *Your Problem 16 code goes here*
let c3 = [1, 2, 3, 4, 5, 6, 7]
type(of: c3)
r3 == "140"

enum MyFirstError: Error {
    case first(Double)
}
enum MySecondError: Error {
    case second(Double)
}

var count = 0

/*:
### Problem 17
 Problem 18 comes in several parts.
 
 17.1 - Fill in the following function so that if the value is 0
 it throws MyFirstError.first(Double(count)) otherwise
 it increments count and returns value.  Your answer must
 use a guard-else statement as its first line and should
 consist of no more than 5 lines
 */
func isZero(_ value: Double) throws -> Double {
    guard value != 0 else {throw MyFirstError.first(Double(count))}
    count += 1
    return value
}
/*:
 17.2 - Fill in the following function so that if error
 is .first, it returns .second with the same
 associated value as .first
 */
func changeError(_ error: Error) -> MySecondError {
    switch error as? MyFirstError {
        /// ** Your problem 17.2 solution goes here **
    case.first(let d): return .second(d)
        default: return .second(0.0)
    }
}
/*:
 17.3 - Fill in the following function so that
 it returns `Just(Double(value))` where `value`
 is the associated value of `error`
*/
func toJust(_ error: MySecondError) -> Just<Double> {
    /// ** Your problem 17.3 solution replaces the following line **
    switch error {
    case .second(let x):
        return Just(x)
    }
}

var r4 = [Double]()
let sub2 = PassthroughSubject<Double, MyFirstError>()

/*:
 17.4 - Apply `tryMap`, `mapError`, and `catch` to `sub2`
 using your functions from above and use a `sink` which
 appends `$0` to the result variable defined above.
*/
/// *Your 17.4 answer goes here*
let c4 = sub2

    .tryMap{try isZero(Double(Int($0)))}
//.mapError(<#T##transform: (Error) -> Error##(Error) -> Error#>)
//.catch(<#T##handler: (Error) -> Publisher##(Error) -> Publisher#>)
//    .sink{ r4 .append($0)}

    
    

sub2.send(1)
sub2.send(2)
sub2.send(3)
sub2.send(0)
/*:
 17.5 - In one line only, cause sub2 to complete and verify that result = [1,2,3,3]
*/
sub2.send(completion: .finished)
r4 == [1,2,3,3]

/*:
### Problem 18
 Using the techniques demonstrated in class:
 
 1. make z1 and z2 into publishers
 1. make cz be an AnyCancellable of a Zip publisher which:
 
    - zips z1 and z2 together
    - maps the first value to twice its input and the second to uppercase
 
 1. Attach a sink which sets rz to be the most recent value
 
 Your answer may use no more 3 lines
 */

var rz = (0, "")
let z1 = [1, 2, 3, 4, 5]
let z2 = ["a", "b", "c", "d"]

/// *Your problem 18 code replaces the line below*
let cz = AnyCancellable { }

rz == (8, "D")

/*:
### Problem 19
 Using the techniques demonstrated in class, write a timer which:
 
 1. makes the variable `cancellable` its cancellable
 1. publishes every 2 seconds on the main thread in common mode
 1. autoconnects when subscribed
 
 Attach a sink which:
 
 1. increments `timesFired`,
 1. prints the number of times fired and the current time,
 1. cancels the timer after 5 fires, and
 1. prints "Cancelled"  when it cancels.
 
 Your answer may use no more 12 lines
 */
import Foundation

var timesFired = 0
var cancellable: AnyCancellable?
/// *Your problem 19 code goes here*
cancellable


struct Configuration: Codable, Equatable {
    public let title : String
    private let contents: [[Int]]
    
    public init(title: String, contents: [[Int]]) throws {
        self.title = title
        self.contents = contents
    }
}
    
let urlString = "https://www.dropbox.com/s/i4gp5ih4tfq3bve/S65g.json?dl=1"

public enum APIError: Error {
    case urlError(URLError)
    case badResponse
    case badResponseStatus(Int)
}

func verifyHttpResponse(data: Data?, response: URLResponse?) throws -> Data {
    guard let httpResponse = response as? HTTPURLResponse else {
        throw APIError.badResponse
    }
    guard httpResponse.statusCode == 200 else {
        throw APIError.badResponseStatus(httpResponse.statusCode)
    }
    return data ?? Data()
}

/*:
### Problem 20
 Using the techniques shown in class and the code immediately above,
 
 1. create a dataTaskPublisher on `c5` for `urlString`
 1. verify the response is valid in a tryMap
 1. decode the response as JSON into an array of Configuration objects
 1. write a sink which a) when receives a value sets the r5 variable to the value and b) on successful completion executes: `print("C'est Finis, r5 = \(r5)")` and on failure executes: `print("l'Erreur = \(error)")`
 */

var r5: [Configuration] = []
/// *Your Problem 20 code goes here*
var c5 = URLSession(configuration: URLSessionConfiguration.default)
