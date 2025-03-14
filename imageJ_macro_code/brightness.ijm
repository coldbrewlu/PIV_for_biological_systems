// Batch Adjust Brightness for TIFF Images in ImageJ

// Select input and output directories
inputDir = getDirectory("Select Input Folder");
outputDir = getDirectory("Select Output Folder");

if (inputDir == "" || outputDir == "") {
    exit("No folder selected. Exiting...");
}

// Define brightness adjustment factor (modify as needed)
brightnessOffset = 15000;  // Increase brightness by 50 intensity units

// Get list of all TIFF files in the input directory
list = getFileList(inputDir);

for (i = 0; i < list.length; i++) {
    if (endsWith(list[i], ".tif")) {
        open(inputDir + list[i]);  // Open image
        
        run("Select All");  // Select the whole image
        run("Add...", "value=" + brightnessOffset);  // Adjust brightness
        
        saveAs("Tiff", outputDir + list[i]);  // Save modified image
        close();  // Close the image
    }
}

print("Batch brightness adjustment completed. Modified images saved in: " + outputDir);
