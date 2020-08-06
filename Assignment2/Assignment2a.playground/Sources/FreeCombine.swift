public enum Demand {
    case none
    case max(Int)
    case unlimited
    case cancel
}

public enum Supply<Value, Failure: Error> {
    case none
    case value(Value)
    case failure(Failure)
    case finished
}

public struct Producer<Value, Failure: Error> {
    public let call: (Demand) -> Supply<Value, Failure>
    public init(_ call: @escaping (Demand) -> Supply<Value, Failure>) {
        self.call = call
    }
}

extension Producer: CallableAsFunction {
    public typealias A = Demand
    public typealias B = Supply<Value, Failure>
    public init<C>(_ c: C) where C : CallableAsFunction, Self.A == C.A, Self.B == C.B {
        self.call = c.call
    }
}

public struct Subscriber<Value, Failure: Error> {
    public let call: (Supply<Value, Failure>) -> Demand
    public init(_ call: @escaping (Supply<Value, Failure>) -> Demand) {
        self.call = call
    }
}

extension Subscriber: CallableAsFunction {
    public typealias A = Supply<Value, Failure>
    public typealias B = Demand
    public init(_ f: Func<Supply<Value, Failure>, Demand>) {
        self.call = f.call
    }
    public init<C>(_ c: C) where C : CallableAsFunction, Self.A == C.A, Self.B == C.B {
        self.call = c.call
    }
}

public struct Subscription {
    public let call: (Demand) -> Void
    
    public init(_ call: @escaping (Demand) -> Void) {
        self.call = call
    }
}

extension Subscription: CallableAsFunction {
    public typealias A = Demand
    public typealias B = Void
    public init(_ f: Func<Demand, Void>) {
        self.call = f.call
    }
    public init<C>(_ c: C) where C : CallableAsFunction, Self.A == C.A, Self.B == C.B {
        self.call = c.call
    }
}

public struct Publisher<Output, Failure: Error> {
    public let call: (Subscriber<Output, Failure>) -> Subscription
    
    public init(
        _ call: @escaping (Subscriber<Output, Failure>) -> Subscription
    ) {
        self.call = call
    }
}

extension Publisher: CallableAsFunction {
    public typealias A = Subscriber<Output, Failure>
    public typealias B = Subscription
        public init(_ f: Func<A, B>) {
        self.call = f.call
    }
    public init<C>(_ c: C) where C : CallableAsFunction, Self.A == C.A, Self.B == C.B {
        self.call = c.call
    }
}
