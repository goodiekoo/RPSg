-- 플레이어 클래스 생성
Player = {}
Player.__index = Player

function Player:new()
    local player = 
    {
        rockATK = 0,
        paperATK = 0,
        scissorsATK = 0,
        allATKs = 15,
        is1por2p = true,
        choice = ""
        -- 2개 이상 조합 키 따로 넣을 자리 (회피, 강/약공격 등)
        -- 아마도 이건 버튼 누른 순서 우선순위 따로 해야해서 q로 처리할 듯
        -- 버튼 입력은 낙장불입 시스템
    }
    setmetatable(player, Player)
    return player
end

function Player:setATK(rock, paper, scissors)
    if rock + paper + scissors <= self.allATKs and rock >= 1 and paper >= 1 and scissors >= 1 then
        self.rockATK = rock
        self.paperATK = paper
        self.scissorsATK = scissors
    else
        error("Invalid ATK values. Each ATK must be at least 1 and the total must not exceed 15.")
    end
end

function Player:keyMap(is1por2p)
    if is1por2p == true then
        return {q = "scissors", w = "rock", e = "paper"}
    else
        return {u = "scissors", i = "rock", o = "paper"}
    end
end
function Player:makeChoice(is1por2p, choice)
    local keyMap = self:keyMap(is1por2p)
    local mappedChoice = keyMap[choice]
    if mappedChoice then
        self.choice = mappedChoice
    else
        if is1por2p then
            error("P1 잘못된 입력. Q:가위, W:바위, E:보 중 하나를 입력하세요.")
        else
            error("P2 잘못된 입력. U:가위, I:바위, O:보 중 하나를 입력하세요.")
        end
    end
end

-- 게임 클래스 생성
Game = {}
Game.__index = Game

function Game:new()
    local game = {
        player1 = Player:new(),
        player2 = Player:new(),
        rounds = 3,
        currentRound = 1
    }
    setmetatable(game, Game)
    return game
end

function Game:sleep(n)
    local t = os.clock()
    while os.clock() - t <= n do
    end
end

function Game:start()
    print("격투 가위-바위-보!")
    self:setPlayerATKs()
    while self.currentRound <= self.rounds do
        print("라운드: " .. self.currentRound)
        self:playRound()
        self.currentRound = self.currentRound + 1
    end
    self:determineWinner()
end

function Game:setPlayerATKs()
    local pATKs = self.player1.allATKs
    local p1Sum = 0
    local p2Sum = 0
    print("1P, 공격력 설정 (가위, 바위, 보):")
    local p1Scissors = tonumber(io.read())
    p1Sum = pATKs - ( p1Sum + p1Scissors )
    print("1P 가위 공격력: " .. p1Scissors .." / 남은 공격력: " .. p1Sum.."\n")
    local p1Rock = tonumber(io.read())
    p1Sum = p1Sum - p1Rock
    print("1P 바위 공격력: " .. p1Rock .. "/ 남은 공격력: " .. p1Sum.."\n")
    local p1Paper = tonumber(io.read())
    p1Sum = p1Sum - p1Paper
    print("1P 보 공격력: " .. p1Paper .. "/ 남은 공격력: " .. p1Sum.."\n")

    self.player1:setATK(p1Rock, p1Paper, p1Scissors)

    print("2P, 공격력 설정 (가위, 바위, 보):")
    local p2Scissors = tonumber(io.read())
    p2Sum = pATKs - ( p2Sum + p2Scissors )
    print("2P 가위 공격력: " .. p2Scissors .." / 남은 공격력: " .. p2Sum.."\n")
    local p2Rock = tonumber(io.read())
    p2Sum = p2Sum - p2Rock
    print("2P 바위 공격력: " .. p2Rock .. "/ 남은 공격력: " .. p2Sum.."\n")
    local p2Paper = tonumber(io.read())
    p2Sum = p2Sum - p2Paper
    print("2P 보 공격력: " .. p2Paper .. "/ 남은 공격력: " .. p2Sum.."\n")

    self.player2:setATK(p2Rock, p2Paper, p2Scissors)

    print("공격력 설정 완료. 30초 후 게임 시작...")
    self.sleep(30)
end

function Game:playRound()
    local p1check = self.player1.is1por2p
    local p2check = self.player2.is1por2p
    print("P1, 공격 선택 (Q:가위, W:바위, E:보):")
    local p1Choice = io.read()
    self.player1:makeChoice(p1check, p1Choice)

    print("P2, 공격 선택 (U:가위, I:바위, O:보):")
    local p2Choice = io.read()
    p2check = false
    self.player2:makeChoice(p2check, p2Choice)

    self:calculateRoundResult()
end

function Game:calculateRoundResult()
    local p1Choice = self.player1.choice
    local p2Choice = self.player2.choice

    if p1Choice == p2Choice then
        print("It's a tie!")
    elseif (p1Choice == "rock" and p2Choice == "scissors") or
           (p1Choice == "paper" and p2Choice == "rock") or
           (p1Choice == "scissors" and p2Choice == "paper") then
        print("P1 wins this round!")
    else
        print("P2 wins this round!")
    end
end

function Game:determineWinner()
    -- Placeholder for determining the overall winner
    print("Game over! Determining the winner...")
end

-- Example usage
local game = Game:new()
game:start()