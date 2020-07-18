## Test Working Directory

## Set the working directory to the location of this file.

## From the RStudio menu, select:
## Session >> Set Working Directory >> To Source File Location

load("./data/test_pts.RData")

plot(pts[[1]], asp=1, pch=16, cex=0.5, type="l", col="red", lwd=2, main="If you can see the picture,\nyour working directory is set correctly!")

invisible(sapply(pts[2:4], points, asp=1, pch=16, cex=0.5, type="l"))
