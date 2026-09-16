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
evens = undefined


-- | Returns every other element of a list, starting with the second (one-th)
odds :: [a] -> [a]
odds = undefined


-- | Partitions a list of elements into a tuple of two lists, where the first
--   item in the tuple is a list of the elements at even-numbered indices and
--   the second item in the tuple is a list of the elements at odd-numbered 
--   indices
evenodds :: [a] -> ([a], [a])
evenodds = undefined


-- | The inverse of 'evenodds'
riffle :: ([a], [a]) -> [a]
riffle = undefined


--------------------------------------------------------------------------------
-- Higher-order functions, currying and uncurrying
-- 
-- Functions curry and uncurry are already pre-defined in Haskell,
-- which is why you need to call your version 'myCurry' and 'myUncurry'.
--------------------------------------------------------------------------------


-- | Converts an uncurried function to a curried function
myCurry :: ( (a,b) -> c ) -> ( a -> b -> c )
myCurry = undefined


-- | Converts a curried function to an uncurried function
myUncurry :: ( a -> b -> c ) -> ( (a,b) -> c )
myUncurry = undefined


-- | A curried version of 'riffle'
riffle2 :: [a] -> [a] -> [a]
riffle2 = myCurry riffle


--------------------------------------------------------------------------------
-- Datatypes
--------------------------------------------------------------------------------

-- [define a datatype for TreeOfInt here]



-- | Returns the minimum element of the tree. Gives an error if the tree is empty
-- least :: TreeOfInt -> Int
-- ... your implementation here


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
evalRPN = undefined


-- | Translate an expression to stack operations
toRPN :: Expr -> [StackInstr]
toRPN = undefined


-- | Minimize the stack depth
toRPNopt :: Expr -> ([StackInstr], Integer)
toRPNopt = undefined


--------------------------------------------------------------------------------
-- Example expressions. Define these as described in the assignment.
--------------------------------------------------------------------------------

depth3 :: Expr
depth3 = undefined

depth4 :: Expr
depth4 = undefined

