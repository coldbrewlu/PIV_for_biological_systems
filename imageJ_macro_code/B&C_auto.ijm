macro "Batch Process: Auto Brightness & Contrast" {
    // Select the input folder
    inputDir = getDirectory("Select the folder containing images");

    // Select the output folder
    outputDir = getDirectory("Select the folder to save processed images");

    // Get a list of all image files in the folder
    fileList = getFileList(inputDir);

    if (fileList.length == 0) {
        exit("No images found in the selected folder.");
    }

    // Process each image in the folder
    for (i = 0; i < fileList.length; i++) {
        fileName = fileList[i];

        // Process only image files (e.g., .tif, .jpg, .png)
        if (endsWith(fileName, ".tif") || endsWith(fileName, ".png") || endsWith(fileName, ".jpg")) {
            fullPath = inputDir + fileName;

            // Open the image
            open(fullPath);

            // Apply Auto Brightness & Contrast
            run("Enhance Contrast", "saturated=0.35");  // Auto B&C

            // Save the processed image in the output folder
            savePath = outputDir + replace(fileName, ".tif", "_BC_auto.tif");
            saveAs("Tiff", savePath);
            print("Processed: " + savePath);

            // Close the image to free memory
            close();
        }
    }

    print("Batch processing completed. Files saved in: " + outputDir);
}
