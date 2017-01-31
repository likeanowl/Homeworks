module Expression

type Expr =
    | Number of int
    | Addition of Expr * Expr
    | Multiplication of Expr * Expr
    | Division of Expr * Expr
    | Mod of Expr * Expr
    | Subtraction of Expr * Expr