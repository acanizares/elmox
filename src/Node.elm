module Node exposing (..)

-- STATEMENTS
-- "Block      : List<Stmt> statements",
-- "Expression : Expr expression",
-- "Function   : Token name, Expr.Lambda lambda",
-- "If         : Expr condition, Stmt thenBranch, Stmt elseBranch",
-- "Print      : Expr expression",
-- "Return     : Token keyword, Expr value",
-- "Var        : Token name, Expr initializer",
-- "While      : Expr condition, Stmt body",
-- "Break      : "

type Stmt 
  = Block BlockStmt
  | Expr ExprStmt
  | Function FunctionStmt
  | If IfStmt
  | Print PrintStmt
  | Return ReturnStmt
  | Var VarStmt
  | While WhileStmt
  | Break BreakStmt

type BlockStmt
  = BlockStmt (List Stmt)

type ExprStmt
  = ExprStmt Expr

type FunctionStmt 
  = FunctionStmt { name : Token, lambda : LambdaExpr }

type IfStmt
  = IfStmt { cond : Expr, thenBranch : Stmt, elseBranch : Stmt }

type PrintStmt
  = PrintStmt Expr

type ReturnStmt 
  = ReturnStmt { keyword : Token, value : Expr }

type VarStmt
  = VarStmt { name : Token, initializer : Expr}

type WhileStmt
  = WhileStmt { cond : Expr, body : Stmt }

type BreakStmt
  = BreakStmt

-- EXPRESSIONS
-- "Assign      : Token name, Expr value",
-- "Conditional : Expr cond, Expr thenBranch, Expr elseBranch",
-- "Binary      : Expr left, Token operator, Expr right",
-- "Call        : Expr callee, Token paren, List<Expr> arguments",
-- "Grouping    : Expr expression",
-- "Literal     : Object value",
-- "Logical     : Expr left, Token operator, Expr right",
-- "Unary       : Token operator, Expr right",
-- "Variable    : Token name",
-- "Lambda      : List<Token> params, List<Stmt> body"

type Expr 
  = Assign AssignExpr
  | Conditional ConditionalExpr
  | Binary BinaryExpr
  | Call CallExpr
  | Grouping GroupingExpr
  | Literal LiteralExpr
  | Logical LogicalExpr
  | Unary UnaryExpr
  | Variable VariableExpr
  | Lambda LambdaExpr

type AssignExpr 
  = AssignExpr { name : Token, value : Expr }

type ConditionalExpr
  = ConditionalExpr { cond : Expr, thenBranch : Expr, elseBranch : Expr }

type BinaryExpr 
  = BinaryExpr { left : Expr, operator : Token, right : Expr }

type CallExpr
  = CallExpr { callee : Expr, paren : Token, args : List Expr }

type GroupingExpr
  = GroupingExpr Expr

type LiteralExpr
  = Int Int
  | Float Float
  | String String
  | Bool Bool
  | Nil

type LogicalExpr
  = LogicalExpr { left : Expr, operator : Token, right : Expr }

type UnaryExpr
  = UnaryExpr { operator : Token, right : Expr }

type VariableExpr
  = VariableExpr Token

type LambdaExpr
  = LambdaExpr { params : List Token, body : List String }

type alias Token = String