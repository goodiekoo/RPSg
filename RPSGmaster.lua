function SetATK()
  print("가위,바위,보에 할당할 점수를 부여")
end

PlayerSet = {}
function PlayerSet:ATK(Rock, Paper, Scissor)
  local instance = setmetatable({},self)
  self.__index = self
  
  instance.Rock = Rock or 1
  instance.Paper = Paper or 1 
  instance.Scissor = Scissor or 1 
  
  return instance
end

SetATK()
print ("Hello, World!")
