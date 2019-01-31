RPHHnet <- function(Node_connection_within_household, 
            Node_connection_between_household,
            fname){
  #Dissolve HH intp table of HHs and members:
  H <- Node_connection_within_household
  H1 <- H[,1:3]
  H2 <- H[,4:6]
  colnames(H1) <- c('node', 'c1', 'c2')
  colnames(H2) <- c('node', 'c1', 'c2')
  Hfull <- rbind(H1,H2)
  
  Hlocs <- unique(Hfull[, c('c1', 'c2')])
  Hlocs[, 'hh'] <- 1:nrow(Hlocs)
  
  Hall <- merge(Hfull, Hlocs, by=c('c1','c2'))
  Hindex <- Hall[, c('node', 'hh')]
  Hindex <- unique(Hindex)#node and household index
  #Hindex <- Hindex[order(Hindex$node), ] 
  
  maxind <- max(Hindex$node)
  v1 <- seq(1, maxind, 1)
  v2 <- rep(0, maxind)
  v <- data.frame(v1, v2)
  colnames(v) <- c('node', 'household')
  v$household[Hindex$node] <- Hindex$hh
  maxhh <- max(Hindex$hh)
  #Take care of hh size 1:
  hh1 <- which(v$household==0)
  lh1 <- length(hh1)
  if (lh1>0) {
    v$household[hh1] <- seq(maxhh+1, maxhh+lh1, 1)
  }
  #vdiff <- setdiff(Hindex$node, v)

  #Find links between HHs:
  W <- Node_connection_between_household
  #W1 <- W[, 1:3]
  #W2 <- W[, 4:6]
  #colnames(W1) <- c('node', 'c1', 'c2')
  #colnames(W2) <- c('node', 'c1', 'c2')
  
  X <- W[, c(1, 4)]
  X[, 1] <- v$household[X[, 1]]
  X[, 2] <- v$household[X[, 2]]
  
  write.csv(X, file='Hnet6.csv')
  
  #W1 <- merge(W1, Hindex, by='node')
  #W2 <- merge(W2, Hindex, by='node')
  #W1 <- merge(W1[, c('c1','c2')], Hlocs, by=c('c1', 'c2'))
  #W2 <- merge(W2[, c('c1','c2')], Hlocs, by=c('c1', 'c2'))
  
  #Wfull <- rbind(W1,W2)
  #Replace individual vale with HH value:
  #X <- unique(Wfull)
  #
  #For MFA:
  #Hnodes <- unique(Hfull)
  #HHlocations <- unique()
}

RPcombine <- function(Node_connection_within_household, 
                      Node_connection_between_household){
  require(Matrix)
  #
  within <- Node_connection_within_household[, c("V1", "V4")]
  between <- Node_connection_between_household[, c("I", "J")]
  colnames(within) <- c("I", "J")
  net <- rbind(within, between)
  #
  #Option to write CSV with (i,j) pairs:
  #write.csv(net, "gos5p5.csv")
  #
  #Create matrix
  #net <- net[-which(net[, 1]<net[, 2]), ]
  numNodes <- max(net)
  G <- sparseMatrix(net$I, net$J, x=1, dims=c(numNodes, numNodes), symmetric = TRUE)
  RPcombine <- G
}

RPcluster <- function(G,N){
  #Change/option to loop through N and output hist/stats for each value
  G@x[G@x>1] <- 1
  n <- nrow(G)
  #eps <- .01
  #bins <- seq(0, eps, 1)
  measureA <- matrix(list(), N, 1)
  measureB <- measureA
  measureA[[1, 1]] <- G
  measureB[[1, 1]] <- G
  A <- G
  B <- G
  X <- matrix(0, n, 1)
  #
  if(N==1){
    #Standard clustering:
    for (i in 1:n){
      vi <- A[i, ]
      vfind <- which(vi==1)
      lv <- length(vfind)
      Wi <- B[vfind, vfind]
      X[i, 1] <- sum(upper.tri(Wi, diag=FALSE))/(lv*(lv+1)/2)
    }
  }else{
    #N-clustering, N>=2
    for (i in 2:N){
      nextA <- A%*%G
      #nextA <- subset(nextA, select=-diag(nextA))
      diag(nextA) <- 0
      nextA@x[B@x==1] <- 0
      nextA@x[nextA@x>1] <- 1
      nextB <- B+nextA
      nextB@x[nextB@x>1] <- 1
      measureA[[i, 1]] <- nextA
      measureB[[i, 1]] <- nextB
      A <- nextA
      B <- nextB
    }
    Ax <- measureA[[N, 1]]
    #subset(Ax, select=-diag(Ax))
    diag(Ax) <- 0
    Bx <- measureB[[N, 1]]
    #subset(Bx, select=-diag(Bx))
    diag(Bx) <- 0
    B1 <- measureB[[1, 1]]
    BNm1 <- measureB[[N-1, 1]]
    for (i in 1:n){#N=1 - this loop with Bx=A - can't use BNm1
      vi <- Bx[i, ]
      vfind <- which(vi==1)
      lv <- length(vfind)
      Wi <- Bx[vfind, vfind]
      X[i, 1] <- sum(upper.tri(Wi, diag=FALSE))/(lv*(lv+1)/2)
    }
  }
  #Add outputs: X or histogram
  stats <- c(mean(X, na.rm=TRUE), var(X, na.rm=TRUE), quantile(X, c(0, .05, .25, .5, .75, .95, 1), na.rm=TRUE))
  RPcluster <- stats
}

#MATLAB: RPmclusterStats:
RPclusterSample <- function(G,mmax,sampleNumber){
  #Change/option to loop through N and output hist/stats for each value
  N <- mmax#Just in case - variable re-named
  G@x[G@x>1] <- 1
  n <- nrow(G)
  sampleN <- sample(n, sampleNumber, replace=FALSE)
  measureA <- matrix(list(), mmax, 1)
  measureB <- measureA
  measureA[[1, 1]] <- G
  measureB[[1, 1]] <- G
  A <- G
  B <- G
  X <- matrix(0, mmax, sampleNumber)
    #Standard clustering:
    for (i in 1:sampleNumber){
      samplei <- sampleN[i]
      vi <- A[samplei, ]
      vfind <- which(vi==1)
      lv <- length(vfind)
      Wi <- B[vfind, vfind]
      X[1, i] <- sum(Wi)/(lv*(lv-1))#sum(upper.tri(Wi, diag=FALSE))/(lv*(lv-1)/2)
    }
    #N-clustering, N>=2
  if (mmax>1){
  for (m in 2:mmax){
      nextA <- A%*%G
      #nextA <- subset(nextA, select=-diag(nextA))
      diag(nextA) <- 0
      nextA@x[B@x==1] <- 0
      nextA@x[nextA@x>1] <- 1
      nextB <- B+nextA
      nextB@x[nextB@x>1] <- 1
      measureA[[m, 1]] <- nextA
      measureB[[m, 1]] <- nextB
      A <- nextA
      B <- nextB
    Ax <- A#measureA[[m, 1]]
    #subset(Ax, select=-diag(Ax))
    diag(Ax) <- 0
    Bx <- B#measureB[[m, 1]]
    #subset(Bx, select=-diag(Bx))
    diag(Bx) <- 0
    B1 <- measureB[[1, 1]]
    BNm1 <- measureB[[mmax-1, 1]]
    for (i in 1:sampleNumber){#N=1 - this loop with Bx=A - can't use BNm1
      samplei <- sampleN[i]
      vi <- Bx[i, ]
      vfind <- which(vi==1)
      lv <- length(vfind)
      Wi <- Bx[vfind, vfind]
      X[m, i] <- sum(Wi)/(lv*(lv-1))#sum(upper.tri(Wi, diag=FALSE))/(lv*(lv-1)/2)
    }
  }
  }
  #Add outputs: X or histogram
  #stats <- c(mean(X, na.rm=TRUE), var(X, na.rm=TRUE), quantile(X, c(0, .05, .25, .5, .75, .95, 1), na.rm=TRUE))
  #RPcluster <- stats
  return(X)
  write.csv(X, "renameMeAl6.csv")
}

#MATLAB: RPmclusterSample:
RPclusterSampleOnly <- function(G,mmax,sampleNumber){
  N <- mmax#Just in case - variable re-named
  G@x[G@x>1] <- 1
  n <- nrow(G)
  sampleN <- sample(n, sampleNumber, replace=FALSE)
  X <- matrix(0, mmax, sampleNumber)#MATLAB - transpose
  
  imvw1 <- t(sampleN)
  imvw2 <- rep(1, sampleNumber)
  Cv <- matrix(list(), mmax, 1)
  lengthC <- sampleNumber
  #Standard clustering:
  for (i in 1:sampleNumber){
    samplei <- sampleN[i]
    v1 <- mNbr(G, samplei, 1, samplei)
    Cv[[1, 1]] <- v1
    #
    Gred <- G[v1, v1]
    lv1 <- length(v1)
    X[1, i] <- lsum(upper.tri(Gred, diag=FALSE))/lv1/(lv1-1)*2 #ength(which(G@x[G@x!=0]))/lv1/(lv1-1)#
  }
  #N-clustering, N>=2
  if (mmax>1){
  for (m in 2:mmax){
  for (i in 1:lv){
    vi <- sampleN[i]
    vx <- Cv[[i, 1]]
    imvw2i <- imvw2[i]
    if (imvw2i<m){
      vm <- mNbr(G, vx, (m-imvw2i), vi)
      imvw2[i] <- m
      Cv[[i, 1]] <- vm
    } else{
      vm <- vx
    }
    vmx <- vm
    lvm <- length(vmx)
    links1 <- 0
    for (i in 1:lvm){#Parallelise here
     vmj <- vmx[j]
     if (imvw1 %in% vmj==TRUE){
       index <- which(imvw1==1)
       thisFar <- imvw2[index]
       vmjSoFar <- Cv[[index, 1]]
       if (thisFar<m){
         mNj <- mNbr(G, vmjSoFar, m-thisFar, vmj)
         imvw2[index] <- m
         Cv[[index, 1]] <- nMj
       } else{
         mNj <- Cv[[index, 1]]
       }
     } else{
       mNj <- mNbr(G, vmj, m, vmj)
       lengthC <- lengthC+1
       index <- lengthC
       imvw1(index) <- nmj
       imvw2[index] <- m
       Cv[[index, 1]] <- mNj
     }
     X[m, i] <- links1/lvm/(lvm-1)
    }
  }
  }
  }
  RPclusterSampleOnly <- X
}

#This is needed for RPclusterSampleOnly
mNbr <- function(G, vx1, mMore, vi){
  vx <- vx1
  G1 <- G[vx1, ]
  sumG1 <- colSums(G1)########
  v1 <- which(sumG1>0)
  v1 <- v1[v1!=vi]
  if (mMore>1){
    k=2
    while (k<=mMore){
      Gm <- G[vx, ]
      sumGm <- colSums(Gm)
      vm <- which(sumGm>0)
      vm <- union(vx, vm)
      vm <- setdiff(vm, vx)
      vx <- vm
      k=k+1
    }
    mNbr <- t(vx)
  }
}

RPmultiple <- function(G){
  n=2
  eps <- .01
  bins <- seq(0, eps, 1)
  #Hist here
  stats <- matrix(0, n, 9)
  for (i in 1:n){
    I <- 4+i
    g1 <- RPcluster(G, I)
    stats[I, ] <- g1
  }
  RPmultiple <- stats
}

RPplots <- function(stats){
  
}

if (FALSE){
  install.packages("Matrix")
  require(Matrix)
  source('~/RP network codes/RP_DHaw_functions.R', echo=TRUE)
  sampleNumber <- 100
  adjMat <- RPcombine(Node_connection_within_household, 
                     Node_connection_between_household)
  clusterStats <- RPclusterSample(adjMat, 2, sampleNumber)
}