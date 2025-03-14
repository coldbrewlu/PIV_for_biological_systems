macro "Batch Process: Contrast & Despeckle" {
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

            // Apply Contrast Enhancement
            run("Enhance Contrast", "saturated=0.35");

            // Apply Noise Reduction (Despeckle)
            run("Despeckle");
			
			 // Apply Bandpass Filter (Modify parameters as needed)
            run("Bandpass Filter...", "filter_large=40 filter_small=1 suppress=None tolerance=5 autoscale saturate");
            
            // Save the processed image in the output folder
            savePath = outputDir + replace(fileName, ".tif", "_processed.tif");
            saveAs("Tiff", savePath);
            print("Processed: " + savePath);

            // Close the image to free memory
            close();
        }
    }

    print("Batch processing completed. Files saved in: " + outputDir);
}
