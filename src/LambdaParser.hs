module LambdaParser where

import Text.ParserCombinators.ReadP
import Data.Char (isAlpha, isAlphaNum, isAscii, isPunctuation)
import Data.Foldable
import Control.Arrow ((>>>))
import Control.Monad
import Terms

test :: ReadP a -> String -> [(a, String)]
test p s = readP_to_S p s

runparse :: ReadP a -> String -> Maybe a
runparse p s = case readP_to_S (p <* skipSpaces <* eof) s of
  [(v,"")] -> Just v
  _        -> Nothing

stripWS :: ReadP a -> ReadP a
stripWS = (skipSpaces *>)


token :: String -> ReadP String
token = stripWS . string 


lambda, dot, varname :: ReadP String
lambda = token "\\"
dot = token "."
varname = (:) <$> stripWS (satisfy isAlpha) <*> munch ((&&) <$> isAlpha <*> (not . isPunctuation))



parens :: ReadP a -> ReadP a
parens =  (token "(" *>) >>> (<* token ")")


varP, absP, appP, term :: ReadP Term
term = absP <++ appP <++ varP <++ parens term
varP = Var <$> varname
absP = Abstraction <$> (lambda *> varname <* dot) <*> term
appP = chainl1 nonApp (skipSpaces *> pure Application)
  where nonApp = absP +++ varP +++ parens term



