module Main where

import Foreign
import Foreign.C

data GVContext

foreign import ccall gvContext :: IO (Ptr GVContext)

foreign import ccall gvcVersion :: Ptr GVContext -> IO CString

main :: IO ()
main = do
  c <- gvContext
  putStrLn $ "context lives at: " ++ show c
  v <- peekCString =<< gvcVersion c
  putStrLn $ "context version: " ++ v
