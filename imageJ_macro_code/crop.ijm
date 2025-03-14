// Batch Crop Macro for TIFF Images in ImageJ
// Prompts user to select input and output folders, then crops all TIFF images

// Prompt user to select input and output directories
inputDir = getDirectory("Select Input Folder");
outputDir = getDirectory("Select Output Folder");

if (inputDir == "" || outputDir == "") {
    exit("No folder selected. Exiting...");
}

// Define crop region (Modify these values based on your required crop area)
x_start = 146;  // X-coordinate of top-left corner
y_start = 110;  // Y-coordinate of top-left corner
crop_width = 897-146;   // Width of cropped region
crop_height = 602-110;  // Height of cropped region

// Get list of all TIFF files in the input directory
list = getFileList(inputDir);

for (i = 0; i < list.length; i++) {
    if (endsWith(list[i], ".tif")) {
        open(inputDir + list[i]);  // Open image
        makeRectangle(x_start, y_start, crop_width, crop_height);  // Define crop ROI
        run("Crop");  // Perform crop
        saveAs("Tiff", outputDir + list[i]);  // Save cropped image
        close();  // Close the image
    }
}

print("Batch cropping completed. Cropped images saved in: " + outputDir);
