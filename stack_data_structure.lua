-- Stack data structure to ehance my understanding of OOP (object-oriented programming)
-- A stack is just a data structure that follows the last in first out principal which means what it says lmao 
-- A stack is LITERALLY a stack, you can stack values on top of eachother and yeah 
local Stack = {} -- Creates a class called "Stack" which is essentially just a blueprint for creating objects
Stack.__index = Stack  -- Setting the index metamethod of stack to itself, so that objects created under the stack class inherit properties of it 

-- Creating a constructor that creates a new stack object
-- A constructor is essentially just a special function that allows us to create objects
function Stack:new(maxSize) 
    local newStack = setmetatable({}, self) 
    newStack.maxSize = maxSize 
    newStack.currentSize = 0 
    return newStack 
end 

function Stack:push(value)
    if self.currentSize >= self.maxSize then return error("Stack is full!") end 

    self.currentSize = self.currentSize + 1 
    table.insert(self, value)
end 

function Stack:pop()
    if self.currentSize == 0 then return error("Stack is empty!") end 
    self.currentSize = self.currentSize - 1 
    self[self.currentSize + 1] = nil 
end 

function Stack:view()
    -- this function essentially just allows us to view items in the stack
    for i, v in next, self do 
        if i ~= "currentSize" and i ~= "maxSize" then 
            print(i, v)
        end 
    end 
end 

local newStack = Stack:new(10)
for i = 1, 10 do 
    newStack:push(i * 10)
end 

newStack:pop()
newStack:view()
