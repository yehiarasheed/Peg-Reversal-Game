type Position = (Int,Int)
data Color = W | B deriving (Eq, Show)
data Peg = Peg Position Color deriving (Eq, Show)
data Move = M Position deriving (Eq, Show)
type Board = [Peg]
data State = S Move Board deriving (Eq, Show)

allPositions :: [Position]
allPositions = [(-3,-1),(-3,0),(-3,1),(-2,-1),(-2,0),(-2,1),(-1,-3),(-1,-2),(-1,-1),(-1,0),(-1,1),(-1,2),(-1,3),(0,-3),(0,-2),(0,-1),(0,0),(0,1),(0,2),(0,3),(1,-3),(1,-2),(1,-1),(1,0),(1,1),(1,2),(1,3),(2,-1),(2,0),(2,1),(3,-1),(3,0),(3,1)]
--a)
createBoard:: Position -> Board
createBoard position  
   | elem position allPositions == False = error " The position is not valid." 
   | otherwise = create' position allPositions

create' :: Position -> [Position] -> Board
create' _ [] = []
create' position (h:t) = Peg h (if h == position then W else B) : create' position t



--b)look at the pegs in the 4 directions around it (up, down, left, right)
isValidMove :: Move -> Board -> Bool
isValidMove (M (a,b)) [] = False -- Empty board, move is invalid
isValidMove (M (a,b)) (Peg (x,y) c : t)
    | elem (a, b) allPositions == False = False -- check law Move is outside the board 
	| ( elem (Peg (a,b) B ) (Peg (x,y) c : t) ) && ( adjacentWhite (M (a,b)) (Peg (x,y) c : t) ) = True-- Valid move if adjacent white peg
    | otherwise = False

	
adjacentWhite :: Move -> Board -> Bool
adjacentWhite (M (a,b)) []= False
adjacentWhite (M (a,b)) ((Peg (x,y) W) : t) 
    | ( a + 1 == x && b == y) = True -- right
	| ( a - 1 == x && b == y) = True -- left
	| ( b + 1 == y && a == x) = True -- up
	| ( b - 1 == y && a == x) = True -- down 
	| otherwise = adjacentWhite (M (a,b)) t

adjacentWhite (M (a,b)) ((Peg (x,y) B) : t) = adjacentWhite (M (a,b)) t


--c)
isGoal :: Board -> Bool
isGoal [] = True
isGoal (Peg (x,y) c : t) 
    | c == B = False 
    | otherwise = isGoal t

	
--d)

showPossibleNextStates:: Board -> [State]
showPossibleNextStates [] = []
showPossibleNextStates board 
   | isGoal board == True = error " No Possible States Exist." 
   | otherwise = createStateFromMove board (generatePossibleMoves board board)

	
createStateFromMove :: Board -> [Move] -> [State]
createStateFromMove _ [] = []
createStateFromMove board (p:t) = S p (updateBoard p board) : createStateFromMove board t


generatePossibleMoves :: Board -> Board -> [Move]
generatePossibleMoves [] b = [] 
generatePossibleMoves (Peg (x,y) c : t)  b 
    | isValidMove (M (x,y)) b== True = M (x,y) : generatePossibleMoves t b
	| otherwise = generatePossibleMoves t b


updateBoard :: Move -> Board -> Board
updateBoard (M (a,b)) board = map updatePeg board
    where updatePeg (Peg h c ) = Peg h (if h == (a, b) then W else c)
	
	