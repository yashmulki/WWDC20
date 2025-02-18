//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//



import PlaygroundSupport
import Foundation

guard let remoteView = PlaygroundPage.current.liveView as? PlaygroundRemoteLiveViewProxy else {
    fatalError("Always-on live view not configured in this page's LiveView.swift.")
}

func attachToDNA() -> String {
    remoteView.send(.dictionary(["type": .string("Attach")]))
    return "Sent"
}

func configureTarget(target: String) {
    remoteView.send(.dictionary(["type": .string("Target"), "Target": .string(target.uppercased())]))
}

func configureTemplate(template: String) {
    remoteView.send(.dictionary(["type": .string("Template"), "Template": .string(template.uppercased())]))
}

//#-end-hidden-code

/*:
# Applying CRISPR
### Come up with something here
Now it's time to start using CRISPR!
 
The Swift bird has a problem; instead of it's normal orange/red gradient, it has mysteriously turned blue/purple. Fortunately, you just got your  Edit, a revolutionary new CRISPR system that lets you easily modify genes. Using the  Edit is simple – all you have to do is configure a "target" sequence, which is the sequence you are trying to cut out. Then, we can pass in a replacement sequence, and the DNA strand will use a process called Homology Directed Repair, which uses the provided replacement DNA to fill in the broken DNA strand with the new bases.
 
 The three base "codon" that codes for the bird's colour has two different configurations
 - ATG creates a blue/purple color, which is what the bird has right now
 - TGG creates an orange/red color, which is what the bird should have
 
*/

//: First,let's attach the CRISPR editor to our DNA strand
attachToDNA()

//: Second, let's configure the target DNA that we want to remove (ATG)
configureTarget(target: /*#-editable-code Sequence*/""/*#-end-editable-code*/)

//: Third, let's configure the template DNA that we want to replace the target with (TGG)
configureTemplate(template: /*#-editable-code Sequence*/""/*#-end-editable-code*/)

//: Now, we're ready to start editing. Run your code, then tap the play button on the top right of the editor screen

//#-hidden-code
var correctResults = ["Sequence*/\"ATG\"", "Sequence*/\"TGG\""]



// Validation stuff
public func findUserCodeInputs(from input: String) -> [String] {
    var inputs: [String] = []
    let scanner = Scanner(string: input)

    while scanner.scanUpTo("Sequence*/", into: nil) {
        var userInput: NSString? = ""
        scanner.scanUpTo("/*#-end-editable-code", into: &userInput)

        if userInput != nil {
            inputs.append(String(userInput!))
        }
    }

    return inputs
}


public enum AssessmentResults {
    case pass(message: String)
    case fail(hints: [String], solution: String?)
}


public func makeAssessment(of input: String) -> PlaygroundPage.AssessmentStatus {
    let codeInputs = findUserCodeInputs(from: input)

    // validate the input; return .fail if needed
    if codeInputs[0].uppercased() == correctResults[0].uppercased() && codeInputs[1].uppercased() == correctResults[1].uppercased() {
        return .pass(message: "Great job! Hit the play button in the top right!")
    }
    return .fail(hints: ["The following hints contain the solution to each editable code area", "ATG", "TGG"], solution: nil)
}

let input = PlaygroundPage.current.text
PlaygroundPage.current.assessmentStatus = makeAssessment(of: input)

//#-end-hidden-code
