//
//  NumberBaseball - main.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 


// 필요한 역할
/*
 사용자에게 첫 메뉴 출력하기
 사용자에게 첫 메뉴에 대한 입력값 받기
 첫 메뉴 입력값 유효성 검증
 컴퓨터의 대답 만들기
 
 사용자의 대답의 유효성 평가
 유효한 사용자 대답을 컴퓨터 대답과 비교하기
 사용자 대답과 컴퓨터 대답을 비교한 결과를 출력문에 반영하기
 볼과 스트라이크 개수가 반영되어야함
 남은기회가 반영되어야 함
 -> 정답을 맞춘 경우 다시 맨 위로 돌아가기
 
 */


import Foundation

func getUserInput() -> String?{
    let userInput = readLine()
    return userInput
}

func showFirstMenu() {
    let optionList = """
        1. 게임시작
        2. 게임종료
        원하는 기능을 선택해 주세요 :\(" ")
        """
    print(optionList, terminator: "")
}

func isGameContinue(user choice: String?) -> Bool{
    if let menuNumber = choice, menuNumber == "1" {
        return true
    }
    return false
}

func generateComputerAnswer() -> Int {
    return Int.random(in: 1...9)
}

func showGameMenu(){
    let printedRule = """
        숫자 3개로 띄어쓰기를 구분하여 입력해주세요.
        중복 숫자는 허용하지 않습니다.
        입력 :\(" ")
        """
    print(printedRule, terminator: "")
}

func endGame() {
    return
}

func isUserGuessVerified(user input: String?) -> Bool{
    let result = input?.split(separator: " ").map { $0 }.filter { type(of: $0) == Int.self }
    if result?.count != 3 {
        return false
    }
    
    return true
}

func getCheckedUserGuess() -> String? {
    var userGuess = getUserInput()
    var flag = isUserGuessVerified(user: userGuess)
    while flag != true {
        userGuess = getUserInput()
        flag = isUserGuessVerified(user: userGuess)
    }
    return userGuess
}

func checkBallAndStrike(to answer: String, with userGuess: String?) -> (Int, Int){
    var index = 0
    var ballNumber = 0
    var strikeNumber = 0
    
    guard let guess = userGuess else { return }
    for i in 0...2 {
        answer.filter { $0[i] == guess[i] }
    }
    
    return (strikeNumber, ballNumber)
}

func showStrikeAndBallCount(strikeNumber: Int, ballNumber: Int) {
    print("\(strikeNumber) 스트라이크, \(ballNumber) 볼", terminator: "")
}
func showLeftChance(number: Int) {
    print("남은 기회: \(number)")
}

// 유효한 사용자 대답을 컴퓨터 대답과 비교하기
//사용자 대답과 컴퓨터 대답을 비교한 결과를 출력문에 반영하기
//   볼과 스트라이크 개수가 반영되어야함
//   남은기회가 반영되어야 함

func gameStart() {
    showFirstMenu()
    let userIntension = getUserInput()
    if isGameContinue(user: userIntension) != true{
        endGame()
    }
    let answer = generateComputerAnswer()
    
    showGameMenu()
    let userGuess = getCheckedUserGuess()
    // 비교
    
    
    // 프린트
    
    // 결과
    
}

gameStart()
/*
 func selectOption() -> String? {
 let optionList = """
 1. 게임시작
 2. 게임종료
 원하는 기능을 선택해 주세요 :\(" ")
 """
 
 print(optionList, terminator: "")
 
 let selectedNum = readLine()
 
 return selectedNum
 }
 
 
 
 let ruleLiteral = """
 숫자 3개로 띄어쓰기를 구분하여 입력해주세요.
 중복 숫자는 허용하지 않습니다.
 입력 :\(" ")
 """
 
 func endGame() {
 return;
 }
 
 
 
 func generateAnswer() -> [Int] {
 
 var answer = Set<Int>()
 
 while answer.count < 3 {
 
 let randomNumber = Int.random(in: 1...9)
 answer.insert(randomNumber)
 
 }
 
 let answers = Array(answer)
 
 return answers
 }
 
 
 func filterUserInput(num : String?) -> [Int] {
 
 if let userNums = num {
 var userNumSet = userNums.split(separator: " ").compactMap { Int($0) }
 userNumSet.removeAll(where: {$0 < 1 || $0 > 9})
 
 switch userNumSet.count {
 case 3:
 return userNumSet
 default:
 print("입력이 잘못되었습니다.")
 print(ruleLiteral, terminator: "")
 return filterUserInput(num: readLine())
 }
 }
 
 return [0]
 }
 
 
 
 func judgeAnswer(answer: [Int], number: [Int]) -> String {
 var strike = 0
 var ball = 0
 let numRange = 0...2
 
 for index in numRange {
 if number[index] == answer[index] {
 strike += 1
 } else if number.contains(answer[index]) {
 ball += 1
 }
 }
 
 if strike == 3 {
 return "사용자 승리...!"
 }
 
 return "\(strike) 스트라이크, \(ball) 볼"
 }
 
 
 func startGame() {
 
 let comanswer = generateAnswer()
 
 let totalChance = 9
 
 for i in 1...totalChance {
 let userInput = readLine()
 let userNum = filterUserInput(num: userInput)
 let judgeAnswer = judgeAnswer(answer: comanswer, number: userNum)
 print(judgeAnswer)
 
 switch judgeAnswer {
 case "사용자 승리...!":
 selectOption()
 
 default:
 print("남은 기회 : \(totalChance - i)")
 }
 }
 1
 print("컴퓨터의 승리...!")
 
 selectOption()
 }
 
 
 func writeNumber(option num: String?) {
 switch num {
 case "1" :
 print(ruleLiteral, terminator: "")
 startGame()
 
 case "2" :
 endGame()
 
 default :
 print("입력이 잘못되었습니다.")
 writeNumber(option: selectOption())
 }
 }
 
 
 let userScreen = selectOption()
 let numBaseball = writeNumber(option: userScreen)
 
 print(numBaseball)
 
 */
