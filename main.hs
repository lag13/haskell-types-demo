-- Prelude is a special module containing "essential" constructs like
-- the "String" type and the equality function (==). It is
-- automatically imported into any module you create so you can
-- actually program (imagine programming without (==)!). The reason
-- I've explicitly imported it here is so I can make my own Maybe type
-- (which is defined in Prelude) to show what its definition looks
-- like.
import Prelude (length, IO, String, Int, (==), head, fst, snd, tail, putStrLn, (++), show)

-- This is how to define a new "datatype" (hence the data keyword I
-- suppose). This is how the Maybe type is defined in Prelude. The
-- "Maybe a" part is the type and the "Just a" and "Nothing" are the
-- two possible values of that type. "Maybe a" lives in type-world and
-- "Just a" and "Nothing" live in value-world. The "a" in "Maybe a" is
-- called a "type variable" and whenever you see it you should think
-- "generic programming" because that's really what it is. For example
-- a generic stack in another language might look something like
-- "Stack<T>" where "T" can be any type. "Maybe a" is just like
-- "Stack<T>" in that sense.
--
-- Now onto the two possible values of the Maybe type. Here you get a
-- taste of how values in haskell can have "weird shapes" (or at least
-- thats how I think of it). In most other languages when you define a
-- new datatype you typically define a new struct/class. In that case
-- the struct sort of serves as the type and the ONLY possible value.
-- But here we've got a type with two possible values "Just a" and
-- "Nothing" (which are called "value constructors" and they're
-- basically functions). Nothing is a constant and you just write
-- "Nothing" whenever you need that value. The "a" in "Just a"
-- signifies that a value of type "a" will go "inside" of Just. So you
-- will write something like 'Just 10' or 'Just "Hello there"'. The
-- point is that a value of type Maybe can either be "Nothing"
-- signifying that nothing is there or it can be "Just a" signifying
-- that there is a value.
data Maybe a = Just a | Nothing

-- With the Maybe type at our disposal I believe this is the best
-- iteration of the lookup function. The returned value of type "Maybe
-- Int" feels more descriptive than Go's return value of (int, bool)
-- (because the relationship between int and bool is not enforced by
-- code, they are just two values that are getting returned and you as
-- a programmer have to be aware of their relationship). Here "Maybe
-- Int" REALLY signifies that you might get an integer or you might
-- not and its not possible to use a value if it doesn't exist (like
-- is possible in C and Go). Note that this function could be written
-- more "nicely" with pattern matching but I thought this would be
-- more accessible to people unfamaliar with Haskell.
lookup :: String -> [(String, Int)] -> Maybe Int
lookup wantKey mapping =
  if length mapping == 0
  then Nothing
  else let firstPair = (head mapping)
           key = fst firstPair
           value = snd firstPair
       in if wantKey == key
          then Just value
          else lookup wantKey (tail mapping)

printValueIfKeyExists :: String -> [(String, Int)] -> IO ()
printValueIfKeyExists key mapping =
  case lookup key mapping of
    Just value -> putStrLn ("at key \"" ++ key ++ " the value is: " ++ show value)
    Nothing -> putStrLn ("there is no value for key \"" ++ key ++ "\"")

main :: IO ()
main = do
  let mapping = [ ("hello-world", 1)
                , ("meaning-of-life", 42)
                , ("number-of-lotr-rings", 20)
                , ("num-wheel-of-time-books", 14)
                ]
  printValueIfKeyExists "hello-world" mapping
  printValueIfKeyExists "does-not-exist" mapping
  printValueIfKeyExists "meaning-of-life" mapping
  -- -- Here is where we see that using our lookup function with it's
  -- -- Maybe return type is safer and will prevent bugs from happening
  -- -- because if you do not account for both the "Just a" and "Nothing"
  -- -- case then compilation will fail (assuming you provide the -Wall
  -- -- and -Werror arguments which you probably should anyway).
  -- let key = "does-not-exist"
  -- case lookup key mapping of
  --   Just value -> putStrLn ("at key \"" ++ key ++ " the value is: " ++ show value)
