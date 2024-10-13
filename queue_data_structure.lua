-- kinda had a hard time trying to understand the logic of this data structure but i'm glad to say it all makes sense 
local Queue = {} -- creating the queue class which is a blueprint for creating objects
Queue.__index = Queue -- sets the queue index metamethod to itself so that objects of this class can inherit the classes properties and methods

-- our constructor which essentially just creates a new object with an items property and a max size property 
function Queue:new(maxSize) 
    local obj = setmetatable({items = {}, maxSize = maxSize}, self) -- setting the object's metamethod to the class
    return obj 
end 

function Queue:isEmpty()
    return #self.items == 0
end 
-- enqueue method of the object essentially adds an item to the BACK of the list/queue
function Queue:enqueue(item) 
    if self:isFull() then return end 
    self.items[#self.items + 1] = item
end 
-- dequeue method basically removes the first item in the list and then shifts all items before the item removed to the left
function Queue:dequeue()
    if self:isEmpty() then return end 
    self.items[1] = nil 
    for i = 1, #self.items - 1 do 
        self.items[i] = self.items[i + 1]
    end 
    self.items[#self.items] = nil
end 
-- not needed in a queue data structure but i wanted to view it :D
function Queue:view()
    for i, v in next, self.items do 
        print(i, v)
    end 
end 
-- does what it says returns true/false depending on whether the queue is full
function Queue:isFull()
    return #self.items == self.maxSize
end  

local q = Queue:new(10) -- creating our object
for i = 1, 10 do 
    q:enqueue(i * 10) -- adding items to the queue
end 
q:view() -- viewing it 
print("----------------------------")
q:dequeue() -- removing 2 items cz why not
q:dequeue()
q:view() -- viewing it after aswell!1!

