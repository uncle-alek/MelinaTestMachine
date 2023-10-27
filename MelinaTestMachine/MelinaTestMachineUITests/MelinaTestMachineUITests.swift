//
//  MelinaTestMachineUITests.swift
//  MelinaTestMachineUITests
//
//  Created by Aleksey Yakimenko on 27/10/23.
//

import XCTest

open class MelinaTestMachineUITests: XCTestCase {

    var commands: [Command] = []
    var application: XCUIApplication!
    var element: XCUIElement!
    var condition: Bool!
    var text: String!

    open override func setUpWithError() throws {

        continueAfterFailure = false
        application = XCUIApplication()
        condition = false

        let path = "/Users/FirstTestSuite.tecode.json"

        do {
            let content = try String(contentsOfFile: path, encoding: .utf8)
            if let jsonData = content.data(using: .utf8) {
                let decoder = JSONDecoder()
                commands = try decoder.decode([Command].self, from: jsonData)
            } else {
                print("File is empty")
            }
        } catch {
            print("Error: \(error)")
        }
    }

    func test() throws {
        var index = 0
        while index < commands.count {
            let currentCommand = commands[index]
            switch currentCommand.mnemonic {
            case .scenarioBegin:
                print("scenario begin with arg: \(currentCommand.operands[0])")
            case .scenarioEnd:
                print("scenario end with arg: \(currentCommand.operands[0])")
            case .suiteBegin:
                print("suite begin with arg: \(currentCommand.operands[0])")
            case .suiteEnd:
                print("suite end with arg: \(currentCommand.operands[0])")
            case .button:
                element = application.buttons[currentCommand.operands[0]]
            case .view:
                element = application.otherElements[currentCommand.operands[0]]
            case .tap:
                element.tap()
            case .print:
                print(currentCommand.operands[0])
            case .textField:
                element = application.textFields[currentCommand.operands[0]]
            case .scrollView:
                element = application.scrollViews[currentCommand.operands[0]]
            case .typeText:
                element.typeText(currentCommand.operands[0])
            case .swipeUp:
                element.swipeUp()
            case .swipeDown:
                element.swipeDown()
            case .swipeLeft:
                element.swipeLeft()
            case .swipeRight:
                element.swipeRight()
            case .isHittable:
                condition = element.isHittable
            case .exists:
                condition = element.exists
            case .jumpIfTrue:
                if condition {
                    index += Int(currentCommand.operands[0])!
                }
            case .jump:
                index += Int(currentCommand.operands[0])!
            case .assertBool:
                 XCTAssertEqual(condition, Bool(currentCommand.operands[0])!)
            case .assertString:
                 XCTAssertEqual(text, currentCommand.operands[0])
            case .label:
                text = element.label
            case .waitForExistence:
                condition = element.waitForExistence(timeout: TimeInterval(currentCommand.operands[0])!)
            case .application:
                application = XCUIApplication()
            case .launch:
                application.launch()
            case .terminate:
                application.terminate()
            case .launchEnvironment:
                application.launchEnvironment[currentCommand.operands[0]] = currentCommand.operands[1]
            case .launchArgument:
                application.launchArguments.append(currentCommand.operands[0])
            case .isSelected:
                condition = element.isSelected
            case .staticText:
                element = application.staticTexts[currentCommand.operands[0]]
            }
            index += 1
        }
    }
}

struct Command: Codable {
    let mnemonic: Mnemonic
    let operands: [String]
}

extension Command {

    enum Mnemonic: String, Codable {
        case suiteBegin = "suiteBegin"
        case suiteEnd = "suiteEnd"
        case scenarioBegin = "scenarioBegin"
        case scenarioEnd = "scenarioEnd"

        case button = "button"
        case textField = "textField"
        case scrollView = "scrollView"
        case view = "view"
        case tap = "tap"
        case typeText = "typeText"
        case print = "print"
        case swipeUp = "swipeUp"
        case swipeDown = "swipeDown"
        case swipeLeft = "swipeLeft"
        case swipeRight = "swipeRight"
        case isHittable = "isHittable"
        case exists = "exists"
        case jumpIfTrue = "jumpIfTrue"
        case jump = "jump"
        case label = "label"
        case assertBool = "assertBool"
        case assertString = "assertString"
        case waitForExistence = "waitForExistence"
        case application = "application"
        case launch = "launch"
        case terminate = "terminate"
        case launchEnvironment = "launchEnvironment"
        case launchArgument = "launchArgument"
        case isSelected = "isSelected"
        case staticText = "staticText"
    }
}
