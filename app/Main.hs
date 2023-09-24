module Main where

import Data.Word (Word8)
import qualified Foreign.Marshal.Alloc as A
import Foreign.Ptr (Ptr, plusPtr)
import Foreign.Storable (peek, poke)

main :: IO ()
main = mempty

foreign export ccall idInt :: Int -> Int

idInt :: Int -> Int
idInt = id


foreign export ccall mallocBytes :: Int -> IO (Ptr Word8)

mallocBytes :: Int -> IO (Ptr Word8)
mallocBytes = A.mallocBytes

foreign export ccall freeBytes :: Ptr Word8 -> IO ()

freeBytes :: Ptr Word8 -> IO ()
freeBytes = A.free

foreign export ccall draw :: Int -> Int -> Int -> Ptr Word8 -> IO ()

draw :: Int -> Int -> Int -> Ptr Word8 -> IO ()
draw width height time ptr = mempty