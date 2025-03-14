dir = getDirectory("Choose Directory");
list = getFileList(dir);
run("Image Sequence...", "open=" + dir + " sort");
run("Images to Stack", "name=Stack title=[] use");
saveAs("Tiff", dir + "stacked.tif");
