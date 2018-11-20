//
//  main.swift
//  measureTimeArrayVCSet
//
//  Created by Mac on 11/20/18.
//  Copyright © 2018 CO.KrystynaKruchcovska. All rights reserved.
//

import Foundation


func randomAlphaNumericString(length: Int) -> String {
    let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let allowedCharsCount = UInt32(allowedChars.characters.count)
    var randomString = ""
    
    for _ in 0..<length {
        let randomNum = Int(arc4random_uniform(allowedCharsCount))
        let randomIndex = allowedChars.index(allowedChars.startIndex, offsetBy: randomNum)
        let newCharacter = allowedChars[randomIndex]
        randomString += String(newCharacter)
    }
    
    return randomString
}

func evaluateProblem(block: @escaping()->()) -> Int
{
    
    let start = DispatchTime.now() // <<<<<<<<<< Start time
    block()
    let end = DispatchTime.now()   // <<<<<<<<<<   end time
    
    
     let time = end.uptimeNanoseconds - start.uptimeNanoseconds // <<<<< Difference in nano seconds (UInt64)
    
    return Int(time)
}


var namesArray = [String] ()
var namesSet = Set<String>()


for _ in 0...5000 {
    let randomname = randomAlphaNumericString(length: 15)
    namesArray.append(randomname)
    namesSet.insert(randomname)
}

print("Set size is:\(namesSet.count)")
print("Array size is:\(namesArray.count)")


var setAvgTime = 0
var arrayAvgTime = 0

for _ in 0...1000 {
    
    let nameIndex = Int(arc4random_uniform(5000))
    let chosenName = namesArray[nameIndex]
    

    arrayAvgTime += evaluateProblem {
        _ = namesArray.contains(chosenName)
    }

    setAvgTime += evaluateProblem {
        _ = namesSet.contains(chosenName)
        
    }

}

print("array avg is:\(arrayAvgTime/1000)")
print("set avg is:\(setAvgTime/1000)")


