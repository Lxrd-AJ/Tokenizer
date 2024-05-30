import XCTest
@testable import Tokenizer

final class TokenizerTests: XCTestCase {
    let text = "Ｕｎｉｃｏｄｅ! 🅤🅝🅘🅒🅞🅓🅔‽ 🇺‌🇳‌🇮‌🇨‌🇴‌🇩‌🇪! 😄 The very name strikes fear and awe into the hearts of programmers worldwide. We all know we ought to “support Unicode” in our software (whatever that means—like using wchar_t for all the strings, right?). But Unicode can be abstruse, and diving into the thousand-page Unicode Standard plus its dozens of supplementary annexes, reports, and notes can be more than a little intimidating. I don’t blame programmers for still finding the whole thing mysterious, even 30 years after Unicode’s inception."
    
    func testEncode() throws {
        let tokens = encode(text)
        let sep = String(repeating: "---", count: 10)
        print(sep)
        print(text)
        print("Length: \(text.count)") // Interestingly this is less than the count reported in https://colab.research.google.com/drive/1y0KnCFZvGVf_odSfcNAws6kcDD7HsI0L#scrollTo=-wm3T6JYOhvg&line=1&uniqifier=1
        print(sep)
        print(tokens)
        print("Length: \(tokens.count)")
    }
    
    // TODO: Verify sorting
    // https://dotnetperls.com/convert-int-character-swift
    func testPairCounting() throws {
        let tokens = encode(text)
        let pairStats = pairCounts(tokens: tokens, sorted: true)
        
        print(pairStats)
        
        let topPair = pairStats[0]
        print("\(topPair.key): \(topPair.key())")
        print(topPair.value)
        
        print(tokens)
    }
}
