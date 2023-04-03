// This program reads information from file, 
// it then assigns a student's assignment
// a specific grade.

//
//  Created by Sarah Andrew

//  Created on 2023-03-22.

//  Version 1.0

//  Copyright (c) 2023 Sarah. All rights reserved.
import Foundation

// This function generates a random number using standard deviation.
func randomNormalValue(mean: Double, standardDeviation: Double) -> Int {
    let variable1 = Double.random(in: 0...1)
    let variable2 = Double.random(in: 0...1)
    let multiplier = sqrt(-2 * log(variable1)) * cos(2 * .pi * variable2)
    return Int(multiplier * standardDeviation + mean)
}

// This function generates a random mark and assigns it to a specific user.
func genMarks(studArray: [String], assignArray: [String]) -> [[String]] {
    // Declare 2D arrays of strings.
    var array2DMarks = [[String]](repeating: [String](repeating: "", count: assignArray.count + 1), count: studArray.count + 1)
    // Assign name at index 0,0.
    array2DMarks[0][0] = "Name"

    // Initialize counter.
    var counter = 1

    // Usage of loop to copy each element into the 2D array.
    for assignName in assignArray {
        array2DMarks[0][counter] = assignName
        counter += 1
    }

    // Usage of loop to copy each element into the 2D array.
    var counter2 = 1
    for student in studArray {
        array2DMarks[counter2][0] = student
        counter2 += 1
    }

    // Populate cell of marks into the 2D array.
    for counter3 in 1...studArray.count {
        for counter4 in 1...assignArray.count {
            // Generate random marks using standard dev.
            var aNum: Int
            repeat {
                aNum = randomNormalValue(mean: 75, standardDeviation: 10)
            } while aNum < 0 || aNum > 100
            array2DMarks[counter3][counter4] = String(aNum)
        }
    }

    // Return results back to main.
    return array2DMarks
}

// Define input & output paths.
let studentFile = "students.txt"
let assignmentFile = "assignments.txt"
let outputFile = "marks.csv"

do {
    // Read in student names from students.txt
    let studentData = try String(contentsOfFile: studentFile, encoding: .utf8)
    let studentArray = studentData.components(separatedBy: .newlines)

    // Read in assignment names from assignments.txt
    let assignmentData = try String(contentsOfFile: assignmentFile, encoding: .utf8)
    let assignmentArray = assignmentData.components(separatedBy: .newlines)

    // Open the output file for writing.
    let outputFileURL = URL(fileURLWithPath: outputFile)
    let outputString: String

    // Call the function for generating marks.
    let marksArray = genMarks(studArray: studentArray, assignArray: assignmentArray)

    // Join each element in row with commas, and separate each row with newlines.
    outputString = marksArray.map { $0.joined(separator: ", ") }.joined(separator: "\n")

    // Print results.
    print(outputString)

    // Write results to output file.
    try outputString.write(to: outputFileURL, atomically: true, encoding: .utf8)

}
