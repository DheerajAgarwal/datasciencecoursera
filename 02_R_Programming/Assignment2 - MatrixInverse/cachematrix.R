# R Programming - Assignment 2 - Invert a matrix

## PART ONE - makeCacheMatrix
# 1. Set the value of the matrix
# 2. Get the value of the matrix
# 3. Set the value of the inverse
# 4. Get the value of the inverse
makeCacheMatrix <- function(a = matrix()) {
        # invert will store the inversed matrix (cached)
        invert <- NULL

        # 1. Set the value of the matrix
        set <- function(b) {
                a <<- b
                invert <<- NULL
        }

        # 2. Get the value of the matrix
        get <- function() a

        # 3. Set the value of the inverse
        setinv <- function(inverse) invert <<- inverse

        # 4. Get the value of the inverse
        getinv <- function() invert

        # Return matrix
        list(set = set, get = get, setinv = setinv, getinv = getinv)
}


## PART TWO - cacheSolve
# Derive the inverse of a matrix. If already derived, fetch from Cache.
# Else recompute

cacheSolve <- function(a, ...) {
        invert <- a$getinv()

        # check if the inverse is already cached
        if (!is.null(invert)) {
                message("USER MESSAGE: Fetching data from cache memory as the results already computed")

                # return inverted matrix from cache. End of function.
                return(invert)
        }

        #  else if the inverted matrix needs to be calculated
        calc <- a$get()
        invert <- solve(calc, ...)

        # then cache the inverse
        a$setinv(invert)

        # and return inverted matrix
        invert
}

# HOW TO USE THIS FILE
# 1. Source the file into the console.
# 2. Create 'a' square matrix (with equal rows and cols)
# 3. Set another object 'b' <- makeCacheMatrix(a)
# 4. Get the value of 'b' by using b$get()
# 5. Pass 'b' as an argument in cacheSolve()
# 6. If the function works and matrix is invertible,
        #get the defined user message and an inverted matrix
#7. If the function works but matrix is not invertible,
        # console may throw an error about singularity
#8. If the function is incorrect
        # GOD knows what message will come up.

