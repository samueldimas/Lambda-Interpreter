module TestingData where

import Terms

testTerm0 = Application
             (Abstraction "x" $ Application (Var "x") (Var "x"))
             (Abstraction "y" $ Var "y")


testTerm1 = Abstraction "x" (Application (Var "x") (Var "y"))


omega = (Application
          (Abstraction "x" (Application (Var "x") (Var "x")))
            (Abstraction "y" (Application (Var "y") (Var "y")))
        )


  
c0 = (Abstraction "s" (Abstraction "z" (Var "z")))
succ' = (Abstraction "n"
         (Abstraction "s"
          (Abstraction "z"
           (Application
            (Var "s")
            (Application (Application (Var "n") (Var "s")) (Var "z"))))))



c1 = eval (Application succ' c0)
c2 = eval (Application succ' c1)
c3 = eval (Application succ' c2)



plus = (Abstraction "m"
        (Abstraction "n"
         (Application
           (Application (Var "m") succ')
           (Var "n"))))
          
times = (Abstraction "m"
          (Abstraction "n"
           (Application
            (Application (Var "m") (Application plus (Var "n"))) c0)
          )
        )


pow = (Abstraction "b"
       (Abstraction "e"
        (Application (Var "e") (Var "b"))
       )
      )        
         
prettyPrintSubTest :: Symbol -> Term -> Term -> IO ()
prettyPrintSubTest s t1 t2 = do
    putStrLn $ "["++s++"->"++(show t1)++"]"++(show t2)++" => "++(show $ subst s t1 t2)    


mainz :: IO ()
mainz = do
  putStrLn $ show c1

  -- putStrLn "(pg 70)"  
  -- let t1 = (Abstraction "z" (Application (Var "z") (Var "w")))
  -- let t2 = (Abstraction "y" (Var "x"))
  -- prettyPrintSubTest "x" t1 t2

  -- putStrLn("\n(pg 70)")
  -- prettyPrintSubTest "x" (Var "y") (Abstraction "x" (Var "x"))  
    

  
  -- let t1 = (Abstraction "z" (Application (Var "z") (Var "w")))
  -- let t2 = (Abstraction "y" (Var "x"))

  -- prettyPrintSubTest "x" t1 t2
    
  -- prettyPrintSubTest "x" (Var "z") (Abstraction "z" (Var "x"))
  
  -- prettyPrintSubTest "y" (Var "x") (Application (Var "y") (Var "z"))
  -- prettyPrintSubTest "y" (Var "x") (Var "y") 


  -- prettyPrintSubTest "y" (Var "z") (Abstraction "x" (Application (Var "x") (Var "y")))
  -- -- let ta = (Application (Var "y") (Var "z"))
  -- -- let tb = Abstraction "y" (Application (Var "x") (Var "y"))
  -- -- putStrLn $ show $ subst "x" ta tb

  
  -- let t1 = (Application (Var "f") (Var "y"))
  -- let t2 = (Abstraction "y"
  --           (Application
  --            (Abstraction "f" (Application (Var "f") (Var "x")))
  --            (Var "y")
  --           ))
           
  -- putStrLn $ show t1
  -- putStrLn $ show t2
  -- prettyPrintSubTest "x" t1 t2
