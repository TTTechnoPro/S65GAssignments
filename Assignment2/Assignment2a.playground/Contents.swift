/*:
 # Assignment 2
 
 The intent of this homework set is to make sure that you:
 
 1. have a firm grasp of the use functional composition in Swift and
 1. can correctly use important concepts from Apple's Combine library
 
 There are two playgrounds in this Assignment Assignment2a and Assignment2b.
 Playground A is mainly asking you read code and answer questions, playground
 B is all coding. Be sure to keep both playgrounds in a compiling state.
 
 Once again, to the extent possible, I have given you
 a template for all the neccesary code here and have
 only asked you to fill in the details.
 
 To complete this assignment, you need to have a basic understanding
 of the following Swift concepts:
 
 * Functions lifted to nominal types and the use of the `callAsFunction` function on structs, classes or enums
 * Generics in Swift
 * Functional composition using generics
 * Map/FlatMap/Reduce as general operations on generic types
 * Recursive functional composition using generics
 * Principles of Functional Reactive Programming
 * Basic operations of Combine Publishers and Subscribers
 * Basic use of Combine as a tool for asynchronous programming, in
 particular with timers and network calls.
 
 Before attempting this homework, you should first read the Learn-swift playgrounds: 1-12, 26-31, and 33-35
 
 You should also keep these readily at hand while doing this assignment.
 
 Once again, **ALL** answers are to be given in line.
 Please do not erase the formatted
 comments, i.e. go to Editor->Show Rendered Markup
 in Xcode and leave rendering on while doing the homework.
 This will prevent you from inadvertantly changing things you should not change.
 
 You should make changes to this file **ONLY**
 in the places specified by the marked comments.
 Put your code and or comments ONLY in
 those places!
 As before, where the instructions specify a limit on the length of your
 answers, limit your answers to that length.
  
 ## Overall requirements:
 1. You must work all problems in both playgrounds: Assignment2a and Assignment2b.  Note that Assignment2a contains additional files which are referenced in the
 the problems.
 1. Your submitted playgrounds must have zero errors and zero warnings.  **Turning
 in a playground which does not successfully compile will result in zero points for
 all questions in that playground.**
 1. You MUST do the work yourself, do not talk together on this one,
 any questions should be addressed to the discussion boards so that
 everyone may see them and the instructors may determine if they are appropriate
 
 All the previous honor code rules from before still apply.  To wit:
 
 **DO NOT ANSWER QUESTIONS ON THIS HOMEWORK FOR OTHERS IN THE FORUMS**
 
 You may say something like: "this was discussed in class 4 at 45:16" or
 "this is in learn-swift 12", but no more than that.
 
 Violation of this rule will be treated as an honor violation.
 
 There are 20 problems, each problem counts 5 points.
 
### Problem 1
 
 In one word, explain which generic parameter of a Combine Publisher
 type you would expect to make use of the following type.
 */
// Failure
/*

*/
enum Assignment2Error: Error {
    case myError
}
/*:
 ### Problem 2
 
 In the extension immediately below, we add methods
 to the Supply type provided in the `FreeCombine.swift` file, in one
 sentence explain why we need two forms of map function on Supply
 */
// We need two forms of the map funcion on 'Supply' so we can map each generic parameter and there are two generic parameters in 'Supply'.
/*

*/
 
 extension Supply {
     static func map<T>(
         _ transform: @escaping (Value) -> T
     ) -> (Self) -> Supply<T, Failure> {
           { supply in
              switch supply {
              case .value(let value): return .value(transform(value))
              case .failure(let failure): return .failure(failure)
              case .finished: return .finished
              case .none: return .none
              }
          }
     }
/*:
 ### Problem 3
 Supply the appropriate cases in the `mapError` function below
 */
     static func mapError<T>(
         _ transform: @escaping (Failure) -> T
     ) -> (Self) -> Supply<Value, T> {
         { supply in
             switch supply {
            // ** Your Problem 3 answer goes here **
             case .value (let value): return .value(value)
             case .failure (let failure): return .failure(transform(failure))
             case .finished: return .finished
             default: return .none
            }
         }
     }
/*:
 ### Problem 4
 Supply the appropriate `.value` case in the `tryMap` function below
*/
    static func tryMap<T> (
        _ transform: @escaping (Value) throws -> T
    ) -> (Self) -> Supply<T, Error> {
        { supply in
            switch supply {
               // Hint you will need to include  `(let value)` here
               case .value(let value):
               // ** Your Problem 4 answer goes here **
               do {
                return .value(try transform(value))
               } catch {
                return .failure(Assignment2Error.myError)
                }
                
                
            case .failure(let failure): return .failure(failure)
            case .none: return .none
            case .finished: return .finished
            }
        }
    }
}

extension Demand{
    var unsatisfied: Bool {
        switch self {
        case .none: return false
        case .max(let val) where val > 0: return true
        case .max: return false
        case .unlimited: return true
        case .cancel: return false
        }
    }
}
/*:
 Problems 5 and 6 apply to the extension of Subscriber below
 
 ### Problem 5
  1. in one word, describe what technique is being used in the line:
 
 `case .value: return consume(nextSupply)`
 
 2. in one sentence explain why we do not call `consume` in the line:
 
 `case .failure, .finished: return subscriber(nextSupply)`
 
 */
// Composition
/*

 */
// We do not call consume since the Supply enum's case is failure/finished which means that there is no more demand the supply can consume.
/*
 
 */
extension Subscriber {
    static func satiateOrExhaust(
        from producer: Producer<Value, Failure>,
        into subscriber: Subscriber<Value, Failure>
    ) -> Subscriber<Value, Failure> {
        func consume(_ supply: Supply<Value, Failure>) -> Demand {
            let demand = subscriber(supply)
            guard demand.unsatisfied else { return demand }
            let nextSupply = producer(demand)
            switch nextSupply {
                case .none: return demand
                case .failure, .finished: return subscriber(nextSupply)
                case .value: return consume(nextSupply)
            }
        }
/*:
 ### Problem 6
 In the location shown return the appropriate Subscriber using the point-free style.
*/
        /// *Replace this line for Problem 6*
        return .init {_ in return .none }
    }
}

/*:
 ### Problem 7
 In one sentence explain why we need to call `curry` in the `join` function below
  */
 // We need to call curry in the join function below so that we can let the producer supply more supplies for a subscriber (? i'm unsure)
 /*

  */
/*:
 ### Problem 8
 In one word, state what we call a function of this type
 */
// Currying (? i'm unsure)
/*

 */
extension Subscriber {
    static func join(
        _ producer: Producer<Value, Failure>
    ) -> (Subscriber<Value, Failure>) -> Subscriber<Value, Failure> {
        curry(satiateOrExhaust)(producer)
    }
}

/*:
### Problem 9
 Provide return type of the inner init using the appropriate generic types
 in your answer.
 */
// ** Your Problem 9 answer goes here **
/*

 */
public extension Publisher {
    init(_ producer: Producer<Output, Failure>) {
        self = .init { subscriber in
            .init(subscriber.contraFlatMap(Subscriber.join(producer), producer).map(void))
        }
    }
}

public extension Producer where Failure == Never {
    /*:
    ### Problem 10
     In up to 4 potentially hyphenated words, state which of the
     pure function requirements
     (total, deterministic, no side-effects), if any, are NOT met
     by the `just` function.
     */
    // ** Your Problem 10 answer goes here **
    /*

     */
    static func just(_ value: Value) -> Producer<Value, Never> {
        var hasPublished = false
        return Producer { demand in
            guard !hasPublished else { return .finished }
            guard demand.unsatisfied else { return .none }
            hasPublished = true
            return .value(value)
        }
    }
    
    static func sequence<S: Sequence>(_ values: S) -> Producer<Value, Never>
        where S.Element == Value
    {
        var slice = ArraySlice(values)
        return .init { demand in
            switch demand {
            case .none:
                return .none
            case .cancel:
                slice = ArraySlice()
                return .finished
            case .max, .unlimited:
                guard let value = slice.first else { return .finished }
                slice = slice.dropFirst()
                return .value(value)
            }
        }
    }
}

/*:
### Problem 11
 In the extension of Sequence below, state what type of values
 will be published by `publisher`
 */
// ** Your Problem 11 answer goes here **
/*

 */
public extension Sequence {
    // PublishedSequence
    var publisher: Publisher<Self.Element, Never> {
        .init(Producer.sequence(self))
    }
}

/*:
### Problem 12
  In the static function below, state what type of values
  will be published by the returned publisher
*/
 // ** Your Problem 12 answer goes here **
 /*

  */
public func Just<T>(_ value: T) -> Publisher<T, Never> {
    .init(Producer.just(value))
}

public func PublishedSequence<S: Sequence>(_ values: S) -> Publisher<S.Element, Never> {
    values.publisher
}

public extension Publisher {
    func map<T>(
        _ transform: @escaping (Output) -> T
    ) -> Publisher<T, Failure> {

        let hoist = { (downstream: Subscriber<T, Failure>) -> Subscriber<Output, Failure> in
            .init(downstream.contraFlatMap(identity, Supply.map(transform)))
        }
        
        let lower = { (mySubscription: Subscription) -> Subscription in
            .init(mySubscription.contraFlatMap(identity, identity))
        }

        return .init(dimap(hoist, lower))
    }
}

/*:
### Problem 13
 Review the extension to publisher above. Uncomment the extension immediately
 below and, using the techniques discussed in class
 implement the tryMap function using the same pattern
 */
//public extension Publisher {
//    func tryMap<T>(
//        _ transform: @escaping (Output) throws -> T
//    ) -> Publisher<T, Error> {
/// * your problem 13 answer goes here *
//    }
//}

