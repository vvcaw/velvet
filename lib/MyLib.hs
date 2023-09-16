module MyLib (someFunc) where

foreign export ccall fib :: Int -> Int
fib :: Int -> Int
fib a = a * a

main :: IO ()
main = mempty

someFunc :: IO ()
someFunc = putStrLn "someFunc"
