//
//  NumberBaseball - main.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 


//게임시작시 사용자 입력 받기 메서드
func chooseOption() -> Int {
    print(
        """
        1. 게임시작
        2. 게임종료
        """)
    print("원하는 기능을 선택해주세요 : ", terminator: "")
    
    //Unwrapping 및 숫자 아닐때 다시 입력받기
    guard let input = readLine(), let numInput = Int(input) else {
        print("입력이 잘못되었습니다")
        return chooseOption()
    }
    
    //정상입력 return, 잘못된입력 다시 입력받기
    if numInput == 1 || numInput == 2 {
        return numInput
    } else {
        print("입력이 잘못되었습니다")
        return chooseOption()
    }
}


//게임 숫자 입력 메서드
func inputUserNumbers() -> [Int] {
    print(
        """
        숫자 3개를 띄어쓰기로 구분하여 입력해주세요.
        중복 숫자는 허용하지 않습니다.
        """)
    print("입력 : ", terminator: "")
    
    //Unwrapping input
    guard let input = readLine() else {
        print("입력이 잘못되었습니다")
        return inputUserNumbers()
    }
    
    //입력값 정리 후 조건 확인
    //띄어쓰기 기준으로 입력값 분리 후 Int로 형변환
    var revisedNums = input.split(separator: " ").compactMap{Int($0)}
    // 1...9 외의 값이 남아있으면 전부 제거됨
    revisedNums.removeAll { value in
        return (value > 9) || (value < 1)
    }
    if Set(revisedNums).count != 3 {
        print("입력이 잘못되었습니다")
        return inputUserNumbers()
    }
    
    return revisedNums
}


//랜덤 숫자 생성 메서드
func generateNumbers() -> [Int] {
    var randomNumbers = [Int]()
    
    //중복제거 후 count 3 될때까지 반복
    while randomNumbers.count < 3 {
        let value = Int.random(in: 1...9)
        randomNumbers.append(value)
        //새로추가된 내용이 중복이라면 바로 다시 지워질 것
        randomNumbers = Array(Set(randomNumbers))
    }
    
    return randomNumbers
}


//정답 비교 메서드
func answerJudge(answer: [Int], query: [Int]) -> Bool {
    var ball = 0
    var strike = 0
    
    //ball과 strike 개수 카운트
    for (index, value) in answer.enumerated() {
        strike += (value == query[index]) ? 1 : 0
        ball += (query.contains(value)) ? 1 : 0
    }
    ball -= strike
    print("\(strike) 스트라이크, \(ball) 볼")
    
    
    //strike가 3이면 사용자 승리 및 게임 다시시작
    //true 반환 : 사용자승리, false 반환 : default
    if strike == 3 {
        print("사용자 승리!")
        return true
    } else {
        return false
    }
}


//게임 시작 메서드
func startGame() -> Bool {
    
    //2를 선택할 경우 게임종료
    if chooseOption() == 2 {
        return false
    }
    
    //정답 및 count 생성
    let answer = generateNumbers()
    var count = 9
    
    //게임 9회 반복
    while count > 0 {
        count -= 1
        if answerJudge(answer: answer, query: inputUserNumbers()) { return true }
        print("남은 기회 : \(count)")
    }
    
    //컴퓨터 승리 판별
    print("컴퓨터 승리...!")
    return true
}



//게임시작
var isGoingOn = true

while isGoingOn {
    isGoingOn = startGame()
}
