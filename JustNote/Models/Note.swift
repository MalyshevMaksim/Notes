//
//  Note.swift
//  JustNote
//
//  Created by Максим on 19.06.2020.
//  Copyright © 2020 Максим. All rights reserved.
//

import Foundation

var notes = [
    Note(title: "How programming on Swift?", text: "Let me explain something about me, I’m IOS Developer about 4 years. When i try to build my first app i use storyboards, xib after that I convert my self into create everything programmatically. I’m not say this is the best way or only way but i prefer to continue like this. When i create something programmatically I feel like free as possible as be. So this is my first Medium story and sorry if I do something wrong.", date: "19 июня 2020", tags: [.favorite, .protected]),
    Note(title: "Protocol-Oriented Programming", text: "At the heart of Swift's design are two incredibly powerful ideas: protocol-oriented programming and first class value semantics. Each of these concepts benefit predictability, performance, and productivity, but together they can change the way we think about programming. ... So, yes, Swift is great for object-oriented programming, but from the way for loops and string literals work to the emphasis in the standard library on generics, at its heart, Swift is protocol-oriented", date: "19 июня 2020", tags: [.favorite]),
    Note(title: "Hacking with Swift!", text: "Table views show separators between empty rows by default, which looks quite strange when you have only a handful of visible rows. Fortunately, one simple line of code is all it takes to force iOS not to draw these separators, and it's this:", date: "19 июня 2020", tags: [.protected]),
    
    Note(title: "WWDC 2020 – Apple", text: "After 15 years of Intel processors, Apple is expected to announce its transition to its own ARM chips at WWDC 2020.", date: "20 июня 2020", tags: [.protected]),
    
    Note(title: "Protocol-Oriented Programming", text: "At the heart of Swift's design are two incredibly powerful ideas: protocol-oriented programming and first class value semantics. Each of these concepts benefit predictability, performance, and productivity, but together they can change the way we think about programming. ... So, yes, Swift is great for object-oriented programming, but from the way for loops and string literals work to the emphasis in the standard library on generics, at its heart, Swift is protocol-oriented", date: "20 июня 2020", tags: [.protected]),
    Note(title: "Hacking with Swift!", text: "Table views show separators between empty rows by default, which looks quite strange when you have only a handful of visible rows. Fortunately, one simple line of code is all it takes to force iOS not to draw these separators, and it's this:", date: "19 июня 2020", tags: [.protected]),
    Note(title: "WWDC 2020 – Apple", text: "After 15 years of Intel processors, Apple is expected to announce its transition to its own ARM chips at WWDC 2020.", date: "20 июня 2020", tags: [.protected]),
    Note(title: "Protocol-Oriented Programming", text: "At the heart of Swift's design are two incredibly powerful ideas: protocol-oriented programming and first class value semantics. Each of these concepts benefit predictability, performance, and productivity, but together they can change the way we think about programming. ... So, yes, Swift is great for object-oriented programming, but from the way for loops and string literals work to the emphasis in the standard library on generics, at its heart, Swift is protocol-oriented", date: "20 июня 2020", tags: [.protected])
]

struct Note {
    var title: String
    var text: String
    var date: String
    var tags: [type]
}
