{-|
Module       : HW3
Description  : Introduction to Haskell
Maintainer   : CS 131, Programming Languages
-}
module HW3 where

--------------------------------------------------------------------------------  
-- Lists --
--------------------------------------------------------------------------------  


-- | Returns every other element of a list, starting with the first (zero-th)
evens :: [a] -> [a]
evens [] = []
evens [x] = [x]
evens (x1:x2:xs) = x1 : evens xs


-- | Returns every other element of a list, starting with the second (one-th)
odds :: [a] -> [a]
odds [] = []
odds [x] = []
odds [x1, x2] = [x2]
odds (x1:x2:xs) = x2 : odds xs



-- | Partitions a list of elements into a tuple of two lists, where the first
--   item in the tuple is a list of the elements at even-numbered indices and
--   the second item in the tuple is a list of the elements at odd-numbered 
--   indices
evenodds :: [a] -> ([a], [a])
evenodds [] = ([], [])
evenodds [x] = ([x], [])
evenodds (x1:x2:xs) = 
    let (l1, l2) = evenodds xs
    in  (x1:l1, x2:l2)


-- | The inverse of 'evenodds'
riffle :: ([a], [a]) -> [a]
riffle ([], []) = []
riffle ([x], []) = [x]
riffle (a1:as, b1:bs) = 
    let list = riffle (as, bs)
    in (a1:b1:list)
    


--------------------------------------------------------------------------------
-- Higher-order functions, currying and uncurrying
-- 
-- Functions curry and uncurry are already pre-defined in Haskell,
-- which is why you need to call your version 'myCurry' and 'myUncurry'.
--------------------------------------------------------------------------------


-- | Converts an uncurried function to a curried function
myCurry :: ( (a,b) -> c ) -> ( a -> b -> c )
myCurry f a b = f (a,b)


-- | Converts a curried function to an uncurried function
myUncurry :: ( a -> b -> c ) -> ( (a,b) -> c )
myUncurry x (a, b) = x a b


-- | A curried version of 'riffle'
riffle2 :: [a] -> [a] -> [a]
riffle2 = myCurry riffle


--------------------------------------------------------------------------------
-- Datatypes
--------------------------------------------------------------------------------

-- [define a datatype for TreeOfInt here]
data TreeOfInt = Empty
               | Branch Int TreeOfInt TreeOfInt
    deriving (Show, Eq)



-- | Returns the minimum element of the tree. Gives an error if the tree is empty
least :: TreeOfInt -> Int
least Empty = error "tree is empty"
least (Branch int Empty _) = int
least (Branch _ left _) = least left


--------------------------------------------------------------------------------
-- Stack machines
--------------------------------------------------------------------------------

-- | Arithmetic expressions
data Expr = Num   Double        -- ^ Represents a floating-point value
          | BinOp Expr Op Expr  -- ^ Represents a binary operation
    deriving (Show, Eq)


-- | Binary operators
data Op = PlusOp | MinusOp | TimesOp | DivOp
    deriving (Show, Eq)


-- | Stack instructions
data StackInstr = Push Double  -- ^ Push a number on the stack
                | DoOp Op      -- ^ Perform an operation, using the top two stack values
                | Swap         -- ^ Swap the top two stack values
    deriving (Show, Eq)


-- A stack is represented as a list of floating-point numbers;
-- the head of the list is the top of the stack.
type StackValue = Double
type Stack = [StackValue]


-- | Evaluate a list of stack instructions, given an initial stack
evalRPN :: [StackInstr] -> Stack -> StackValue
evalRPN [] (s1:ss) = s1
evalRPN (Push x: xs) stack = evalRPN xs (x:stack)
evalRPN (DoOp x: xs) (s1:s2:stack) = evalRPN xs (calc x s1 s2: stack)
    where 
        calc :: Op -> Double -> Double -> Double
        calc PlusOp a b = b+a 
        calc MinusOp a b = b-a 
        calc TimesOp a b = b*a 
        calc DivOp a b = b/a
evalRPN (Swap: xs) (s1:s2:stack) = evalRPN xs (s2:s1:stack)


-- | Translate an expression to stack operations
toRPN :: Expr -> [StackInstr]
toRPN (Num x) = [Push x]
toRPN (BinOp n1 op n2) = toRPN n1 ++ toRPN n2 ++ [DoOp op] 


-- | Minimize the stack depth
toRPNopt :: Expr -> ([StackInstr], Integer)
toRPNopt (Num x) = ([Push x], 1)
toRPNopt (BinOp n1 op n2) = 
    let (stack1, depth1) = toRPNopt n1
        (stack2, depth2) = toRPNopt n2
    in if (max depth1 (1+depth2)) > (max depth2 (1+depth1)) 
       then (stack2 ++ stack1 ++ [Swap, DoOp op], (max depth2 (1+depth1)))
       else (stack1 ++ stack2 ++ [DoOp op], (max depth1 (1+depth2)))


--------------------------------------------------------------------------------
-- Example expressions. Define these as described in the assignment.
--------------------------------------------------------------------------------

depth3 :: Expr
depth3 = BinOp (BinOp (Num 1) MinusOp (Num 2)) DivOp (BinOp (Num 3) PlusOp (Num 4))
    
depth4 :: Expr
depth4 = BinOp depth3 DivOp depth3