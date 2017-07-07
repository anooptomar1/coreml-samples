//: Playground - noun: a place where people can play

import UIKit
import Foundation


/*
 Language Identification
 */

let detectTagger = NSLinguisticTagger(tagSchemes: [.language], options: 0)
detectTagger.string = "内啥，借个设备"
let zhCNLang = detectTagger.dominantLanguage // => zh-Hans

detectTagger.string = "Mr. Tim Cook presided over the earnings report of Apple. The stock was up 3% after hours."
let enLang = detectTagger.dominantLanguage // => en

/*
 Tokenization
 */

let tokenTagger = NSLinguisticTagger(tagSchemes: [.tokenType], options: 0)
let mixedText = "NSLinguisticTagger provides text processing APIs.\n NSLinguisticTagger 是苹果的文字处理平台。"
tokenTagger.string = mixedText
let tokenRange = NSRange(location: 0, length: mixedText.utf16.count)
// ignore: , . ignore whitespace
let tokenOptions: NSLinguisticTagger.Options = [NSLinguisticTagger.Options.omitPunctuation, .omitWhitespace]

var tokens = Array<String>()
tokenTagger.enumerateTags(in: tokenRange, unit: .word, scheme: .tokenType, options: tokenOptions) { (_, range, _) in
    let token = (mixedText as NSString).substring(with: range)
    tokens.append(token)
}
print(tokens) // => ["NSLinguisticTagger", "provides", "text", "processing", "APIs", "NSLinguisticTagger", "是", "苹果", "的", "文字", "处理", "平台"]
tokens


/*
 Lemmatization
 */

let lemTagger = NSLinguisticTagger(tagSchemes: [.lemma], options: 0)
let lemText = "Great hikes make great pics! Wonderful afternoon in Marin County."

lemTagger.string = lemText
let lemRange = NSRange(location: 0, length: lemText.utf16.count)
// ignore: , . ignore whitespace
let lemOptions: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace]

var lems = Array<String>()
lemTagger.enumerateTags(in: lemRange, unit: .word, scheme: .lemma, options: lemOptions) { (tag, _, _) in
    if let lemma = tag?.rawValue {
        lems.append(lemma)
    }
}

print(lems) // => ["great", "hike", "make", "great", "pic", "wonderful", "afternoon", "in", "Marin", "county"]
lems


/*
 Named Entity Recognition
 */
let namedTagger = NSLinguisticTagger(tagSchemes: [.nameType], options: 0)
let namedText = "Tim Cook is the CEO of Apple Inc. which is located in Cupertino, Californi. Jians are iOS developer in Xian of Thoughtworks."

namedTagger.string = namedText

let namedRange = NSRange(location: 0, length: namedText.utf16.count)
let namedOptions: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace, .joinNames]
let namedTags: [NSLinguisticTag] = [.personalName, .placeName, .organizationName]

var names = Array<String>()
namedTagger.enumerateTags(in: namedRange, unit: .word, scheme: .nameType, options: namedOptions) { (tag, tokenRange, _) in
    if let tag = tag, namedTags.contains(tag) {
        let name = (namedText as NSString).substring(with: tokenRange)
        names.append(name)
    }
}

print(names) // => ["Tim Cook", "Apple Inc.", "Cupertino", "Californi", "Xian", "Thoughtworks"]
names









