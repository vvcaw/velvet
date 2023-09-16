module Hello where

import Foreign.Marshal.Alloc
import Foreign.Ptr (Ptr, plusPtr)
import Data.Word (Word8)
import Foreign.Storable (peek, poke)

foreign export ccall fib :: Int -> Int
fib :: Int -> Int
fib a = a * a

foreign export ccall readByte :: Ptr Word8 -> IO ()
readByte :: Ptr Word8 -> IO ()
readByte wp = do
    val <- peek wp
    putStrLn $ "Read byte: " ++ (show val)

foreign export ccall writeByte :: Ptr Word8 -> Word8 -> IO ()
writeByte :: Ptr Word8 -> Word8 -> IO ()
writeByte wp toWrite = do
    poke wp toWrite
    putStrLn $ "Wrote byte: " ++ (show toWrite)