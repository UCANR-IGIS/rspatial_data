## If you see smiley, it means the working directory is set correctly!

load("./data/test_pts.RData")
plot(pts[[1]], asp=1, pch=16, cex=0.5, type="l", col="red", lwd=2)
invisible(sapply(pts[2:4], points, asp=1, pch=16, cex=0.5, type="l"))

