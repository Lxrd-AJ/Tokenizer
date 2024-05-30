import Foundation

struct Token: Hashable, CustomStringConvertible {
    let value: UInt
    var description: String {
        return "\(value)"
    }
}

struct TokenPair: Hashable, CustomStringConvertible {
    let first: Token
    let second: Token
    var description: String {
        return "(\(first),\(second))"
    }
    
    init(first: Token, second: Token) {
        self.first = first
        self.second = second
    }
    
    init(_ tuple: (Token, Token)) {
        self.first = tuple.0
        self.second = tuple.1
    }
    
    func callAsFunction() -> String {
        if first.value <= 255 && second.value <= 255 {
            return "\(UnicodeScalar(UInt8(first.value)))\(UnicodeScalar(UInt8(second.value)))"
        }else{
            // This is a merged or compressed token pair - print as is
            return self.description
        }
    }
}

func encode(_ str: String) -> [Token] {
    return str.utf8.map({ Token(value: UInt($0)) })
}

func pairCounts(tokens: [Token], sorted: Bool = false) -> [Dictionary<TokenPair, Int>.Element] {
    var stats: [TokenPair: Int] = [:]
    
    for pair in zip(tokens, tokens[1...]) {
        let key = TokenPair(pair)
        stats[key, default: 0] += 1
    }
    
    if sorted {
        let sortedStats = stats.sorted(by: {(p1,p2) -> Bool in
            return p1.value > p2.value
        })
        return sortedStats
    }else{
        return stats.map({ p in p })
    }
}
